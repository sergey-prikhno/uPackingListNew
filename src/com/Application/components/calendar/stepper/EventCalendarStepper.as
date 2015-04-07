package com.Application.components.calendar.stepper{
	import starling.events.Event;

	public class EventCalendarStepper extends Event{
		
		
		public static const CLICK_UP:String = "CLICK_UP";
		public static const CLICK_DOWN:String = "CLICK_DOWN";
		
		
		
		private var _payload:Object;
		public function get payload():Object {
			return _payload;
		}
		
		
		private var _functionCallback:Function;
		public function get functionCallback():Function {
			return _functionCallback;
		}	
		
		
		public function EventCalendarStepper(type:String, pPayload:Object=null,pBubbles:Boolean=false,pFunctionCallback:Function = null) {
			super(type, pBubbles);
			this._payload = pPayload;
			this._functionCallback = pFunctionCallback;
		}
		
		
	}
}