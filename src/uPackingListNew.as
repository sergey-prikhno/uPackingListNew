package{
	import com.Application.Main;
	import com.common.Constants;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	
	import starling.core.Starling;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	[SWF(width="1136",height="640",frameRate="35",backgroundColor="0x52c9ce")]
	
	public class uPackingListNew extends Sprite{
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public static const APP_WIDTH:int = 640;
		public static const APP_HEIGHT:int = 1136;	
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		
		private var _starling:Starling;
		private var _launchImage:Loader;
		private var _bitmapLaunchImage:Bitmap;	
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function uPackingListNew(){
			if(this.stage) {
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.align = StageAlign.TOP_LEFT;
			}
			
			this.mouseEnabled = this.mouseChildren = false;
			this.showLaunchImage();
			this.loaderInfo.addEventListener(flash.events.Event.COMPLETE, loaderInfo_completeHandler);
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
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		private function showLaunchImage():void {																			
			
			this._launchImage = new Loader();									
			this._launchImage.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, _handlerSplashLoaded, false, 0, true);
			this._launchImage.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, _handlerSplashIOError, false, 0, true);
			
			
			this._launchImage.load(new URLRequest(Constants.APP_SPLASH));			
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		private function _handlerSplashIOError(event:flash.events.Event):void{
			this._launchImage.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, _handlerSplashLoaded, false);
			this._launchImage.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, _handlerSplashIOError, false);
			
			this._launchImage.unloadAndStop(true);
			this._launchImage = null;
		}
		
		private function _handlerSplashLoaded(event:flash.events.Event):void{
			this._launchImage.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, _handlerSplashLoaded, false);
			this._launchImage.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, _handlerSplashIOError, false);
			
			
			_bitmapLaunchImage = Bitmap(_launchImage.content);
			_bitmapLaunchImage.scaleY = _bitmapLaunchImage.scaleX = stage.fullScreenWidth/ uPackingListNew.APP_WIDTH; 
			_bitmapLaunchImage.smoothing = true;						
			addChild(_bitmapLaunchImage);
			
			
			this._launchImage.unloadAndStop(true);
			this._launchImage = null;
		}
		
		private function loaderInfo_completeHandler(event:flash.events.Event):void	{			
			var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
			
			Starling.multitouchEnabled = true;  // useful on mobile devices
			Starling.handleLostContext = !iOS;  // not necessary on iOS. Saves a lot of memory!
			//Starling.handleLostContext = true;							
			
			
			_starling = new Starling(Main, this.stage);
			_starling.simulateMultitouch = true;
			_starling.enableErrorChecking = Capabilities.isDebugger;
			//_starling.showStats = !Capabilities.isDebugger;
			_starling.showStatsAt(HAlign.LEFT, VAlign.BOTTOM);
			_starling.addEventListener(Event.ADDED_TO_STAGE, starling_rootCreatedHandler);									
			
			_starling.start();
			
			this.stage.addEventListener(flash.events.Event.RESIZE, stage_resizeHandler, false, int.MAX_VALUE, true);
			this.stage.addEventListener(flash.events.Event.DEACTIVATE, stage_deactivateHandler, false, 0, true);			
		}
		
		
		private function starling_rootCreatedHandler(event:Object):void {
			_starling.removeEventListener(Event.ADDED_TO_STAGE, starling_rootCreatedHandler);
			
			if(this._bitmapLaunchImage) {
				if(contains(_bitmapLaunchImage)){
					this.removeChild(this._bitmapLaunchImage);
					this._bitmapLaunchImage.bitmapData.dispose();
				}				
				this._bitmapLaunchImage = null;			
			}
			
		}
		
		private function stage_resizeHandler(event:flash.events.Event):void {
			this._starling.stage.stageWidth = this.stage.stageWidth;
			this._starling.stage.stageHeight = this.stage.stageHeight;
			
			const viewPort:Rectangle = this._starling.viewPort;
			viewPort.width = this.stage.stageWidth;
			viewPort.height = this.stage.stageHeight;
			try {
				this._starling.viewPort = viewPort;
			}
			catch(error:Error) {}		
		}
		
		
		private function stage_deactivateHandler(event:flash.events.Event):void {
			this._starling.stop();
			this.stage.addEventListener(flash.events.Event.ACTIVATE, stage_activateHandler, false, 0, true);
		}
		
		
		private function stage_activateHandler(event:flash.events.Event):void {
			this.stage.removeEventListener(flash.events.Event.ACTIVATE, stage_activateHandler);
			this._starling.start();
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