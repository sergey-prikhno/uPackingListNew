package com.Application.robotlegs.services.settings {
	import com.Application.robotlegs.model.IModel;
	import com.Application.robotlegs.model.vo.VOAppSettings;
	import com.probertson.data.QueuedStatement;
	import com.probertson.data.SQLRunner;
	
	import flash.data.SQLResult;
	import flash.errors.SQLError;
	
	import org.robotlegs.starling.mvcs.Actor;
	
	public class ServiceSettings extends Actor implements IServiceSettings {		
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
		public function ServiceSettings() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function getSettingsFirst():void{	
			_isFirstLoad = true;
			sqlRunner.execute(LOAD_SETTINGS_SQL, null, load_result, VOAppSettings);			
		}	
		
		
		public function update(value:VOAppSettings):void {
			var params:Object = new Object();
				params["id"] = value.id; 
				params["language_app"] = value.language_app;
				params["welcome"] = value.welcome;
				params["theme"] = value.theme;		
			
			sqlRunner.executeModify(Vector.<QueuedStatement>([new QueuedStatement(UPDATE_SETTINGS_SQL, params)]), update_result, database_error);
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
			//model.list = new ArrayCollection(result.data);
			model.appSettings = VOAppSettings(result.data[0]);
			
			if(_isFirstLoad){
				dispatch(new EventServiceSettings(EventServiceSettings.FIRST_SETTINGS_LOADED));
				_isFirstLoad = false;
			}			
		}
		
		private function database_error(error:SQLError):void {
			//dispatch(new SQLErrorEvent(SQLErrorEvent.ERROR, false, false, error));
			
			trace("update Settings error");
		}
		
		private function update_result(results:Vector.<SQLResult>):void {
		//	dispatch(new ContactServiceEvent(ContactServiceEvent.SAVED));
			trace(" setting updated ");
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//--------------------------------------------------------------------------------------------------------- 			
		[Embed(source="../sql/settings/InsertSettings.sql", mimeType="application/octet-stream")]
		private static const InsertSettingsStatementText:Class;
		private static const INSERT_SETTINGS_SQL:String = new InsertSettingsStatementText();
		
		[Embed(source="../sql/settings/LoadSettings.sql", mimeType="application/octet-stream")]
		private static const LoadSettingsStatementText:Class;
		private static const LOAD_SETTINGS_SQL:String = new LoadSettingsStatementText();
		
		[Embed(source="../sql/settings/UpdateSettings.sql", mimeType="application/octet-stream")]
		private static const UpdateSettingsStatementText:Class;
		private static const UPDATE_SETTINGS_SQL:String = new UpdateSettingsStatementText();
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}