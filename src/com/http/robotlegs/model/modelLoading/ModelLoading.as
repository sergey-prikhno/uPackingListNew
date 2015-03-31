package com.http.robotlegs.model.modelLoading {
	
	
	import com.razzmatazz.utils.logger.EventLogger;
	import com.razzmatazz.valueObjects.log.VOLogMessage;
	
	import org.robotlegs.mvcs.Actor;
	
	
	public class ModelLoading extends Actor implements IModelLoading {
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
		private var _loadingCounter:int = 0;
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ModelLoading() {
			super();
			trace("Constructor ModelPreloading");
		}
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		[PostConstruct]
		public function initialize():void {
			trace("Model [ModelPreloading]");
			
		}
		
		
		
		public function loadingStarted(pData:VOLoading):void {
			_loadingCounter++;
			_statusUpdate();	
		}
		
		public function loadingFinished(pData:VOLoading):void {
			_loadingCounter--;
			_statusUpdate();
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
		protected function _logSend(pMessage:VOLogMessage):void {
			dispatch(new EventLogger(EventLogger.MESSAGE, pMessage));
		}
		
		
		private function _statusUpdate():void{
			var pData:VOModelLoading = new VOModelLoading();
			pData.isLoading = (_loadingCounter == 0 ? false : true);
			
			//var pDebug:VOLogMessage = new VOLogMessage(this, "ModelLoading", pData);
			//_logSend(pDebug);
			
			//trace("ModelLoading _statusUpdate _loadingCounter: " + _loadingCounter +"    pData.isLoading: "+pData.isLoading);
			dispatch(new EventModelLoading(EventModelLoading.STATUS__UPDATE, pData));	
		}

		
		
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