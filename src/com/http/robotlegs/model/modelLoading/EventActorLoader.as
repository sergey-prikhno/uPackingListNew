package com.http.robotlegs.model.modelLoading {
	
	import starling.events.Event;
	
	
	public class EventActorLoader extends Event {

		
		public static var LOADING_STARTED:String = "LOADING_STARTED";
		public static var LOADING_FINISHED:String = "LOADING_FINISHED";
		
		
		private var _payload:VOLoading;
		public function get payload():VOLoading{
			return _payload; 
		}
		
		
		public function EventActorLoader(type:String,  pArgument:Object=null, bubbles:Boolean=false){
			super(type, bubbles, pArgument);			
		}
		
		
	}
}