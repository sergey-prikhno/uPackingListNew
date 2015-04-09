package com.Application.robotlegs.views.popups.info{
	import com.Application.robotlegs.model.vo.VOInfo;
	import com.Application.robotlegs.views.popups.PopupAbstract;
	import com.common.Constants;
	
	import flash.text.engine.ElementFormat;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.skins.IStyleProvider;
	
	import starling.display.Quad;
	import starling.events.Event;
	
	public class PopupInfo extends PopupAbstract{
		
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
		
		private var _buttonOk:Button;
		private var _labelTitle:Label;
		private var _labelDesc:Label;
		private var _quadBG:Quad;
		
		private var _voInfo:VOInfo;
		
		private var _efPopupInfoTitle:ElementFormat;
		private var _efPopupInfoDesc:ElementFormat;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function PopupInfo(){
			super();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function destroy():void{
			if(_quadBG){
				removeChild(_quadBG, true);
				_quadBG = null;
			}
			if(_labelTitle){
				removeChild(_labelTitle, true);
				_labelTitle = null;
			}
			if(_labelDesc){
				removeChild(_labelDesc, true);
				_labelDesc = null;
			}
			if(_buttonOk){
				_buttonOk.nameList.remove(Constants.BUTTON_INFO_POPUP);
				_buttonOk.removeEventListener(Event.TRIGGERED, _handlerButtonOk);
				removeChild(_buttonOk, true);
				_buttonOk = null;
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		override protected function get defaultStyleProvider():IStyleProvider {
			return PopupInfo.globalStyleProvider;
		}
		public function set voInfo(value:VOInfo):void{_voInfo = value;}
		public function set efPopupInfoDesc(value:ElementFormat):void{_efPopupInfoDesc = value;}
		public function set efPopupInfoTitle(value:ElementFormat):void{	_efPopupInfoTitle = value;	}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		override protected function _initialize():void{
			super._initialize();
			
			_quadBG = new Quad(10,10,0xf7941d);
			addChild(_quadBG);
			
			_labelTitle = new Label();
			addChild(_labelTitle);
			
			_labelDesc = new Label();
			addChild(_labelDesc);
			
			_buttonOk = new Button();
			_buttonOk.nameList.add(Constants.BUTTON_INFO_POPUP);
			_buttonOk.addEventListener(Event.TRIGGERED, _handlerButtonOk);
			addChild(_buttonOk);
		}
		
		override protected function _draw():void{
			super._draw();
			
			if(_quadBG){
				_quadBG.width = _nativeStage.stageWidth - int(60*_scaleWidth);
				_quadBG.height = (300*_scaleHeight);
				_quadBG.x = _nativeStage.stageWidth/2 - _quadBG.width/2;
				_quadBG.y = _nativeStage.stageHeight/2 - _quadBG.height/2; 
			}
			
			if(_labelTitle){
				_labelTitle.text = _voInfo.infoTitle;
				_labelTitle.textRendererProperties.elementFormat = _efPopupInfoTitle;
				_labelTitle.validate();
				_labelTitle.x = _quadBG.x + _quadBG.width/2 - _labelTitle.width/2;
				_labelTitle.y = _quadBG.y + int(32*_scaleHeight);
			}
			
			if(_labelDesc){
				_labelDesc.text = _voInfo.infoDesc;
				_labelDesc.textRendererProperties.elementFormat = _efPopupInfoDesc;
				_labelDesc.validate();
				_labelDesc.x = _quadBG.x + _quadBG.width/2 - _labelDesc.width/2;
				_labelDesc.y = _labelTitle.y +_labelTitle.height + int(32*_scaleHeight);
			}
			
			if(_buttonOk){
				_buttonOk.width = _quadBG.width;
				_buttonOk.height = int(100*_scaleHeight);
				_buttonOk.label = _resourcesManager.getString(Constants.RESOURCES_BUNDLE, "button.ok");
				_buttonOk.validate();
				_buttonOk.x = _quadBG.x; 
				_buttonOk.y = _quadBG.y + _quadBG.height - _buttonOk.height;
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
		private function _handlerButtonOk(event:Event):void{
			dispatchEvent(new EventPopupInfo(EventPopupInfo.CLOSE_POPUP_INFO));
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