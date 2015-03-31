package com.Application.robotlegs.services.dbCreator  {
	import com.Application.EventMain;
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.common.DefaultData;
	import com.probertson.data.QueuedStatement;
	import com.probertson.data.SQLRunner;
	
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	
	import org.robotlegs.starling.mvcs.Actor;
	
	public class ServiceDBCreator extends Actor implements IServiceDBCreator {		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		[Inject]
		public var sqlRunner:SQLRunner;
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
		public function ServiceDBCreator() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function createDatabaseStructure():void 	{
			var stmts:Vector.<QueuedStatement> = new Vector.<QueuedStatement>();
			stmts[stmts.length] = new QueuedStatement(CREATE_ITEMS_SQL);						
			stmts[stmts.length] = new QueuedStatement(CREATE_SETTINGS_SQL);								
			stmts[stmts.length] = new QueuedStatement(CREATE_NAMES_TABLE_SQL);						
						
					
			for(var i:int=0; i<DefaultData.CATEGORIES.length;i++){
				var pItem:VOPackedItem = VOPackedItem(DefaultData.CATEGORIES[i]);
				
				var paramsItem:Object = new Object();
					paramsItem["parentId"] = pItem.parentId;
					paramsItem["isChild"] = pItem.isChild.toString();
					paramsItem["label"] = pItem.label;
					paramsItem["isPacked"] = pItem.isPacked.toString();	
					paramsItem["orderIndex"] = pItem.orderIndex;
					paramsItem["item_id"] = pItem.item_id;
					paramsItem["icon_id"] = pItem.icon_id;											
		
				stmts[stmts.length] = new QueuedStatement(INSERT_ITEMS_SQL, paramsItem);
			}
						
			
			var params:Object = new Object();
				params["language_app"] = DefaultData.LANGUAGE;
				params["welcome"] = DefaultData.WELCOME;
				params["theme"] = DefaultData.THEME;		
				
			stmts[stmts.length] = new QueuedStatement(INSERT_SETTINGS_SQL, params);
					
			
			sqlRunner.executeModify(stmts, executeBatch_complete, executeBatch_error, null);
		}
		
		private function executeBatch_complete(results:Vector.<SQLResult>):void	{
			trace("aaaa");
			
			dispatch(new EventMain(EventMain.CONFIGURE_MODEL));
		}
		
		
		private function executeBatch_error(error:SQLError):void {
			
			trace("error");
			//dispatch(new SQLErrorEvent(SQLErrorEvent.ERROR, false, false, error));
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
		// ------- SQL statements -------
		[Embed(source="../sql/tableItems/CreateTableItems.sql", mimeType="application/octet-stream")]
		private static const CreateItemsStatementText:Class;
		private static const CREATE_ITEMS_SQL:String = new CreateItemsStatementText();
		
		[Embed(source="../sql/settings/CreateTableSettings.sql", mimeType="application/octet-stream")]
		private static const CreateSettingsStatementText:Class;
		private static const CREATE_SETTINGS_SQL:String = new CreateSettingsStatementText();		
						
		[Embed(source="../sql/tableItems/InsertTableItems.sql", mimeType="application/octet-stream")]
		private static const InsertItemsStatementText:Class;
		private static const INSERT_ITEMS_SQL:String = new InsertItemsStatementText();
		
		[Embed(source="../sql/settings/InsertSettings.sql", mimeType="application/octet-stream")]
		private static const InsertSettingsStatementText:Class;
		private static const INSERT_SETTINGS_SQL:String = new InsertSettingsStatementText();
		
		[Embed(source="../sql/tableNames/CreateNamesTable.sql", mimeType="application/octet-stream")]
		private static const CreateNamesTableStatementText:Class;
		private static const CREATE_NAMES_TABLE_SQL:String = new CreateNamesTableStatementText();
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}