package com.Application.robotlegs.services.tableNames {
	import starling.events.Event;
	
	public class EventServiceTableNames extends Event
	{
		
		public static const FIRST_TABLE_NAMES_LOADED:String = "FIRST_TABLE_NAMES_LOADED";		
		public static const LOADED:String = "LOADED";
		public static const INSERTED:String = "INSERTED";
		
		public function EventServiceTableNames(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}