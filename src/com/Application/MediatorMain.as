package com.Application {

	import com.Application.robotlegs.model.EventModel;
	import com.Application.robotlegs.model.vo.VOAppSettings;
	import com.Application.robotlegs.model.vo.VOScreenID;
	import com.Application.robotlegs.services.categoriesDefault.EventServiceCategoriesDefault;
	import com.http.robotlegs.model.modelLoading.EventActorLoader;
	
	import org.robotlegs.starling.mvcs.Mediator;
	
	public class MediatorMain extends Mediator 	{		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function MediatorMain() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function onRegister():void {
			super.onRegister();
			
			addContextListener(EventActorLoader.LOADING_STARTED, _handlerLoadingEventService, EventActorLoader);
			addContextListener(EventActorLoader.LOADING_FINISHED, _handlerLoadingEventService, EventActorLoader);	
			  
			addContextListener(EventServiceCategoriesDefault.FIRST_CATEGORIES_LOADED, _handlerIinitDBComplete, EventServiceCategoriesDefault);
			addContextListener(EventModel.CHANGE_APP_SCREEN, _handlerChangeAppScrenn, EventModel);							

		}			
		
		
		override public function onRemove():void {
			super.onRemove();
			
			removeContextListener(EventActorLoader.LOADING_STARTED, _handlerLoadingEventService, EventActorLoader);
			removeContextListener(EventActorLoader.LOADING_FINISHED, _handlerLoadingEventService, EventActorLoader);
		
			removeContextListener(EventModel.CHANGE_APP_SCREEN, _handlerChangeAppScrenn, EventModel);	
			removeContextListener(EventServiceCategoriesDefault.FIRST_CATEGORIES_LOADED, _handlerIinitDBComplete, EventServiceCategoriesDefault);
		}		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get view():Main{
			return Main(viewComponent);
		}	
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerLoadingEventService(event:EventActorLoader):void{			
			
			if(event.type == EventActorLoader.LOADING_STARTED){
				view.addLoader();
			}
			
			if(event.type == EventActorLoader.LOADING_FINISHED){
				view.removeLoader();
			}			
		}		
		

		private function _handlerChangeAppScrenn(event:EventModel):void{
			view.changeScreen(VOScreenID(event.data));
		}
		
		private function _handlerIinitDBComplete(event:EventServiceCategoriesDefault):void{
			var pData:VOAppSettings = VOAppSettings(event.data);
			
			view.settings = pData;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}