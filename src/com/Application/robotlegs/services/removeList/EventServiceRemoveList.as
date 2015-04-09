package com.Application.robotlegs.services.removeList{
	import starling.events.Event;
	
	public class EventServiceRemoveList extends Event{
		
		public static const REMOVED_LIST_DB:String = "REMOVED_LIST_DB";
		
		public function EventServiceRemoveList(type:String, bubbles:Boolean=false, data:Object=null){
			super(type, bubbles, data);
		}
	}
}