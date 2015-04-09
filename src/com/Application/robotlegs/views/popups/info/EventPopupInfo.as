package com.Application.robotlegs.views.popups.info{
	import starling.events.Event;

	public class EventPopupInfo extends Event{
		
		
		
		public static const CLOSE_POPUP_INFO:String = "CLOSE_POPUP_INFO";
		
		
		private var _payload:Object;
		public function get payload():Object {
			return _payload;
		}
		
		
		private var _functionCallback:Function;
		public function get functionCallback():Function {
			return _functionCallback;
		}	
		
		
		public function EventPopupInfo(type:String, pPayload:Object=null,pBubbles:Boolean=false,pFunctionCallback:Function = null) {
			super(type, pBubbles);
			this._payload = pPayload;
			this._functionCallback = pFunctionCallback;
		}
		
		
	}
}