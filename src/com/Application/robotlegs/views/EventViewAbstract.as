package com.Application.robotlegs.views {
	import starling.events.Event;
	
	public class EventViewAbstract extends Event {
		
		
		public static const UPDATE_SETTINGS:String = "UPDATE_SETTINGS";
		public static const GET_APP_SETTINGS:String = "GET_APP_SETTINGS";
		public static const GET_CATEGORY_DATA:String = "GET_CATEGORY_DATA";
		public static const GET_PACKED_ITEMS:String = "GET_PACKED_ITEMS";
		
		public static const UPDATE_DB_PACKED_ITEM:String = "UPDATE_DB_PACKED_ITEM";
		public static const UPDATE_DB_ORDER_INDEXES:String = "UPDATE_DB_ORDER_INDEXES";		
		public static const REMOVE_DB_PACKED_ITEM:String = "REMOVE_DB_PACKED_ITEM";
		public static const REMOVE_PACKED_ITEM:String = "REMOVE_PACKED_ITEM";
		
		
		public static const OPEN_LIST:String = "OPEN_LIST";
		public static const GET_CREATED_LISTS:String = "GET_CREATED_LISTS";
		
		public static const BACK_TO_VIEW_MAIN_SCREEN:String = "BACK_TO_VIEW_MAIN_SCREEN";
		public static const CREATE_NEW_LIST:String = "CREATE_NEW_LIST";	
		public static const ADD_NEW_LIST:String = "ADD_NEW_LIST";	
		public static const REMOVE_LIST:String = "REMOVE_LIST";	
		
		public static const ERROR:String = "ERROR";
		
		public static const BACK:String = "BACK";
		
		
		public static const ADD_NEW_CATEGORY:String = "ADD_NEW_CATEGORY";
		public static const ADD_NEW_ITEM_CATEGORY:String = "ADD_NEW_ITEM_CATEGORY";
		
		
		public static const GET_DEFAULT_CATEGORIES:String = "GET_DEFAULT_CATEGORIES";
		
		private var _functionCallback:Function;
		
		public function EventViewAbstract(type:String, bubbles:Boolean=false, data:Object=null,pFunctionCallback:Function = null)	{
			super(type, bubbles, data);
			_functionCallback = pFunctionCallback;
		}
		
		
		public function get functionCallback():Function{
			return _functionCallback;
		}
		
		
	}
}