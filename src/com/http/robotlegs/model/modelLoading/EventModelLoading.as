package com.http.robotlegs.model.modelLoading {
	
	import flash.events.Event;
	
	
	public class EventModelLoading extends Event {

		
		public static var LOADING_STARTED:String = "LOADING_STARTED";
		public static var LOADING_FINISHED:String = "LOADING_FINISHED";
		
		public static var STATUS__UPDATE:String = "STATUS__UPDATE";
		
		
		
		private var _payload:VOModelLoading;
		public function get payload():VOModelLoading{
			return _payload; 
		}
		
		
		public function EventModelLoading(type:String, pPayload:VOModelLoading){
			super(type);
			this._payload = pPayload;
		}
		
		override public function clone():Event {
			return new EventModelLoading(type, _payload);
		}
	}
}