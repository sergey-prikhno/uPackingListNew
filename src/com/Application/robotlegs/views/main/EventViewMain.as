package com.Application.robotlegs.views.main {
	import starling.events.Event;
	
	public class EventViewMain extends Event {
				
		public static const CREATE_NEW_LIST:String = "CREATE_NEW_LIST";	
		public static const SHOW_MAIN_MENU:String = "SHOW_MAIN_MENU";	
		public static const SHOW_REMOVE_LIST_POPUP:String = "SHOW_REMOVE_LIST_POPUP";
		public static const SHOW_VIEW_EDIT_PACKLIST:String = "SHOW_VIEW_EDIT_PACKLIST";
		public static const GET_SELECTED_LIST_DATA:String = "GET_SELECTED_LIST_DATA";	
				
		public function EventViewMain(type:String, bubbles:Boolean=false, data:Object=null) {
			super(type, bubbles, data);
		}
	}
}