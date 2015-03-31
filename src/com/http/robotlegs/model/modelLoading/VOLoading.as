package com.http.robotlegs.model.modelLoading {
	
	public class VOLoading {
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		public static var STATUS__START:String = "STATUS__START"; 
		public static var STATUS__PROGRESS:String = "STATUS__PROGRESS"; 
		public static var STATUS__FINISH:String = "STATUS__FINISH"; 
		
		public static const PROGRESS_EMPTY:Number = -1;
		
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		private var _actorLoader:Object;
		private var _status:String;
		private var _messageKey:String;
		private var _progress:Number;
		private var _progressMessage:String;
		private var _blackBackground:Boolean = false;

		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function VOLoading(pActorLoader:Object, pStatus:String, pMessageKey:String=null, pProgress:Number=PROGRESS_EMPTY, pProgressMessage:String=null) {
			this._actorLoader = pActorLoader;
			this._status = pStatus;
			this._messageKey = pMessageKey;
			this._progress = pProgress;
			this._progressMessage = pProgressMessage;
		}

		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get actorLoader():Object {
			return _actorLoader;
		}

		public function get status():String {
			return _status;
		}
		
		public function get messageKey():String {
			return _messageKey;
		}

		public function get progress():Number {
			return _progress;
		}

		public function get progressMessage():String {
			return _progressMessage;
		}


		public function get blackBackground():Boolean{ return _blackBackground;}
		public function set blackBackground(value:Boolean):void{
			_blackBackground = value;
		}
		
		
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