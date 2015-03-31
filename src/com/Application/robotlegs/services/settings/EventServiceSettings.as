package com.Application.robotlegs.services.settings {
	import starling.events.Event;
	
	public class EventServiceSettings extends Event {
		
		public static const FIRST_SETTINGS_LOADED:String = "FIRST_SETTINGS_LOADED";
		
		public function EventServiceSettings(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}