package com.Application.robotlegs.views.menu {
	import com.Application.robotlegs.views.ViewAbstract;
	
	import flash.text.engine.ElementFormat;
	
	import ch.ala.locale.LocaleManager;
	
	import feathers.controls.Label;
	import feathers.display.Scale9Image;
	import feathers.skins.IStyleProvider;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	
	public class ViewMenu extends ViewAbstract {									
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
		
		private var _containerBG:Sprite;
		
		private var _quadBG:Quad;
		
		private var _imageSettings:Image;
		private var _imageBGSettings:Scale9Image;
		
		private var _labelSettings:Label;
		
		private var _labelMenuElementFormat:ElementFormat;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ViewMenu() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		override public function destroy():void{
			super.destroy();
			
			
			
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		override protected function get defaultStyleProvider():IStyleProvider {
			return ViewMenu.globalStyleProvider;
		}
		
		public function get resourceManager():LocaleManager{
			return _resourceManager;
		}
		
		public function set textureSettings(value:Texture):void{
			if(value){
				if(!_imageSettings){
					_imageSettings = new Image(value);
				}
			}
		}
		public function set backgroundDarkGrey(value:Scale9Textures):void{
			if(value){
				if(!_imageBGSettings){
					_imageBGSettings = new Scale9Image(value);
				}
			}
		}
		public function set labelMenuElementFormat(value:ElementFormat):void{
			_labelMenuElementFormat = value;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		override protected function _initialize():void{
			super._initialize();
			
			_containerBG = new Sprite();
			addChild(_containerBG);
			
			_quadBG = new Quad(10,10,0x0d0d0d);
			_containerBG.addChild(_quadBG);
			
			_header.visible = false;
			
			_labelSettings = new Label();
			_containerBG.addChild(_labelSettings);
		}
		
		override protected function draw():void{
			super.draw();
			
			var pGap:Number = int(50*_scaleWidth);
			
			if(_quadBG){
				_quadBG.width = actualWidth;
				_quadBG.height = actualHeight;
			}
			
			if(_imageSettings){
				if(!contains(_imageSettings)){
					_containerBG.addChild(_imageSettings);
				}
				_imageSettings.scaleX = _imageSettings.scaleY = _scaleWidth;
				_imageSettings.x = pGap;
				_imageSettings.y = pGap;
			}
			if(_imageBGSettings){
				if(!contains(_imageBGSettings)){
					_containerBG.addChildAt(_imageBGSettings,1);
				}
				_imageBGSettings.width = actualWidth;
				_imageBGSettings.height = _imageSettings.y + _imageSettings.height + pGap;
			}
			
			if(_labelSettings){
				_labelSettings.text = "Settings";
				_labelSettings.textRendererProperties.elementFormat = _labelMenuElementFormat;
				_labelSettings.validate();
				_labelSettings.x = _imageSettings.x + _imageSettings.width + int(24*_scaleWidth);
				_labelSettings.y = _imageSettings.y + _imageSettings.height/2 - _labelSettings.height/2; 
			}
			
			_containerBG.flatten();
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