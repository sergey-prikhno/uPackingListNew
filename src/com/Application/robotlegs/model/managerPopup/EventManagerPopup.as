package com.Application.robotlegs.model.managerPopup {
	import starling.events.Event;
	
	public class EventManagerPopup extends Event {
		
		public static const TEST:String = "TEST";
		public static const SET_NEW_LIST_NAME:String = "SET_NEW_LIST_NAME";
		
		public function EventManagerPopup(type:String, bubbles:Boolean=false, data:Object=null)	{
			super(type, bubbles, data);
		}
	}
}