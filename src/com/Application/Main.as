package com.Application {
	import com.Application.components.screenLoader.ScreenLoader;
	import com.Application.robotlegs.model.vo.VOAppSettings;
	import com.Application.robotlegs.model.vo.VOScreenID;
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.Application.robotlegs.views.createList.EventViewCreateList;
	import com.Application.robotlegs.views.createList.ViewCreateList;
	import com.Application.robotlegs.views.list.ViewList;
	import com.Application.robotlegs.views.main.EventViewMain;
	import com.Application.robotlegs.views.main.ViewMain;
	import com.Application.robotlegs.views.menu.ViewMenu;
	import com.Application.robotlegs.views.packedList.EventViewPackedList;
	import com.Application.robotlegs.views.packedList.ViewPackedList;
	import com.Application.themes.ApplicationTheme;
	import com.common.Constants;
	
	import flash.system.System;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import ch.ala.locale.LocaleManager;
	
	import feathers.controls.Drawers;
	import feathers.controls.StackScreenNavigator;
	import feathers.controls.StackScreenNavigatorItem;
	import feathers.events.FeathersEventType;
	import feathers.motion.Fade;
	import feathers.motion.Slide;
	
	import org.robotlegs.starling.mvcs.Context;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Main extends Sprite {
		
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
		
		private var _theme:ApplicationTheme;		
		private var _locales:LocaleManager;		
		
		public static const VIEW_MAIN:String = "VIEW_MAIN";		
		public static const VIEW_CREATE_LIST:String = "VIEW_CREATE_LIST";		
		public static const VIEW_PACKED_LIST:String = "VIEW_PACKED_LIST";		
		public static const VIEW_LIST:String = "VIEW_LIST";		
		
		
		private var _navigator:StackScreenNavigator;				
		private var _screenCurrent:ViewAbstract;		
		
		// Garbage collector calls handling
		private var _garbageCollectorCallCount:int;
		private var _garbageCollectorCallTimeout:int;
		
		private var _starlingContext:Context;
		
		private var _screenLoader:ScreenLoader;
		private var _settings:VOAppSettings;
		
		private var _drawers:Drawers;
		private var _viewMenu:ViewMenu;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function Main() 	{
			super();			
			
			_starlingContext = new StarlingAppContext(this);
			addEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
		}
		
		private function _handlerAddedToStage(event:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, _handlerAddedToStage);
			_initialize();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		protected function _initialize():void{
			this._navigator = new StackScreenNavigator();
			
			_locales = new LocaleManager();
			_locales.localeChain = ["en_US"];			
			_locales.addRequiredBundles([{locale:"en_US", bundleName:Constants.RESOURCES_BUNDLE, useLinebreak:true}], _handlerLocaleLoaded);
		}		
		
		
		public function addLoader():void {
			if(!_screenLoader.visible){																								
				_screenLoader.visible = true;		
				_navigator.touchable = false;
			}
		}
		
		public function removeLoader():void {
			if(_screenLoader.visible){				
				_screenLoader.visible = false;
				_navigator.touchable = true;
			}			
		}			
		
		public function changeScreen(pVO:VOScreenID):void{
			_navigator.pushScreen(pVO.screenID);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function set settings(value:VOAppSettings):void{
			_settings = value;
			_continueAppInit();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		private var pCreateListItem:StackScreenNavigatorItem;
		private var pListItem:StackScreenNavigatorItem;
		private var pMainItem:StackScreenNavigatorItem;
		private var pPakingListItem:StackScreenNavigatorItem;
		
		private function _continueAppInit():void{
			var pW:Number = Starling.current.stage.stageWidth;
			var pH:Number = Starling.current.stage.stageHeight;
			
			Starling.current.dispatchEvent(new Event(Event.ADDED_TO_STAGE,true));							
			
			
			_viewMenu = new ViewMenu();
			_viewMenu.styleNameList.add(Constants.LEFT_MENU_NAME_LIST);
			
			_drawers = new Drawers();
			_drawers.content = this._navigator;
			_drawers.leftDrawer = _viewMenu;
			_drawers.openGesture = Drawers.OPEN_GESTURE_NONE;
			_drawers.leftDrawer.width = pW - (99 * pW/uPackingListNew.APP_WIDTH);
			_drawers.leftDrawer.height = pH;
			addChild(_drawers);
			_drawers.validate();
			
			
			pMainItem = new StackScreenNavigatorItem(ViewMain);
				pMainItem.setFunctionForPushEvent(EventViewMain.SHOW_MAIN_MENU, _handlerAppMenu);
				pMainItem.setScreenIDForPushEvent(EventViewMain.CREATE_NEW_LIST, VIEW_CREATE_LIST);
				pMainItem.pushTransition = Slide.createSlideRightTransition();
			this._navigator.addScreen(VIEW_MAIN, pMainItem);
			
			pCreateListItem = new StackScreenNavigatorItem(ViewCreateList);
				pCreateListItem.setScreenIDForPushEvent(EventViewAbstract.BACK_TO_MAIN_LIST_SCREEN, VIEW_MAIN);
				pCreateListItem.setScreenIDForPushEvent(EventViewCreateList.SHOW_VIEW_PACK_LIST, VIEW_PACKED_LIST);
				pCreateListItem.pushTransition = Slide.createSlideLeftTransition();
			this._navigator.addScreen(VIEW_CREATE_LIST, pCreateListItem);
			
			pPakingListItem = new StackScreenNavigatorItem(ViewPackedList);
				pPakingListItem.setScreenIDForPushEvent(EventViewAbstract.BACK_TO_MAIN_LIST_SCREEN, VIEW_MAIN);
				pPakingListItem.setScreenIDForPushEvent(EventViewPackedList.GOTO_VIEW_LIST, VIEW_LIST);
				pPakingListItem.setFunctionForPushEvent(EventViewPackedList.BACK_TO_VIEW_CREATE, _backToViewCreate);
				pPakingListItem.pushTransition = Slide.createSlideLeftTransition();
			this._navigator.addScreen(VIEW_PACKED_LIST, pPakingListItem);
	
			pListItem = new StackScreenNavigatorItem(ViewList);
				pListItem.pushTransition = Slide.createSlideLeftTransition();
			this._navigator.addScreen(VIEW_LIST, pListItem);
			
			this._navigator.rootScreenID = VIEW_MAIN;	
			
			this._navigator.pushTransition = Fade.createFadeInTransition();
			this._navigator.popTransition = Fade.createFadeInTransition();	
			
			
			
			_screenLoader = new ScreenLoader();
			addChild(_screenLoader);	
			_screenLoader.touchable = false;
			_screenLoader.isEnabled = false;
			_screenLoader.visible = false;						
		}
		
		private function _handlerAppMenu():void{
			_drawers.toggleLeftDrawer();
		}
		
		private function _backToViewCreate():void{
			pCreateListItem.pushTransition = Slide.createSlideRightTransition();
			_navigator.pushScreen(VIEW_CREATE_LIST);
			pCreateListItem.pushTransition = Slide.createSlideLeftTransition();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerLocaleLoaded(event:* = null):void{
			
			_theme = new ApplicationTheme("/assets/textures/");
			
			_theme.addEventListener(Event.COMPLETE, _handlerThemeCreated);
			_theme.addEventListener(Event.CHANGE, _handlerChange);						
		}
		
		
		private function _handlerThemeCreated(event:Event):void{		
			_theme.removeEventListener(Event.COMPLETE, _handlerThemeCreated);		
			_theme.removeEventListener(Event.CHANGE, _handlerChange);			
			
			_starlingContext.dispatchEvent(new EventMain(EventMain.INITIALIZE_DATABASE));			
		}
		
		private function _handlerChange(event:Event):void{
			trace("downloading "+event.data.progress+ " % ");			
		}	
		
		private function _handlerTransition(event:Event):void{
			
			switch (event.type){
				case FeathersEventType.TRANSITION_START:
					//	addLoader();
					
					trace("> FeathersEventType.TRANSITION_START");
					/*if(_screenCurrent){
					// Stopping current view animations and removing controls listeners 
						_screenCurrent.destroy();
					}*/
					break;
				case FeathersEventType.TRANSITION_COMPLETE:
					trace("> FeathersEventType.TRANSITION_COMPLETE");						
					
					if(_screenCurrent){
						// Stopping current view animations and removing controls listeners 
						_screenCurrent.destroy();												
					}
				
					// Assigining new page as a current view
					_screenCurrent = ViewAbstract(_navigator.activeScreen);
					_screenCurrent.activate();										
					// Trigger cleaning up old oview belongings
					_startGarbageCollectorCycle();										
																		
					break;
			}					
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
		/**
		 * GarbageCollector trigger
		 * http://www.craftymind.com/2008/04/09/kick-starting-the-garbage-collector-in-actionscript-3-with-air/
		 * 
		 */
		private function _startGarbageCollectorCycle():void{
			_garbageCollectorCallCount = 0;
			addEventListener(Event.ENTER_FRAME, _doGarbageCollect);
		}
		private function _doGarbageCollect(evt:Event):void{
			flash.system.System.gc();			
			if(++_garbageCollectorCallCount > 1){
				removeEventListener(Event.ENTER_FRAME, _doGarbageCollect);
				_garbageCollectorCallTimeout = setTimeout(_lastGC, 40);
			}
		}
		private function _lastGC():void{
			clearTimeout(_garbageCollectorCallTimeout);
			flash.system.System.gc();			
		}
				
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}