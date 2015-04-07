package com.Application.robotlegs.views.main {
	import starling.events.Event;
	
	public class EventViewMain extends Event {
				
		public static const CREATE_NEW_LIST:String = "CREATE_NEW_LIST";	
		public static const SHOW_MAIN_MENU:String = "SHOW_MAIN_MENU";	
				
		public function EventViewMain(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
		}
	}
}