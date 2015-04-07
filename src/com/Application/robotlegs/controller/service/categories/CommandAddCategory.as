package com.Application.robotlegs.controller.service.categories {
	import com.Application.robotlegs.model.IModel;
	import com.Application.robotlegs.model.vo.VOAddNewItem;
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.services.categories.IServiceCategories;
	import com.Application.robotlegs.views.EventViewAbstract;
	
	import org.robotlegs.starling.mvcs.Command;
	
	public class CommandAddCategory extends Command {		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		[Inject]
		public var event:EventViewAbstract;
		
		[Inject]
		public var service:IServiceCategories;
		
		[Inject]
		public var model:IModel;	
		
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
		public function CommandAddCategory() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		//---------------------------------------------------------------------------------------------------------
		override public function execute():void{
			
			var pItem:VOAddNewItem = VOAddNewItem(event.data);
						
				pItem.item.orderIndex = _getOrderIndex();
				pItem.item.item_id = _getItemId();
					
			
			service.insert(pItem.item,model.currentTableName.table_name);			
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
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
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
		private function _getOrderIndex():int{
			var pOrder:int = 1;
						
			for(var i:int = 0; i<model.currentCategories.length; i++){
				var pItem:VOPackedItem = VOPackedItem(model.currentCategories[i]);
				
					if(!pItem.isChild){						
						if(pItem.orderIndex > pOrder){
							pOrder = pItem.orderIndex;
						}						
					}
				
			}
			
			pOrder++
			return pOrder;
		}
		
		
		private function _getItemId():int{
			var pOrder:int = 1;
			
			for(var i:int = 0; i<model.currentCategories.length; i++){
				var pItem:VOPackedItem = VOPackedItem(model.currentCategories[i]);
				
				if(!pItem.isChild){						
					if(pItem.item_id > pOrder){
						pOrder = pItem.item_id;
					}						
				}
				
			}
			
			pOrder++
			return pOrder;
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}