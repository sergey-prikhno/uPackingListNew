package com.Application.robotlegs.views.list {
	import starling.events.Event;
	
	public class EventViewList extends Event {
				
		//public static const CREATE_NEW_LIST:String = "CREATE_NEW_LIST";	
		public static const BACK_TO_MAIN_SCREEN:String = "BACK_TO_MAIN_SCREEN";	
				
		public function EventViewList(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
		}
	}
}