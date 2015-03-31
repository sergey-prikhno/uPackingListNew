package com.Application.components.loadingIndicator{
	import feathers.core.FeathersControl;
	import feathers.skins.IStyleProvider;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.deg2rad;
	
	public class LoadingIndicator extends FeathersControl {
				
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
		private var _circle:Image;
		private var _circleTexture:Texture;
				
		private var _scaleWidth:Number = 1;		
		private var _tween:Tween;								
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function LoadingIndicator() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function destroy():void{
			_stopAnimation();		
			
			if(contains(_circle)){
				removeChild(_circle);
			}
			_circle = null;	
			
			_circleTexture = null;
		}		
		
		private function _stopAnimation():void{
			Starling.juggler.removeTweens(_circle);	
		}
		
		private function _startAnimation():void{
			
			_tween = new Tween(_circle,1);			
			_tween.animate("rotation",deg2rad(360));
			_tween.onComplete = onComplateTween;			
			
			
			Starling.juggler.add(_tween);			
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function set circle(value:Texture):void{			
			if(!value){
				return;
			}
			
			_circleTexture = value;
			invalidate(INVALIDATION_FLAG_SKIN);						
		}	
		
		public function set scaleWidth(value:Number):void{
			_scaleWidth = value;
		}		
		
		override public function set visible(value:Boolean):void{
			super.visible = value;
			
			if(!visible){
				_stopAnimation();
			} else {
				_startAnimation();
			}
		}
		
		override protected function get defaultStyleProvider():IStyleProvider {
			return LoadingIndicator.globalStyleProvider;
		}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		override protected function initialize():void{
			super.initialize();
				
		}
		
		override protected function draw():void{
			var skinInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SKIN);
			
			if(skinInvalid){
				_createCircle();
			}
		}
		
		
		private function _createCircle():void{
			_circle = new Image(_circleTexture);
			_circle.smoothing = TextureSmoothing.TRILINEAR;
			
			
			_circle.pivotX = _circle.width/2;
			_circle.pivotY = _circle.height/2;	
			_circle.width = _circle.width * _scaleWidth;
			_circle.height = _circle.height * _scaleWidth;				
			addChild(_circle);										
			
			width = _circle.width;
			height = _circle.height;		
			
			_startAnimation();				
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
		private function onComplateTween():void {
			Starling.juggler.removeTweens(_circle);
			
			var pTween:Tween = new Tween(_circle,1);
				pTween.nextTween = _tween;						
				pTween.animate("rotation",deg2rad(360));
				pTween.onComplete = onComplateTween;			
			
						
			Starling.juggler.add(pTween);
		}						 	
	
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}