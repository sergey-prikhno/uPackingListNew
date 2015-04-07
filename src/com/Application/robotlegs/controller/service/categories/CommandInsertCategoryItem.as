package com.Application.robotlegs.controller.service.categories {
	import com.Application.robotlegs.model.IModel;
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.services.categories.IServiceCategories;
	import com.Application.robotlegs.views.EventViewAbstract;
	
	import org.robotlegs.starling.mvcs.Command;
	
	public class CommandInsertCategoryItem extends Command {		
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
		public function CommandInsertCategoryItem() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function execute():void{
			trace("insert table");
			
			var pData:VOPackedItem = VOPackedItem(event.data);				
			service.insert(pData,model.currentTableName.table_name);			
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
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}