package com.Application.components.screenLoader{			
			
	import com.Application.components.loadingIndicator.LoadingIndicator;
	
	import feathers.core.FeathersControl;
	
	import starling.core.Starling;
	import starling.display.Quad;
	
	public class ScreenLoader extends FeathersControl{
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
		private var _scaleWidth:Number;		
					
		private var _background:Quad; 		
		private var _preloaderCircle:LoadingIndicator; 			
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------		
		public function ScreenLoader() {
			super();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function set scaleWidth(pValue:Number):void {			
			_scaleWidth = pValue;							
		}						
		
		
		override public function set visible(value:Boolean):void{
			super.visible = value;
			
			_background.visible = value;
			_preloaderCircle.visible = value;						
		}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		override protected function initialize():void {
			super.initialize();
									
			
			_background = new Quad(Starling.current.nativeStage.fullScreenWidth, Starling.current.nativeStage.fullScreenHeight, 0x000000);
			_background.alpha = .3;
			addChild(_background);
			
			_preloaderCircle = new LoadingIndicator(); 	
			_preloaderCircle.x = Math.round((Starling.current.nativeStage.fullScreenWidth - _preloaderCircle.width) / 2);						
			_preloaderCircle.y = Math.round((Starling.current.nativeStage.fullScreenHeight - _preloaderCircle.height) / 2);		
			addChild(_preloaderCircle);
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