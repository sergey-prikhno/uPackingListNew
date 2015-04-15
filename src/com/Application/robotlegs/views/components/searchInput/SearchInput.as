package com.Application.robotlegs.views.components.searchInput {
	import com.common.Constants;
	
	import flash.display.Stage;
	
	import ch.ala.locale.LocaleManager;
	
	import feathers.controls.TextInput;
	import feathers.core.FeathersControl;
	import feathers.display.Scale9Image;
	import feathers.skins.IStyleProvider;
	import feathers.textures.Scale9Textures;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	public class SearchInput extends FeathersControl {		
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
		private var _textInput:TextInput;

		private var _nativeStage:Stage;
		
		private var _text:String = "";
		protected var _resourceManager:LocaleManager;
		
		private var _scaleW:Number = 1;
		private var _scaleH:Number = 1;
		private var _imageBG:Scale9Image;
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
		public function set scaleH(value:Number):void{_scaleH = value;}
		public function set scaleW(value:Number):void{_scaleW = value;}
		public function set backgroundGrey(value:Scale9Textures):void{
			if(value){
				if(!_imageBG){
					_imageBG = new Scale9Image(value, _scaleH);
				}
			}
		}
		override protected function get defaultStyleProvider():IStyleProvider {
			return SearchInput.globalStyleProvider;
		}
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
			_textInput.nameList.add(Constants.INPUT_TEXT_SEARCH_CUSTOM);
			_textInput.prompt = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "search.prompt");
			_textInput.addEventListener(Event.CHANGE, _handlerChange);
			addChild(_textInput);
			
								
		}
		
		
		override protected function draw():void{
			super.draw();
			if(_imageBG && !contains(_imageBG)){
				_imageBG.width = _nativeStage.stageWidth;
				addChildAt(_imageBG, 0);
			}
			height = int(_imageBG.height);
			
			if(_textInput){
				_textInput.width = width - int(60*_scaleH);
				_textInput.height = int(60*_scaleH);
				_textInput.validate();
				_textInput.x = int(width/2 - _textInput.width/2);
				_textInput.y = int(height/2 - _textInput.height/2);
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