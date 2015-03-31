package com.Application {
	import com.Application.robotlegs.controller.service.CommandServiceError;
	import com.Application.robotlegs.controller.service.sql.init.CommandConfigureModel;
	import com.Application.robotlegs.controller.service.sql.init.CommandConfigureSql;
	import com.Application.robotlegs.controller.service.sql.init.CommandCreateDB;
	import com.Application.robotlegs.controller.service.sql.init.CommandNamesTableConfigured;
	import com.Application.robotlegs.controller.service.sql.init.CommandSettingConfigured;
	import com.Application.robotlegs.model.IModel;
	import com.Application.robotlegs.model.Model;
	import com.Application.robotlegs.model.managerPopup.IManagerPopup;
	import com.Application.robotlegs.model.managerPopup.ManagerPopup;
	import com.Application.robotlegs.services.categories.IServiceCategories;
	import com.Application.robotlegs.services.categories.ServiceCategories;
	import com.Application.robotlegs.services.categoriesDefault.IServiceCategoriesDefault;
	import com.Application.robotlegs.services.categoriesDefault.ServiceCategoriesDefault;
	import com.Application.robotlegs.services.dbCreator.IServiceDBCreator;
	import com.Application.robotlegs.services.dbCreator.ServiceDBCreator;
	import com.Application.robotlegs.services.settings.EventServiceSettings;
	import com.Application.robotlegs.services.settings.IServiceSettings;
	import com.Application.robotlegs.services.settings.ServiceSettings;
	import com.Application.robotlegs.services.tableNames.EventServiceTableNames;
	import com.Application.robotlegs.services.tableNames.IServiceTableNames;
	import com.Application.robotlegs.services.tableNames.ServiceTableNames;
	import com.http.robotlegs.events.EventServiceAbstract;
	
	import org.robotlegs.starling.mvcs.Context;
	
	import starling.display.DisplayObjectContainer;
	
	public class StarlingAppContext extends Context {
		
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
		public function StarlingAppContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true){
			super(contextView, autoStartup);
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function startup():void {
			//Mediator MAP
			mediatorMap.mapView(Main, MediatorMain);
		
			
			injector.mapSingletonOf(IModel, Model);
			injector.mapSingletonOf(IManagerPopup, ManagerPopup);
					
			//Services
			injector.mapSingletonOf(IServiceDBCreator, ServiceDBCreator);
			injector.mapSingletonOf(IServiceSettings, ServiceSettings);
			injector.mapSingletonOf(IServiceCategoriesDefault, ServiceCategoriesDefault);
			injector.mapSingletonOf(IServiceCategories, ServiceCategories);
			injector.mapSingletonOf(IServiceTableNames, ServiceTableNames);
						
			//Command MAP	
			commandMap.mapEvent(EventServiceAbstract.ERROR, CommandServiceError, EventServiceAbstract);	
			
			commandMap.mapEvent(EventMain.INITIALIZE_DATABASE, CommandConfigureSql, EventMain);
			commandMap.mapEvent(EventMain.CONFIGURE_DATABASE, CommandCreateDB, EventMain);
			commandMap.mapEvent(EventMain.CONFIGURE_MODEL, CommandConfigureModel, EventMain);
			commandMap.mapEvent(EventServiceSettings.FIRST_SETTINGS_LOADED, CommandSettingConfigured, EventServiceSettings);
			commandMap.mapEvent(EventServiceTableNames.FIRST_TABLE_NAMES_LOADED, CommandNamesTableConfigured, EventServiceTableNames);
					
			
			super.startup();
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