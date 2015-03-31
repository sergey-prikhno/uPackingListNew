package com.http.net {
	
	import flash.events.Event;
	
	public class EventNetwork extends Event {
		
		public var argument : Object;
		
		public static var REQUEST_COMPLETE:String = "request complete";
		
		public static var REQUEST_HTTP_STATUS:String = "Http status";
		
		public static var ERROR_SECURITY:String = "Security Error";
		public static var ERROR_DEFAULT:String = "Unknown HTTP Error";
		public static var ERROR_IO:String = "I/O Error";
		
		public static var REQUEST_TIMED_OUT:String = "Request Timed Out";		
		public static var REQUEST_CANCELED:String = "Request Canceled";
		
		
		public function EventNetwork(type:String, bubbles:Boolean=false, cancelable:Boolean=false, args : Object = null){
			super(type, bubbles, cancelable);
			this.argument = args;
		}
	}
}