package com.Application.robotlegs.views.popups{
	import flash.display.Stage;
	
	import ch.ala.locale.LocaleManager;
	
	import feathers.core.FeathersControl;
	import feathers.skins.IStyleProvider;
	
	import starling.core.Starling;
	
	public class PopupAbstract extends FeathersControl{
		
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
		
		protected var _resourcesManager:LocaleManager;
		protected var _nativeStage:Stage;
		
		protected var _scaleWidth:Number;
		protected var _scaleHeight:Number;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function PopupAbstract(){
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
		
		public function set scaleHeight(value:Number):void{_scaleHeight = value;}
		public function set scaleWidth(value:Number):void{	_scaleWidth = value;}

		override protected function get defaultStyleProvider():IStyleProvider {
			return PopupAbstract.globalStyleProvider;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		override protected function initialize():void{	
			_resourcesManager = LocaleManager.getInstance();			
			_nativeStage = Starling.current.nativeStage;									
			_initialize();
		}
		
		override protected function draw():void{
			_draw();
		}	
		
		protected function _initialize():void{
			
		}
		
		protected function _draw():void{
						
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