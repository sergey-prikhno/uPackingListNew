package com.Application.robotlegs.views.main {
	import com.Application.robotlegs.model.vo.VOList;
	import com.Application.robotlegs.services.removeList.EventServiceRemoveList;
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.MediatorViewAbstract;
	
	public class MediatorViewMain extends MediatorViewAbstract {		
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
		
		private function _setLists(value:Vector.<VOList>):void {
			view.vectorLists = value;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function MediatorViewMain() 	{
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function onRegister():void{	
			super.onRegister();
						
			addViewListener(EventViewMain.SHOW_REMOVE_LIST_POPUP, _handlerShowRemoveListPopup, EventViewMain);
			addViewListener(EventViewMain.GET_SELECTED_LIST_DATA, _handlerGetSelectedListData, EventViewMain);
			
			addContextListener(EventServiceRemoveList.REMOVED_LIST_DB, _handlerUpdateRemovedList, EventServiceRemoveList);
			
			dispatch(new EventViewAbstract(EventViewAbstract.GET_CREATED_LISTS, false, null, _setLists));
		}
		
		
		override public function onRemove():void {
			super.onRemove();
					
			removeContextListener(EventServiceRemoveList.REMOVED_LIST_DB, _handlerUpdateRemovedList, EventServiceRemoveList);
			
			removeViewListener(EventViewMain.SHOW_REMOVE_LIST_POPUP, _handlerShowRemoveListPopup);
			removeViewListener(EventViewMain.GET_SELECTED_LIST_DATA, _handlerGetSelectedListData, EventViewMain);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get view():ViewMain{
			return ViewMain(viewComponent);
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
		
		private function _handlerUpdateRemovedList(event:EventServiceRemoveList):void{
			view.updateRemovedLists(VOList(event.data));
		}
		
		private function _handlerGetSelectedListData(event:EventViewMain):void{
			dispatch(new EventViewAbstract(EventViewAbstract.GET_CATEGORY_DATA, false, event.data));
		}
		
		private function _handlerShowRemoveListPopup(event:EventViewMain):void{
			dispatch(new EventViewMain(EventViewMain.SHOW_REMOVE_LIST_POPUP, false, event.data));
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