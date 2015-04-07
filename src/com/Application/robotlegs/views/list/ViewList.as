package com.Application.robotlegs.views.list {
	import com.Application.robotlegs.views.ViewAbstract;
	import com.Application.robotlegs.views.components.renderers.ItemrendererList;
	import com.Application.robotlegs.views.main.EventViewMain;
	import com.common.Constants;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.Scroller;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	import feathers.skins.IStyleProvider;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	
	public class ViewList extends ViewAbstract {									
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------		
		
		private var _verticalLayout:VerticalLayout;
		
		public static var globalStyleProvider:IStyleProvider;
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		
		private var _list:List;
		private var _collectionList:ListCollection;	
		
		private var _buttonBack:Button;	
		private var _buttonSearch:Button;	
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ViewList() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		override public function destroy():void{
			super.destroy();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		override protected function get defaultStyleProvider():IStyleProvider {
			return ViewList.globalStyleProvider;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		override protected function _initialize():void{
			super._initialize();
			
			if(!_verticalLayout){
				_verticalLayout = new VerticalLayout();
				_verticalLayout.useVirtualLayout = true;
			}
						
			_collectionList = new ListCollection();
			
			
			if(!_list){
				_list = new List();
				_list.hasElasticEdges = true;
				_list.itemRendererType = ItemrendererList;
				_list.itemRendererProperties.isLongPressEnabled = true;
				addChild(_list);
			}
			
			_buttonBack = new Button();
			_buttonBack.addEventListener(Event.TRIGGERED, _handlerButtonAddList);
			_buttonBack.nameList.add(Constants.BUTTON_CUSTOM_BACK);
			this._header.rightItems = new <DisplayObject>[this._buttonBack];
			
			_buttonSearch = new Button();
			_buttonSearch.addEventListener(Event.TRIGGERED, _handlerButtonMenu);
			_buttonSearch.nameList.add(Constants.BUTTON_SEARCH_STYLE);
			this._header.leftItems = new <DisplayObject>[this._buttonSearch];
			
			
		}
		
		override protected function draw():void{
			super.draw();
			
			if(_header){
				_header.title = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "header.uPackingList");				
			}
			if(_list){
				_list.layout = _verticalLayout;	
				_list.dataProvider = _collectionList;
				_list.width = _nativeStage.stageWidth;
				_list.height = _nativeStage.stageHeight - _header.height;
				_list.validate();
				_list.x = _nativeStage.stageWidth/2 - _list.width/2;
				_list.y = _header.height;
			}
			
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------				
		private function _handlerButtonAddList(event:Event):void{
			dispatchEvent(new EventViewMain(EventViewMain.CREATE_NEW_LIST));							
		}
	
		private function _handlerButtonMenu(event:Event):void{
			dispatchEvent(new EventViewMain(EventViewMain.SHOW_MAIN_MENU));							
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}