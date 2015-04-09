package com.Application.robotlegs.views.popups.removeList
{	
	
	import starling.events.Event;
	
	public class EventPopupRemoveList extends starling.events.Event {
		
		public static const REMOVE_LIST:String = "REMOVE_LIST";
		public static const CANCEL_POPUP:String = "CANCEL_POPUP";
		
		public function EventPopupRemoveList(type:String, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
		}
	}
}