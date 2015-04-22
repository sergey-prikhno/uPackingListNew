package com.Application.robotlegs.views.list {
	import com.Application.robotlegs.model.vo.VOList;
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.services.categories.EventServiceCategories;
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.MediatorViewAbstract;
	
	public class MediatorViewList extends MediatorViewAbstract {		
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
		public function MediatorViewList() 	{
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function onRegister():void{	
			super.onRegister();
			
			addContextListener(EventServiceCategories.UPDATED, _handlerUpdated, EventServiceCategories);
			
			addViewListener(EventViewList.BACK_TO_MAIN_SCREEN, _handlerBacktoMainScreen, EventViewList);
			addViewListener(EventViewAbstract.UPDATE_DB_PACKED_ITEM, _handlerUpdateItemDB, EventViewAbstract);
			
			dispatch(new EventViewAbstract(EventViewAbstract.GET_MODEL_LIST_DATA, false, null, _setPackedListItems));
		}
		
		
		override public function onRemove():void {
			super.onRemove();
				
			removeContextListener(EventServiceCategories.UPDATED, _handlerUpdated, EventServiceCategories);
			
			removeViewListener(EventViewAbstract.UPDATE_DB_PACKED_ITEM, _handlerUpdateItemDB, EventViewAbstract);
			removeViewListener(EventViewList.BACK_TO_MAIN_SCREEN, _handlerBacktoMainScreen, EventViewList);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get view():ViewList{
			return ViewList(viewComponent);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		private function _setPackedListItems(value:Vector.<VOPackedItem>,pTableName:VOList):void {
			view.items = value;
			view.tableName = pTableName;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------				
		
		private function _handlerUpdated(event:EventServiceCategories):void{
			view.update(VOPackedItem(event.data));			
		}
		
		
		private function _handlerUpdateItemDB(event:EventViewAbstract):void{
			event.stopPropagation();						
			dispatch(new EventViewAbstract(EventViewAbstract.UPDATE_DB_PACKED_ITEM, false, event.data));
		}
		
		private function _handlerBacktoMainScreen(event:EventViewList):void{
			model.currentTableName = null;
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