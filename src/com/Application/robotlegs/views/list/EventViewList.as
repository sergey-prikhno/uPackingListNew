package com.Application.robotlegs.views.list {
	import starling.events.Event;
	
	public class EventViewList extends Event {
				
		public static const UPDATE_PACKED_ITEM:String = "UPDATE_PACKED_ITEM";	
		public static const BACK_TO_MAIN_SCREEN:String = "BACK_TO_MAIN_SCREEN";	
		public static const CLICK_ITEM:String = "CLICK_ITEM";	
				
		public function EventViewList(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
		}
	}
}