package com.Application.robotlegs.services.categoriesDefault {
	import starling.events.Event;
	
	public class EventServiceCategoriesDefault extends Event {		
		public static const FIRST_CATEGORIES_LOADED:String = "FIRST_CATEGORIES_LOADED";
		
		public function EventServiceCategoriesDefault(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);			
		}
		
	}
}