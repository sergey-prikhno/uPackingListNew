package com.Application.robotlegs.services.categoriesDefault {
	import com.Application.robotlegs.model.IModel;
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.probertson.data.SQLRunner;
	
	import flash.data.SQLResult;
	
	import org.robotlegs.starling.mvcs.Actor;
	
	public class ServiceCategoriesDefault extends Actor implements IServiceCategoriesDefault {						
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		[Inject]
		public var sqlRunner:SQLRunner;
		
		[Inject]
		public var model:IModel;		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		private var _isFirstLoad:Boolean = false;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ServiceCategoriesDefault() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function getCategoriesFirst():void {
			_isFirstLoad = true;
			sqlRunner.execute(LOAD_TABLE_ITEMS_SQL, null, load_result, VOPackedItem);			
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
		private function load_result(result:SQLResult):void {
			
			var pParent:Vector.<VOPackedItem> = new Vector.<VOPackedItem>;
			
			//get Parents
			for(var i:int=0;i<result.data.length;i++){
				var pResItem:VOPackedItem = VOPackedItem(result.data[i]);								
				
				if(!pResItem.isChild){
					pParent.push(pResItem);
				}				
			}
			
			
			for(var j:int=0;j<pParent.length;j++){
				var pParentItem:VOPackedItem = VOPackedItem(pParent[j]);
							
				for(var k:int=0;k<result.data.length;k++){
					var pResChild:VOPackedItem = VOPackedItem(result.data[k]);															
					
					if(pResChild.isChild && pResChild.parentId == pParentItem.item_id){
						pParentItem.childrens.push(pResChild);																	
					}
								
				}								
			}
			
			
			model.defaultCategories = pParent;
			
			if(_isFirstLoad){
				dispatch(new EventServiceCategoriesDefault(EventServiceCategoriesDefault.FIRST_CATEGORIES_LOADED,false,model.appSettings));
				_isFirstLoad = false;
			}			
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
		[Embed(source="../sql/tableItems/InsertTableItems.sql", mimeType="application/octet-stream")]
		private static const InsertTableItemsStatementText:Class;
		private static const INSERT_TABLE_ITEMS_SQL:String = new InsertTableItemsStatementText();
		
		[Embed(source="../sql/tableItems/LoadTableItems.sql", mimeType="application/octet-stream")]
		private static const LoadTableItemsStatementText:Class;
		private static const LOAD_TABLE_ITEMS_SQL:String = new LoadTableItemsStatementText();
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}