package com.Application.robotlegs.views.main {
	import com.Application.robotlegs.model.vo.VOList;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.Application.robotlegs.views.components.renderers.ItemrendererList;
	import com.common.Constants;
	
	import ch.ala.locale.LocaleManager;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	import feathers.skins.IStyleProvider;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	
	public class ViewMain extends ViewAbstract {									
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------		
		
		
		public static var globalStyleProvider:IStyleProvider;
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		
		private var _list:List;
		private var _verticalLayout:VerticalLayout;
		
		private var _buttonAddList:Button;	
		private var _buttonMenu:Button;	
		private var _items:Vector.<VOList>;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ViewMain() {
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
		
		public function updateRemovedLists(value:VOList):void{
			//_list.dataProvider.removeAll();
			//_list.dataProvider = null;
			_list.dataProvider = new ListCollection(_items);
			_list.validate();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		override protected function get defaultStyleProvider():IStyleProvider {
			return ViewMain.globalStyleProvider;
		}
		
		public function get resourceManager():LocaleManager{
			return _resourceManager;
		}
		
		public function set vectorLists(value:Vector.<VOList>):void{
			_items = value;
			
			if(_list && _items && _items.length > 0){
				_list.dataProvider = new ListCollection(_items);
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		override protected function _initialize():void{
			super._initialize();
			
			_verticalLayout = new VerticalLayout();
			_verticalLayout.useVirtualLayout = false;
						
			if(!_list){
				_list = new List();
				_list.hasElasticEdges = false;
				_list.snapScrollPositionsToPixels = true;
				_list.itemRendererType = ItemrendererList;
				addChild(_list);
				if(_items && _items.length > 0){
					_list.dataProvider = new ListCollection(_items);
				}
			}
			
			_buttonAddList = new Button();
			_buttonAddList.addEventListener(Event.TRIGGERED, _handlerButtonAddList);
			_buttonAddList.nameList.add(Constants.BUTTON_ADD_LIST);
			this._header.rightItems = new <DisplayObject>[this._buttonAddList];
			
			_buttonMenu = new Button();
			_buttonMenu.addEventListener(Event.TRIGGERED, _handlerButtonMenu);
			_buttonMenu.nameList.add(Constants.BUTTON_MENU);
			this._header.leftItems = new <DisplayObject>[this._buttonMenu];
			
			
		}
		
		override protected function draw():void{
			super.draw();
			
			if(_header){
				_header.title = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "header.uPackingList");				
			}
			if(_list){
				_list.layout = _verticalLayout;	
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