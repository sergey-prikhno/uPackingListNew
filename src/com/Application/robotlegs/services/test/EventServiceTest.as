package com.Application.robotlegs.services.test {
	import starling.events.Event;
	
	public class EventServiceTest extends Event {
		
		public static const ERROR:String = "ERROR";	
		public static const RESULT:String = "RESULT";	
		
		public function EventServiceTest(type:String, bubbles:Boolean=false, data:Object=null) 	{
			super(type, bubbles, data);
		}
	}
}