package com.Application.robotlegs.model {
	import starling.events.Event;
	
	public class EventModel extends Event {
		
		public static const ERROR:String = "ERROR";
		public static const CHANGE_APP_SCREEN:String = "CHANGE_APP_SCREEN";
		public static const INSERT_TABLE_NAMES:String = "INSERT_TABLE_NAMES";
		
		public function EventModel(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
		}
		
	}
}