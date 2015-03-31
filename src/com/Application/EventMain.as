package com.Application {
	import starling.events.Event;
	
	public class EventMain extends Event {
		
		public static const ERROR:String = "ERROR";		
		public static const GET_APP_SETTINGS:String = "GET_APP_SETTINGS";			
		public static const SHOW_VIEW_MAIN:String = "SHOW_VIEW_MAIN";
		
		
		public static const INITIALIZE_DATABASE:String = "INITIALIZE_DATABASE";
		public static const CONFIGURE_MODEL:String = "CONFIGURE_MODEL";
		public static const CONFIGURE_DATABASE:String = "CONFIGURE_DATABASE";
				

		private var _functionCallback:Function;
		
		public function EventMain(type:String, bubbles:Boolean=false,data:Object=null, pFunctionCallback:Function = null) {
			super(type, bubbles, data);
			_functionCallback = pFunctionCallback;
		}
		
		public function get functionCallback():Function{
			return _functionCallback;
		}
		
	}
}