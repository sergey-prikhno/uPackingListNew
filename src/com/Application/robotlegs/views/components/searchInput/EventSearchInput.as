package com.Application.robotlegs.views.components.searchInput {
	import starling.events.Event;
	
	public class EventSearchInput extends Event {
		
		public static const CHANGE:String = "CHANGE";
		public static const CANCEL:String = "CANCEL";
		
		public function EventSearchInput(type:String, bubbles:Boolean=false, data:Object=null) 	{
			super(type, bubbles, data);
		}
	}
}