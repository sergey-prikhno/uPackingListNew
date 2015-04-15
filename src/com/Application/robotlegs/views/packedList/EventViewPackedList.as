package com.Application.robotlegs.views.packedList {
	import starling.events.Event;
	
	public class EventViewPackedList extends Event {
		
		
		public static const CLICK_ITEM:String = "CLICK_ITEM";				
		
		public static const UPDATE_PACKED_ITEM:String = "UPDATE_PACKED_ITEM";
		public static const REMOVE_PACKED_ITEM:String = "REMOVE_PACKED_ITEM";
		public static const UPDATE_STATE:String = "UPDATE_STATE";
		public static const BACK_TO_VIEW_CREATE:String = "BACK_TO_VIEW_CREATE";
		public static const GOTO_VIEW_LIST:String = "GOTO_VIEW_LIST";
		
		public function EventViewPackedList(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
		}		
		
	}
}