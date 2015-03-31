package com.Application.robotlegs.views {
	import flash.display.Stage;
	
	import ch.ala.locale.LocaleManager;
	
	import feathers.controls.Header;
	import feathers.controls.Screen;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.core.Starling;
	
	public class ViewAbstract extends Screen {		
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
		protected var _resourceManager:LocaleManager;		
		protected var _nativeStage:Stage;
		
		protected var _scaleWidth:Number = 1;
		protected var _scaleHeight:Number = 1;
		
		protected var _baseBackground:Scale9Image;
		
		protected var _header:Header;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ViewAbstract() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function activate():void{
			trace("activate");
						
		}
		
		public function destroy():void{
			trace("destroy");
			
			if(_baseBackground){				
				removeChild(_baseBackground);
				_baseBackground = null;
			}
		}				
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function set scaleWidth(value:Number):void{
			_scaleWidth = value;
		}
		
		public function set scaleHeight(value:Number):void{
			_scaleHeight = value;
		}
		
		public function set baseBackground(value:Scale9Textures):void{
			_baseBackground = new Scale9Image(value);	
			invalidate(INVALIDATION_FLAG_STYLES);
		}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		// must ovveride in sub class
		protected function _initialize():void{
									
		}		
		
		override protected function initialize():void{	
			super.initialize();
			
			_resourceManager = LocaleManager.getInstance();
			_nativeStage = Starling.current.nativeStage;
						
			_header = new Header();
			addChild(_header);
			
			_initialize();	
		}		
		
		
		override protected function draw():void{
			super.draw();
			
			var stylesInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_STYLES);
			
			if(stylesInvalid){			
				if(_baseBackground && !contains(_baseBackground)){
					_baseBackground.width = _nativeStage.fullScreenWidth;
					_baseBackground.height = _nativeStage.fullScreenHeight;
					addChildAt(_baseBackground, 0);
				}
			}
			
			if(_header){										
				_header.width = _nativeStage.fullScreenWidth;
			}
						
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
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