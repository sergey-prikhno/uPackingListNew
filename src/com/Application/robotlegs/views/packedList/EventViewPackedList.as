package com.Application.robotlegs.views.packedList {
	import starling.events.Event;
	
	public class EventViewPackedList extends Event {
		
		
		public static const CLICK_ITEM:String = "CLICK_ITEM";				
		
		public static const UPDATE_PACKED_ITEM:String = "UPDATE_PACKED_ITEM";
		public static const REMOVE_PACKED_ITEM:String = "REMOVE_PACKED_ITEM";
		public static const UPDATE_STATE:String = "UPDATE_STATE";
		public static const BACK_TO_PREVIOUS_SCREEN:String = "BACK_TO_PREVIOUS_SCREEN";
		
		public static const ADD_NEW_CATEGORY:String = "ADD_NEW_CATEGORY";
		public static const ADD_NEW_ITEM:String = "ADD_NEW_ITEM";
		
		public function EventViewPackedList(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
		}		
		
	}
}