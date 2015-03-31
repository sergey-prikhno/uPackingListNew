package com.http.robotlegs.events {
	import starling.events.Event;
	
		
	public class EventServiceAbstract extends Event {
		
		public var argument:Object;
		
		public static var SUCCESS:String = "SUCCESS";		
		public static var STATUS:String = "STATUS";
		public static var ERROR:String = "ERROR";
		
		
		public function EventServiceAbstract(type:String,bubbles:Boolean=false,pArgument:Object=null){
			super(type, bubbles, pArgument);			
		}
		
		
	}
}