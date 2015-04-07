package com.Application.robotlegs.views.createList {
	import starling.events.Event;
	
	public class EventViewCreateList extends Event {
				
		public static const BACK_TO_MAIN_LIST_SCREEN:String = "BACK_TO_MAIN_LIST_SCREEN";	
		public static const CREATE_NEW_LIST:String = "CREATE_NEW_LIST";	
			
		
		public function EventViewCreateList(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
		}
	}
}