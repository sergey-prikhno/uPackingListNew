package com.Application.components.calendar.stepper{
	import com.common.Constants;
	
	import flash.text.TextFormatAlign;
	import flash.text.engine.ElementFormat;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.core.FeathersControl;
	import feathers.skins.IStyleProvider;
	
	import starling.display.Quad;
	import starling.events.Event;
	
	public class CalendarStepper extends FeathersControl{
		
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
		
		private var _scale:Number = 1;
		
		private var _label:Label;
		
		private var _buttonUp:Button;
		private var _buttonDown:Button;
		
		private var _data:String = "";
		
		private var _elementFormatLabelStepper:ElementFormat;
		
		private var _quadBG:Quad;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function CalendarStepper(){
			super();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function destroy():void{
			
			_data = null;
			
			if(_buttonUp){
				_buttonUp.removeEventListener(Event.TRIGGERED, _handlerButtonUp);
				removeChild(_buttonUp, true);
				_buttonUp = null;
			}
			if(_buttonDown){
				_buttonDown.removeEventListener(Event.TRIGGERED, _handlerButtonDown);
				removeChild(_buttonDown, true);
				_buttonDown = null;
			}
			if(_label){
				removeChild(_label, true);
				_label = null;
			}
			if(_quadBG){
				removeChild(_quadBG, true);
				_quadBG = null;
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		override protected function get defaultStyleProvider():IStyleProvider {
			return CalendarStepper.globalStyleProvider;
		}
		public function get data():String{return _data;}
		public function set data(value:String):void{
			_data = value;
			invalidate(INVALIDATION_FLAG_DATA);
		}
		
		public function set scale(value:Number):void{
			_scale = value;
		}
		public function set elementFormatLabelStepper(value:ElementFormat):void{_elementFormatLabelStepper = value;}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		override protected function initialize():void{
			if(!_quadBG){
				_quadBG = new Quad(10,10,0xffffff);
				addChild(_quadBG);
			}
			
			if(!_buttonUp){
				_buttonUp = new Button();
				_buttonUp.nameList.add(Constants.BUTTON_STEPPER_UP);
				_buttonUp.addEventListener(Event.TRIGGERED, _handlerButtonUp);
				addChild(_buttonUp);
			}
			if(!_buttonDown){
				_buttonDown = new Button();
				_buttonDown.nameList.add(Constants.BUTTON_STEPPER_DOWN);
				_buttonDown.addEventListener(Event.TRIGGERED, _handlerButtonDown);
				addChild(_buttonDown);
			}
			if(!_label){
				_label = new Label();
				addChild(_label);
			}
		}
		
		override protected function draw():void{
			if(_buttonUp){
				_buttonUp.scaleX = _buttonUp.scaleY = _scale;
				_buttonUp.validate();
				_buttonUp.x = int(actualWidth/2 - _buttonUp.width/2);
			}
			if(_quadBG){
				_quadBG.width = actualWidth;
				_quadBG.height = actualHeight;
				_quadBG.y = _buttonUp.height;
			}
			
			if(_label){
				_label.width = actualWidth;
				_label.text = _data;
				_label.textRendererProperties.elementFormat = _elementFormatLabelStepper;
				_label.textRendererProperties.textAlign = TextFormatAlign.CENTER;
				_label.validate();
				_label.x = int(_quadBG.width/2 - _label.width/2);
				_label.y = _quadBG.y + (_quadBG.height/2 - _label.height/2);
			}
			
			
			if(_buttonDown){
				_buttonDown.scaleX = _buttonDown.scaleY = _scale;
				_buttonDown.x = _buttonUp.x;
				_buttonDown.y = _quadBG.y + _quadBG.height;
				
			}
			

		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerButtonUp(event:Event):void{
			dispatchEvent(new EventCalendarStepper(EventCalendarStepper.CLICK_UP));
		}
		
		private function _handlerButtonDown(event:Event):void{
			dispatchEvent(new EventCalendarStepper(EventCalendarStepper.CLICK_DOWN));
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