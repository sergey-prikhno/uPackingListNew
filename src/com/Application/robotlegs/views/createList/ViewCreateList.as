package com.Application.robotlegs.views.createList {
	import com.Application.components.calendar.PopupCalendar;
	import com.Application.robotlegs.model.vo.VOInfo;
	import com.Application.robotlegs.model.vo.VOList;
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.common.Constants;
	
	import flash.text.engine.ElementFormat;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.TextInput;
	import feathers.skins.IStyleProvider;
	
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.events.Event;
	
	
	public class ViewCreateList extends ViewAbstract {									
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
		
		private var _buttonApply:Button;	
		private var _buttonBack:Button;	
		
		private var _inputTitle:TextInput;
		
		private var _labelTitle:Label;
		private var _labelDate:Label;
		
		private var _calendar:PopupCalendar;
		
		private var _quadBG:Quad;
		private var _voList:VOList;
		private var _efTitleCreateList:ElementFormat;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ViewCreateList() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		override public function destroy():void{
			super.destroy();
			
			if(_buttonApply){
				_buttonApply.removeEventListener(Event.TRIGGERED, _handlerButtonApply);
				_buttonApply.nameList.remove(Constants.BUTTON_APPLY);
				_buttonApply.removeFromParent(true);
				_buttonApply = null;
			}
			
			if(_buttonBack){
				_buttonBack.removeEventListener(Event.TRIGGERED, _handlerButtonBack);
				_buttonBack.nameList.remove(Constants.BUTTON_CUSTOM_BACK);
				_buttonBack.removeFromParent(true);
				_buttonBack = null;
			}
			
			if(_inputTitle){
				removeChild(_inputTitle, true);
				_inputTitle = null;
			}
			if(_calendar){
				_calendar.destroy();
				removeChild(_calendar, true);
				_calendar = null;
			}
			if(_quadBG){
				removeChild(_quadBG,true);
				_quadBG = null;
			}
			
			if(_labelTitle){
				removeChild(_labelTitle, true);
				_labelTitle = null;
			}
			
			if(_labelDate){
				removeChild(_labelDate, true);
				_labelDate = null;
			}
			
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		override protected function get defaultStyleProvider():IStyleProvider {
			return ViewCreateList.globalStyleProvider;
		}
		
		public function set efTitleCreateList(value:ElementFormat):void{_efTitleCreateList = value;}
		
		public function set voList(value:VOList):void{
			_voList = value;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		override protected function _initialize():void{
			super._initialize();
			
			_quadBG = new Quad(10,10,0xf3f3f3);
			addChildAt(_quadBG,0);
			
			_buttonApply = new Button();
			_buttonApply.addEventListener(Event.TRIGGERED, _handlerButtonApply);
			_buttonApply.nameList.add(Constants.BUTTON_APPLY);
			this._header.rightItems = new <DisplayObject>[this._buttonApply];
			
			_buttonBack = new Button();
			_buttonBack.addEventListener(Event.TRIGGERED, _handlerButtonBack);
			_buttonBack.nameList.add(Constants.BUTTON_CUSTOM_BACK);
			this._header.leftItems = new <DisplayObject>[this._buttonBack];
			
			_labelTitle = new Label();
			addChild(_labelTitle);
			
			_inputTitle = new TextInput();
			_inputTitle.nameList.add(Constants.INPUT_TEXT_TITLE_CUSTOM);
			addChild(_inputTitle);
			
			_labelDate = new Label();
			addChild(_labelDate);
			
			_calendar = new PopupCalendar();
			_calendar.nativeWidth = _nativeStage.stageWidth;
			addChild(_calendar);
		}
		
		override protected function draw():void{
			super.draw();
			
			if(_quadBG){
				_quadBG.width = _nativeStage.stageWidth;
				_quadBG.height = _nativeStage.stageHeight;
			}
			
			if(_header){
				_header.title = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "header.createList");				
			}
			
			if(_labelTitle){
				_labelTitle.text = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "title.createTitle");
				_labelTitle.textRendererProperties.elementFormat = _efTitleCreateList;
				_labelTitle.validate();
				_labelTitle.x = int(40*_scaleWidth);
				_labelTitle.y = _header.height + int(50*_scaleWidth); 
			}
			
			if(_inputTitle){
				if(_voList){
					_inputTitle.text = _voList.title;
				}
				_inputTitle.prompt = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "title.createTitleDesc");
				_inputTitle.width = _nativeStage.stageWidth - int(80*_scaleWidth);
				_inputTitle.height = int(72*_scaleHeight);
				_inputTitle.x = _labelTitle.x;
				_inputTitle.y = _labelTitle.y + _labelTitle.height + int(25*_scaleWidth);
				_inputTitle.validate();
			}
			if(_labelDate){
				_labelDate.text = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "title.createDate");
				_labelDate.textRendererProperties.elementFormat = _efTitleCreateList;
				_labelDate.validate();
				_labelDate.x = _labelTitle.x;
				_labelDate.y = _inputTitle.y + _inputTitle.height + int(100*_scaleWidth); 
			}
			
			if(_calendar){
				_calendar.y = _labelDate.y + _labelDate.height + int(60*_scaleWidth);
				if(_voList){
					_calendar.voList = _voList;
					_calendar.validate();
				}
			}
			
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------				
		private function _handlerButtonApply(event:Event):void{
			if(_inputTitle.text.length > 0 && _inputTitle.text.split(" ").join("").length > 0){
				if(!_voList){
					var pVO:VOList = new VOList();
						pVO.date_create = _calendar.getCreateDate();
						pVO.title = _inputTitle.text;
						pVO.isCreating = true;
					
					dispatchEvent(new EventViewCreateList(EventViewCreateList.CREATE_NEW_LIST, false, pVO));
				}else{
					dispatchEvent(new EventViewCreateList(EventViewCreateList.SHOW_VIEW_PACK_LIST));
				}
			}else{
				var pVOInfo:VOInfo = new VOInfo();
					pVOInfo.infoTitle = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "title.warning");
					pVOInfo.infoDesc = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "warning.listName");
				dispatchEvent(new EventViewAbstract(EventViewAbstract.SHOW_INFO_POPUP, false, pVOInfo));
			}
		}
	
		private function _handlerButtonBack(event:Event):void{
			dispatchEvent(new EventViewCreateList(EventViewCreateList.BACK_TO_MAIN_SCREEN));							
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