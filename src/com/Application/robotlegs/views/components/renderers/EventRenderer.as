package com.Application.robotlegs.views.components.renderers{
	import starling.events.Event;
	
	public class EventRenderer extends Event{
		
		public static var CLICK:String = "CLICK";	
		public static var RENDERER_HIDE_BUTTONS:String = "RENDERER_HIDE_BUTTONS";	
				
		private var _payload:Object;
		public function get payload():Object {
			return _payload;
		}
		
		public function EventRenderer(pType:String,  pPayload:Object=null, pBubling:Boolean = false)	{
			super(pType, pBubling, null);
			this._payload = pPayload;
		}
				
	}
}