package com.Application.robotlegs.views.components.searchInput {
	import com.common.Constants;
	
	import flash.display.Stage;
	
	import ch.ala.locale.LocaleManager;
	
	import feathers.controls.Button;
	import feathers.controls.TextInput;
	import feathers.core.FeathersControl;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	public class SearchInput extends FeathersControl {		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		private var _textInput:TextInput;
		private var _buttonCancel:Button;
		private var _nativeStage:Stage;
		
		private var _text:String = "";
		protected var _resourceManager:LocaleManager;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function SearchInput() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function destroy():void{
			
			if(_textInput){
				_textInput.removeEventListener(Event.CHANGE, _handlerChange);
				removeChild(_textInput);
				_textInput = null;
			}
						 
			if(_buttonCancel){
				_buttonCancel.removeEventListener(Event.TRIGGERED, _handlerCancel);
				removeChild(_buttonCancel);	
				_buttonCancel = null;
			}
								
		}		
		
		public function reset():void{
			if(_textInput){
				_textInput.text = "";
			}
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get text():String { return _text;}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		override protected function initialize():void{
			super.initialize();
			
			_resourceManager = LocaleManager.getInstance();
			_nativeStage = Starling.current.nativeStage;
			
			_textInput = new TextInput();
			_textInput.prompt = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "search.prompt");
			_textInput.addEventListener(Event.CHANGE, _handlerChange);
			addChild(_textInput);
			
			_buttonCancel = new Button();
			_buttonCancel.label = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "button.cancel");
			_buttonCancel.addEventListener(Event.TRIGGERED, _handlerCancel);
			addChild(_buttonCancel);					
		}
		
		
		override protected function draw():void{
			super.draw();
			
			if(width != 0){
				
				if(_textInput){
					_textInput.x = 0;
					_textInput.y = 0;
					_textInput.width = int(width/1.2);
					_textInput.height = height;
					_textInput.validate();
				}
				
				
				if(_buttonCancel){
					_buttonCancel.width = int(width - _textInput.width);
					_buttonCancel.height = height;
					_buttonCancel.validate();
					_buttonCancel.x = int(width - _buttonCancel.width);
					_buttonCancel.y = 0;
				}
								
			}
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerChange(event:Event):void{
			_text = _textInput.text;
			dispatchEvent(new EventSearchInput(EventSearchInput.CHANGE));
		}
		
		private function _handlerCancel(event:Event):void{			
			dispatchEvent(new EventSearchInput(EventSearchInput.CANCEL));
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