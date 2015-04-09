package com.Application.robotlegs.views.popups.removeList {
	import com.Application.robotlegs.views.popups.PopupAbstract;
	import com.common.Constants;
	
	import flash.text.engine.ElementFormat;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.skins.IStyleProvider;
	
	import starling.display.Quad;
	import starling.events.Event;
	
	public class PopupRemoveList extends PopupAbstract {		
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
		private var _buttonCancel:Button;
		private var _buttonRemove:Button;		
		private var _label:Label;
		
		private var _quadBG:Quad;
		private var _lineH:Quad;
		private var _lineV:Quad;
		
		private var _efPopupRemoveDesc:ElementFormat;
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function PopupRemoveList() {
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
			if(_lineH){
				removeChild(_lineH, true);
				_lineH = null;
			}
			if(_lineV){
				removeChild(_lineV, true);
				_lineV = null;
			}
			
			if(_label){
				removeChild(_label, true);
				_label = null;
			}
			
			if(_buttonCancel){
				_buttonCancel.nameList.remove(Constants.SKIN_POPUP_WHITE_BUTTON);
				_buttonCancel.removeEventListener(Event.TRIGGERED, _handlerButtonCancel);
				removeChild(_buttonCancel, true);
				_buttonCancel = null;
			}
			if(_buttonRemove){
				_buttonRemove.nameList.remove(Constants.SKIN_POPUP_WHITE_BUTTON);
				_buttonRemove.removeEventListener(Event.TRIGGERED, _handlerButtonRemove);
				removeChild(_buttonRemove, true);
				_buttonRemove = null;
			}
			
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		override protected function get defaultStyleProvider():IStyleProvider {
			return PopupRemoveList.globalStyleProvider;
		}
	
		public function set efPopupRemoveDesc(value:ElementFormat):void{_efPopupRemoveDesc = value;}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		override protected function _initialize():void{
			super._initialize();
			
			_quadBG = new Quad(10,10,0xffffff);
			addChild(_quadBG);
			
			_label = new Label();
			addChild(_label);
			
	
			
			_buttonRemove = new Button();
			_buttonRemove.nameList.add(Constants.SKIN_POPUP_WHITE_BUTTON);
			_buttonRemove.label = _resourcesManager.getString(Constants.RESOURCES_BUNDLE, "button.delete");
			_buttonRemove.addEventListener(Event.TRIGGERED, _handlerButtonRemove);
			addChild(_buttonRemove);
			_buttonRemove.validate();
			
			_buttonCancel = new Button();
			_buttonCancel.nameList.add(Constants.SKIN_POPUP_WHITE_BUTTON);
			_buttonCancel.label = _resourcesManager.getString(Constants.RESOURCES_BUNDLE, "button.cancel");
			_buttonCancel.addEventListener(Event.TRIGGERED, _handlerButtonCancel);
			addChild(_buttonCancel);
			_buttonCancel.validate();
			
			_lineH = new Quad(10,1,0xadadad);
			addChild(_lineH);
			
			_lineV = new Quad(1,1,0xadadad);
			addChild(_lineV);
			
		}
		
		override protected function _draw():void{
			super._draw();
			
			if(_quadBG){
				_quadBG.width = _nativeStage.stageWidth - int(80*_scaleWidth);
				_quadBG.height = int(300*_scaleHeight);
				_quadBG.x = _nativeStage.stageWidth/2 - _quadBG.width/2;
				_quadBG.y = _nativeStage.stageHeight/2 - _quadBG.height/2; 
			}
			
			if(_label){	
				_label.text = _resourcesManager.getString(Constants.RESOURCES_BUNDLE, "warning.deleteList");
				_label.textRendererProperties.elementFormat = _efPopupRemoveDesc;	
				_label.validate();
				_label.x = _quadBG.x + _quadBG.width/2 - _label.width/2;
				_label.y = _quadBG.y + int(80*_scaleHeight);
			}
			
			
			if(_buttonRemove){
				_buttonRemove.width = _quadBG.width/2;
				_buttonRemove.height = int(100*_scaleHeight);
				_buttonRemove.x = _quadBG.x; 
				_buttonRemove.y = _quadBG.y + _quadBG.height - _buttonRemove.height;
			}			
			if(_buttonCancel){
				_buttonCancel.width = _quadBG.width/2;
				_buttonCancel.height = int(100*_scaleHeight);
				_buttonCancel.x = _quadBG.x + _quadBG.width - _buttonCancel.width; 
				_buttonCancel.y = _buttonRemove.y;
			}
			
			if(_lineH){
				_lineH.width = _quadBG.width;
				_lineH.x = _quadBG.x;
				_lineH.y = _buttonCancel.y;
			}
			if(_lineV){
				_lineV.height = _buttonCancel.height;
				_lineV.x = _buttonCancel.x;
				_lineV.y = _buttonCancel.y;
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		private function _handlerButtonCancel(event:Event):void{
			dispatchEvent(new EventPopupRemoveList(EventPopupRemoveList.CANCEL_POPUP));
		}
				
		
		private function _handlerButtonRemove(event:Event):void{
			dispatchEvent(new EventPopupRemoveList(EventPopupRemoveList.REMOVE_LIST));
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