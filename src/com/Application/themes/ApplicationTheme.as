package com.Application.themes {
	import com.Application.components.calendar.PopupCalendar;
	import com.Application.components.calendar.stepper.CalendarStepper;
	import com.Application.components.loadingIndicator.LoadingIndicator;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.Application.robotlegs.views.components.renderers.ItemrendererList;
	import com.Application.robotlegs.views.createList.ViewCreateList;
	import com.Application.robotlegs.views.main.ViewMain;
	import com.Application.robotlegs.views.menu.ViewMenu;
	import com.common.Constants;
	
	import flash.geom.Rectangle;
	import flash.text.engine.ElementFormat;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.TextInput;
	import feathers.skins.SmartDisplayObjectStateValueSelector;
	import feathers.textures.Scale9Textures;
	import feathers.themes.MetalWorksMobileThemeWithAssetManager;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class ApplicationTheme extends MetalWorksMobileThemeWithAssetManager {
		
		
		
		protected var loadingIndicator:Texture;

		protected var iconArrow:Texture;
		protected var iconEdit:Texture;
		protected var iconBag:Texture;
		protected var iconMark:Texture;
		protected var iconRemove:Texture;
		
		protected var iconPlus:Texture;
		protected var iconMenu:Texture;
		protected var iconApply:Texture;
		protected var iconBack:Texture;
		protected var iconSettings:Texture;
		protected var textureButtonCalendarUp:Texture;
		protected var textureButtonCalendarDown:Texture;
		protected var iconArrowRight:Texture;
		
		protected var headerCustomElementFormat:ElementFormat;
		protected var labelMenuElementFormat:ElementFormat;
		protected var efTitleRendererList:ElementFormat;
		protected var efPersentRendererList:ElementFormat;
		protected var efTitleCreateList:ElementFormat;
		protected var efDateRendererList:ElementFormat;
		protected var elementFormatLabelStepper:ElementFormat;
				
		protected var backgroundDarkGrey:Scale9Textures;
		protected var backgroundRendererList:Scale9Textures;
		protected var backgroundWhite:Scale9Textures;
		protected var backgroundRendererListDel:Scale9Textures;
		protected var backgroundRendererListEdit:Scale9Textures;
				
		
		public function ApplicationTheme(assetsBasePath:String = null, assetManager:AssetManager = null) {
			super(assetsBasePath, assetManager);
		}
		
		
		override protected function initializeTextures():void{
			super.initializeTextures();
			
			this.loadingIndicator = this.atlas.getTexture("loading-white-indicator");
			
			this.iconArrow = this.atlas.getTexture("arrow-right");
			this.iconEdit = this.atlas.getTexture("edit-icon");
			this.iconBag = this.atlas.getTexture("icon-bag");
			this.iconMark = this.atlas.getTexture("icon-mark");
			this.iconRemove = this.atlas.getTexture("icon-remove");
		
			this.iconPlus = this.atlas.getTexture("icon-plus");
			this.iconMenu = this.atlas.getTexture("icon-menu");
			this.iconApply = this.atlas.getTexture("icon-apply");
			this.iconBack = this.atlas.getTexture("icon-back");
			this.iconSettings = this.atlas.getTexture("icon-settings");
			this.iconArrowRight = this.atlas.getTexture("icon-arrow-right");
			
			this.textureButtonCalendarUp = this.atlas.getTexture("button-calendar-up");
			this.textureButtonCalendarDown = this.atlas.getTexture("button-calendar-down");
			this.backgroundDarkGrey = new Scale9Textures(this.atlas.getTexture("backgroung-dark-grey"),new Rectangle(10,10,20,20));
			this.backgroundRendererList = new Scale9Textures(this.atlas.getTexture("background-renderer-list"),new Rectangle(10,10,20,20));
			this.backgroundWhite = new Scale9Textures(this.atlas.getTexture("backgroung-white"), DEFAULT_SCALE9_GRID);
			this.backgroundRendererListDel = new Scale9Textures(this.atlas.getTexture("background-remove-button"), DEFAULT_SCALE9_GRID);
			this.backgroundRendererListEdit = new Scale9Textures(this.atlas.getTexture("background-edit-button"), DEFAULT_SCALE9_GRID);
			
			
		}
		
		override protected function initializeStyleProviders():void {
			super.initializeStyleProviders();
	
			this.getStyleProviderForClass(LoadingIndicator).defaultStyleFunction = this.setLoadingIndicatorStyles;
			this.getStyleProviderForClass(ViewMain).defaultStyleFunction = this.setViewMainStyles;
			this.getStyleProviderForClass(ViewCreateList).defaultStyleFunction = this.setViewCreateListStyles;
			this.getStyleProviderForClass(ViewMenu).setFunctionForStyleName(Constants.LEFT_MENU_NAME_LIST, this.setViewMenuStyles);
			this.getStyleProviderForClass(CalendarStepper).defaultStyleFunction = this.setCalendarStepperStyles;
			this.getStyleProviderForClass(PopupCalendar).defaultStyleFunction = this.setPopupCalendarStyles;
			this.getStyleProviderForClass(ItemrendererList).defaultStyleFunction = this.setItemrendererOpenListStyles;
			
			this.getStyleProviderForClass(Header).setFunctionForStyleName(Constants.CUSTOM_HEADER_NAME, this.setCustomHeaderStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Constants.BUTTON_ADD_LIST, this.setCustomButtonAddStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Constants.BUTTON_MENU, this.setCustomButtonMenuStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Constants.BUTTON_APPLY, this.setCustomButtonApplyStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Constants.BUTTON_CUSTOM_BACK, this.setCustomButtonBackStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Constants.BUTTON_STEPPER_UP, this.setButtonStepperUpStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Constants.BUTTON_STEPPER_DOWN, this.setButtonStepperDownStyles);
			this.getStyleProviderForClass(TextInput).setFunctionForStyleName(Constants.INPUT_TEXT_TITLE_CUSTOM, this.setCustomTextInputStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Constants.BUTTON_REMOVE_LIST_CKIN, this.setButtonRemoveListStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Constants.BUTTON_EDIT_LIST_CKIN, this.setButtonEditListStyles);
			
		}	
	
		override protected function initializeFonts():void{
			super.initializeFonts();
			
			this.headerCustomElementFormat = new ElementFormat(this.regularFontDescription, this.extraLargeFontSize, WHITE_TEXT_COLOR);
			this.labelMenuElementFormat = new ElementFormat(this.regularFontDescription, int(42*scaleWidth), WHITE_TEXT_COLOR);
			this.efTitleRendererList = new ElementFormat(this.regularFontDescription, int(56*scaleHeight), 0x1c1c1c);
			this.efPersentRendererList = new ElementFormat(this.regularFontDescription, int(40*scaleHeight), 0x262626);
			this.efDateRendererList = new ElementFormat(this.regularFontDescription, int(24*scaleHeight), 0x929292);
			this.efTitleCreateList = new ElementFormat(this.boldFontDescription, int(30*scaleHeight), 0x333333);
			this.elementFormatLabelStepper = new ElementFormat(this.regularFontDescription, int(36*scaleHeight), 0x333333);
			
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// STYLES METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		protected function setCustomTextInputStyles(input:TextInput):void{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundWhite;
			skinSelector.displayObjectProperties =
				{
					width: this.wideControlSize,
						height: this.controlSize,
						textureScale: this.scale
				};
			input.stateToSkinFunction = skinSelector.updateValue;
			
			input.minWidth = this.controlSize;
			input.minHeight = this.controlSize;
			input.minTouchWidth = this.gridSize;
			input.minTouchHeight = this.gridSize;
			input.gap = this.smallGutterSize;
			input.padding = this.smallGutterSize;
			
			input.textEditorProperties.fontFamily = "Helvetica";
			input.textEditorProperties.fontSize = int(32*scaleHeight);
			input.textEditorProperties.color = 0x333333;
			input.textEditorProperties.disabledColor = DISABLED_TEXT_COLOR;
			
			input.promptProperties.elementFormat = this.lightElementFormat;
			input.promptProperties.disabledElementFormat = this.disabledElementFormat;
		}
		
		private function setItemrendererOpenListStyles(view:ItemrendererList):void{
			view.scale = this.scaleWidth;
			view.backgroundRendererList = backgroundRendererList;
			view.efTitleRendererList = efTitleRendererList;
			view.efPersentRendererList = efPersentRendererList;
			view.efDateRendererList = efDateRendererList;
			view.iconArrowRight = iconArrowRight;
		}
		
		private function setCalendarStepperStyles(view:CalendarStepper):void{
			view.scale = this.scaleWidth;
			view.elementFormatLabelStepper = elementFormatLabelStepper;
		}
		
		private function setPopupCalendarStyles(view:PopupCalendar):void{
			view.scale = this.scaleWidth;
		}
		
		protected function setCustomButtonAddStyles(button:Button):void{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			var pSize:Number = int(88*this.scaleWidth);
			skinSelector.defaultValue = this.iconPlus;
			skinSelector.displayObjectProperties =
				{
					width: pSize,
					height: pSize
				};
			button.stateToSkinFunction = skinSelector.updateValue;
		}
		
		protected function setCustomButtonMenuStyles(button:Button):void{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			var pSize:Number = int(88*this.scaleWidth);
			skinSelector.defaultValue = this.iconMenu;
			skinSelector.displayObjectProperties =
				{
					width: pSize,
					height: pSize
				};
			button.stateToSkinFunction = skinSelector.updateValue;
		}
		
		protected function setCustomButtonApplyStyles(button:Button):void{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			var pSize:Number = int(88*this.scaleWidth);
			skinSelector.defaultValue = this.iconApply;
			skinSelector.displayObjectProperties =
				{
					width: pSize,
					height: pSize
				};
			button.stateToSkinFunction = skinSelector.updateValue;
		}
		
		protected function setCustomButtonBackStyles(button:Button):void{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			var pSize:Number = int(88*this.scaleWidth);
			skinSelector.defaultValue = this.iconBack;
			skinSelector.displayObjectProperties =
				{
					width: pSize,
					height: pSize
				};
			button.stateToSkinFunction = skinSelector.updateValue;
		}
		
		protected function setButtonStepperUpStyles(button:Button):void{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			var pSize:Number = int(88*this.scaleWidth);
			skinSelector.defaultValue = this.textureButtonCalendarUp;
			skinSelector.displayObjectProperties =
				{
					width: pSize,
					height: pSize
				};
			button.stateToSkinFunction = skinSelector.updateValue;
		}
		
		protected function setButtonStepperDownStyles(button:Button):void{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			var pSize:Number = int(88*this.scaleWidth);
			skinSelector.defaultValue = this.textureButtonCalendarDown;
			skinSelector.displayObjectProperties =
				{
					width: pSize,
					height: pSize
				};
			button.stateToSkinFunction = skinSelector.updateValue;
		}
		
		protected function setButtonRemoveListStyles(button:Button):void{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundRendererListDel;
			skinSelector.setValueForState(this.backgroundRendererListDel, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.backgroundRendererListDel, Button.STATE_DISABLED, false);
			
			skinSelector.displayObjectProperties =
				{
					width: this.controlSize,
						height: this.controlSize,
						textureScale: this.scale
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			button.defaultIcon = new Image(iconRemove);
			
		}
		protected function setButtonEditListStyles(button:Button):void{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundRendererListEdit;
			skinSelector.setValueForState(this.backgroundRendererListEdit, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.backgroundRendererListEdit, Button.STATE_DISABLED, false);
			
			skinSelector.displayObjectProperties =
				{
					width: this.controlSize,
						height: this.controlSize,
						textureScale: this.scale
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			button.defaultIcon = new Image(iconEdit);
		}
		
		protected function setCustomHeaderStyles(header:Header):void{
			header.minWidth = this.gridSize;
			header.minHeight = this.gridSize;
			header.padding = this.smallGutterSize;
			header.gap = this.smallGutterSize;
			header.titleGap = this.smallGutterSize;
			
			var backgroundSkin:Quad = new Quad(this.gridSize, this.gridSize, 0x3bafda);
			header.backgroundSkin = backgroundSkin;
			header.titleProperties.elementFormat = this.headerCustomElementFormat;
		}
		
		protected function setLoadingIndicatorStyles(component:LoadingIndicator):void{
			component.circle = loadingIndicator;
			component.scaleWidth = scaleWidth;
		}
		
		protected function setViewMainStyles(view:ViewMain):void{
			initializeViewAbstract(view);		
		}
		
		protected function setViewCreateListStyles(view:ViewCreateList):void{
			initializeViewAbstract(view);
			view.efTitleCreateList = efTitleCreateList;
		}
		
		protected function setViewMenuStyles(view:ViewMenu):void{
			initializeViewAbstract(view);
			view.textureSettings = iconSettings;
			view.labelMenuElementFormat = labelMenuElementFormat;
			view.backgroundDarkGrey = this.backgroundDarkGrey;
		}
		
		protected function initializeViewAbstract(view:ViewAbstract):void{
			view.scaleHeight = scaleHeight;
			view.scaleWidth = scaleWidth;	
		}
		
	}
}
