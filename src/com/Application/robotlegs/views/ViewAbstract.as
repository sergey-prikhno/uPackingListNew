package com.Application.robotlegs.views {
	import com.common.Constants;
	
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
			_header.nameList.add(Constants.CUSTOM_HEADER_NAME);
			addChild(_header);
			
			_initialize();	
		}		
		
		
		override protected function draw():void{
			super.draw();
			
			var stylesInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_STYLES);
			
			
			if(_header){										
				_header.width = _nativeStage.fullScreenWidth;
				_header.height = int(88*_scaleHeight);
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