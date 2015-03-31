package com.Application.robotlegs.services.categories {
	import starling.events.Event;
	
	public class EventServiceCategories extends Event {
		
		
		public static const LOADED:String = "LOADED";
		public static const UPDATED:String = "UPDATED";
		public static const REMOVED:String = "REMOVED";
		public static const NEW_TABLE_CREATED:String = "NEW_TABLE_CREATED";
		
		public function EventServiceCategories(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
		}
	}
}