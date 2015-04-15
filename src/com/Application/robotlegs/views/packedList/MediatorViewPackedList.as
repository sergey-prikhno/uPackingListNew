package com.Application.robotlegs.views.packedList {
	import com.Application.robotlegs.model.vo.VOList;
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.services.categories.EventServiceCategories;
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.MediatorViewAbstract;
	
	public class MediatorViewPackedList extends MediatorViewAbstract {		
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
		public function MediatorViewPackedList() {
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
			addContextListener(EventServiceCategories.REMOVED, _handlerRemoved, EventServiceCategories);
			
			addViewListener(EventViewAbstract.REMOVE_PACKED_ITEM, _handlerRemoveItemDB, EventViewAbstract);			
			addViewListener(EventViewAbstract.UPDATE_DB_PACKED_ITEM, _handlerUpdateItemDB, EventViewAbstract); 
			addViewListener(EventViewAbstract.UPDATE_DB_ORDER_INDEXES, _handlerUpdateItemOrderIndexDB, EventViewAbstract);
			
			dispatch(new EventViewAbstract(EventViewAbstract.GET_MODEL_LIST_DATA, false, null, _setPackedListItems));
		}
		
		
		override public function onRemove():void {
			super.onRemove();
			
			removeContextListener(EventServiceCategories.UPDATED, _handlerUpdated, EventServiceCategories);
			removeContextListener(EventServiceCategories.REMOVED, _handlerRemoved, EventServiceCategories);
			
			removeViewListener(EventViewAbstract.REMOVE_PACKED_ITEM, _handlerRemoveItemDB, EventViewAbstract);		
			removeViewListener(EventViewAbstract.UPDATE_DB_PACKED_ITEM, _handlerUpdateItemDB, EventViewAbstract);
			removeViewListener(EventViewAbstract.UPDATE_DB_ORDER_INDEXES, _handlerUpdateItemOrderIndexDB, EventViewAbstract);
			
		}
		
	
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get view():ViewPackedList{
			return ViewPackedList(viewComponent);
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
		private function _handlerUpdateItemDB(event:EventViewAbstract):void{
			event.stopPropagation();						
			dispatch(new EventViewAbstract(EventViewAbstract.UPDATE_DB_PACKED_ITEM, false, event.data));
		}
		
		private function _handlerUpdateItemOrderIndexDB(event:EventViewAbstract):void{
			event.stopPropagation();						
			dispatch(new EventViewAbstract(EventViewAbstract.UPDATE_DB_ORDER_INDEXES, false, event.data));
		}
		
		private function _handlerRemoveItemDB(event:EventViewAbstract):void{
			event.stopPropagation();						
			dispatch(new EventViewAbstract(EventViewAbstract.REMOVE_PACKED_ITEM, false, event.data));
		}
		
		private function _handlerUpdated(event:EventServiceCategories):void{
			view.update(VOPackedItem(event.data));			
		}
		
		private function _handlerRemoved(event:EventServiceCategories):void{
			view.removed(VOPackedItem(event.data));
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