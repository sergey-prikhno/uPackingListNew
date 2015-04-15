package com.Application.robotlegs.services.tableNames {
	import com.Application.robotlegs.model.IModel;
	import com.Application.robotlegs.model.vo.VOList;
	import com.probertson.data.QueuedStatement;
	import com.probertson.data.SQLRunner;
	
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	
	import org.robotlegs.starling.mvcs.Actor;
	
	public class ServiceTableNames extends Actor implements IServiceTableNames 	{		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		[Inject]
		public var model:IModel;
		
		[Inject]
		public var sqlRunner:SQLRunner;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		private var _isFirstLoad:Boolean = false;
		private var _isUpdatePersent:Boolean = false;
		
		private var _currentInsertedItem:VOList;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ServiceTableNames() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function getTableNamesFirst():void{	
			_isFirstLoad = true;
			sqlRunner.execute(LOAD_NAMES_SQL, null, load_result, VOList);		
		}	
		
		public function load():void {
			sqlRunner.execute(LOAD_NAMES_SQL, null, load_result, VOList);
		}
		
		
		public function insert(value:VOList):void {
			_currentInsertedItem = value;
			
			var params:Object = new Object();
			params["title"] = value.title;
			params["table_name"] = value.table_name;
			params["date_create"] = value.date_create;
			params["persents"] = value.persents;
			
			
			sqlRunner.executeModify(Vector.<QueuedStatement>([new QueuedStatement(INSERT_NAMES_SQL, params)]), addNew_result, database_error);
		}
		
		public function updateListPersent(pList:VOList):void{
			_isUpdatePersent = true;
			
			var params:Object = new Object();
			params["id"] = pList.id;
			params["title"] = pList.title;
			params["table_name"] = pList.table_name;
			params["date_create"] = pList.date_create;
			params["persents"] = pList.persents;
			
			
			sqlRunner.executeModify(Vector.<QueuedStatement>([new QueuedStatement(UPDATE_NAMES_SQL, params)]), updateAfterInsert_result, database_error);
			
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
		private function _updateTableName(pId:Number):void{
			_currentInsertedItem.id = pId;									
			_currentInsertedItem.table_name = "category_"+pId;
			
			var params:Object = new Object();
				params["id"] = _currentInsertedItem.id;
				params["title"] = _currentInsertedItem.title;
				params["table_name"] = _currentInsertedItem.table_name;
				params["date_create"] = _currentInsertedItem.date_create;
				params["persents"] = _currentInsertedItem.persents;
										
				
				sqlRunner.executeModify(Vector.<QueuedStatement>([new QueuedStatement(UPDATE_NAMES_SQL, params)]), updateAfterInsert_result, database_error);
			
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function load_result(result:SQLResult):void	{
							
			if(result.data){
				model.appLists = Vector.<VOList>(result.data);
			}
			
			if(_isFirstLoad){
				_isFirstLoad = false
				dispatch(new EventServiceTableNames(EventServiceTableNames.FIRST_TABLE_NAMES_LOADED));		
			} else {
				dispatch(new EventServiceTableNames(EventServiceTableNames.LOADED));
			}
		
		}
		
		
		private function addNew_result(results:Vector.<SQLResult>):void {
			var result:SQLResult = results[0];
			_updateTableName(result.lastInsertRowID);
			trace("added");
		}
		
		
		private function database_error(error:SQLError):void {
			//dispatch(new SQLErrorEvent(SQLErrorEvent.ERROR, false, false, error));
			trace("Error in TableNames DB");
		}
		
		private function updateAfterInsert_result(results:Vector.<SQLResult>):void	{
			if(!_isUpdatePersent){
				model.appLists.push(_currentInsertedItem);
				dispatch(new EventServiceTableNames(EventServiceTableNames.INSERTED, false, _currentInsertedItem));
			}
			_isUpdatePersent = false;
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
		
		// ------- SQL statements -------		
		[Embed(source="../sql/tableNames/LoadNamesTable.sql", mimeType="application/octet-stream")]
		private static const LoadNamesTableStatementText:Class;
		private static const LOAD_NAMES_SQL:String = new LoadNamesTableStatementText();
		
		/*[Embed(source="sql/LoadContact.sql", mimeType="application/octet-stream")]
		private static const LoadContactStatementText:Class;
		private static const LOAD_CONTACT_SQL:String = new LoadContactStatementText();
		*/
		[Embed(source="../sql/tableNames/InsertNamesTable.sql", mimeType="application/octet-stream")]
		private static const InsertStatementText:Class;
		private static const INSERT_NAMES_SQL:String = new InsertStatementText();
		
		[Embed(source="../sql/tableNames/UpdateNamesTable.sql", mimeType="application/octet-stream")]
		private static const UpdateStatementText:Class;
		private static const UPDATE_NAMES_SQL:String = new UpdateStatementText();
		
		/*[Embed(source="sql/DeleteContact.sql", mimeType="application/octet-stream")]
		private static const DeleteContactStatementText:Class;
		private static const DELETE_CONTACT_SQL:String = new DeleteContactStatementText();
		*/
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}