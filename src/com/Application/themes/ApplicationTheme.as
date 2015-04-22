package com.Application.themes {
	import com.Application.components.calendar.PopupCalendar;
	import com.Application.components.calendar.stepper.CalendarStepper;
	import com.Application.components.loadingIndicator.LoadingIndicator;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.Application.robotlegs.views.components.renderers.ItemRendererToPackList;
	import com.Application.robotlegs.views.components.renderers.ItemrendererList;
	import com.Application.robotlegs.views.components.searchInput.SearchInput;
	import com.Application.robotlegs.views.createList.ViewCreateList;
	import com.Application.robotlegs.views.list.ViewList;
	import com.Application.robotlegs.views.main.ViewMain;
	import com.Application.robotlegs.views.menu.ViewMenu;
	import com.Application.robotlegs.views.packedList.ViewPackedList;
	import com.Application.robotlegs.views.packedList.listPacked.ItemRendererPackedList;
	import com.Application.robotlegs.views.popups.PopupAbstract;
	import com.Application.robotlegs.views.popups.info.PopupInfo;
	import com.Application.robotlegs.views.popups.removeList.PopupRemoveList;
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

		protected var iconEdit:Texture;
		protected var iconUncheck:Texture;
		protected var iconCheck:Texture;
		protected var iconRemove:Texture;
		protected var iconSearch:Texture;
		protected var iconSearchGrey:Texture;
		
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
		protected var efPopupInfoTitle:ElementFormat;
		protected var efPopupInfoDesc:ElementFormat;
		protected var efPopupRemoveDesc:ElementFormat;
		protected var efTitleChildList:ElementFormat;
		protected var efCountChildList:ElementFormat;
				
		protected var backgroundDarkGrey:Scale9Textures;
		protected var backgroundRendererListWhite:Scale9Textures;
		protected var backgroundRendererListGrey:Scale9Textures;
		protected var backgroundWhite:Scale9Textures;
		protected var backgroundRendererListDel:Scale9Textures;
		protected var backgroundRendererListEdit:Scale9Textures;
		protected var buttonInfoPopup:Scale9Textures;
				
		
		public function ApplicationTheme(assetsBasePath:String = null, assetManager:AssetManager = null) {
			super(assetsBasePath, assetManager);
		}
		
		
		override protected function initializeTextures():void{
			super.initializeTextures();
			
			this.loadingIndicator = this.atlas.getTexture("loading-white-indicator");
			
			this.iconEdit = this.atlas.getTexture("edit-icon");
			this.iconUncheck = this.atlas.getTexture("icon-uncheked");
			this.iconCheck = this.atlas.getTexture("icon-check");
			this.iconRemove = this.atlas.getTexture("icon-remove");
			this.iconSearch = this.atlas.getTexture("icon-search");
			this.iconSearchGrey = this.atlas.getTexture("icon-search-grey");
		
			this.iconPlus = this.atlas.getTexture("icon-plus");
			this.iconMenu = this.atlas.getTexture("icon-menu");
			this.iconApply = this.atlas.getTexture("icon-apply");
			this.iconBack = this.atlas.getTexture("icon-back");
			this.iconSettings = this.atlas.getTexture("icon-settings");
			this.iconArrowRight = this.atlas.getTexture("icon-arrow-right");
			
			this.textureButtonCalendarUp = this.atlas.getTexture("button-calendar-up");
			this.textureButtonCalendarDown = this.atlas.getTexture("button-calendar-down");
			this.backgroundDarkGrey = new Scale9Textures(this.atlas.getTexture("backgroung-dark-grey"),new Rectangle(10,10,20,20));
			this.backgroundRendererListWhite = new Scale9Textures(this.atlas.getTexture("background-renderer-list"),new Rectangle(10,10,20,20));
			this.backgroundRendererListGrey = new Scale9Textures(this.atlas.getTexture("background-renderer-list-grey"),new Rectangle(10,10,20,20));
			this.backgroundWhite = new Scale9Textures(this.atlas.getTexture("backgroung-white"), DEFAULT_SCALE9_GRID);
			this.backgroundRendererListDel = new Scale9Textures(this.atlas.getTexture("background-remove-button"), DEFAULT_SCALE9_GRID);
			this.backgroundRendererListEdit = new Scale9Textures(this.atlas.getTexture("background-edit-button"), DEFAULT_SCALE9_GRID);
			this.buttonInfoPopup = new Scale9Textures(this.atlas.getTexture("skin-button-info-popup"), DEFAULT_SCALE9_GRID);
			
			
			
		}
		
		override protected function initializeStyleProviders():void {
			super.initializeStyleProviders();
	
			this.getStyleProviderForClass(LoadingIndicator).defaultStyleFunction = this.setLoadingIndicatorStyles;
			this.getStyleProviderForClass(ViewMain).defaultStyleFunction = this.setViewMainStyles;
			this.getStyleProviderForClass(ViewCreateList).defaultStyleFunction = this.setViewCreateListStyles;
			this.getStyleProviderForClass(ViewPackedList).defaultStyleFunction = this.setViewPackedListStyles;
			this.getStyleProviderForClass(ViewList).defaultStyleFunction = this.setViewListStyles;
			this.getStyleProviderForClass(ViewMenu).setFunctionForStyleName(Constants.LEFT_MENU_NAME_LIST, this.setViewMenuStyles);
			this.getStyleProviderForClass(CalendarStepper).defaultStyleFunction = this.setCalendarStepperStyles;
			this.getStyleProviderForClass(PopupCalendar).defaultStyleFunction = this.setPopupCalendarStyles;
			this.getStyleProviderForClass(ItemrendererList).defaultStyleFunction = this.setItemrendererOpenListStyles;
			this.getStyleProviderForClass(PopupAbstract).defaultStyleFunction = this.setPopupAbstractStyles;
			this.getStyleProviderForClass(PopupInfo).defaultStyleFunction = this.setPopupInfoStyles;
			this.getStyleProviderForClass(PopupRemoveList).defaultStyleFunction = this.setPopupRemoveListStyles;
			this.getStyleProviderForClass(ItemRendererPackedList).defaultStyleFunction = this.setItemRendererPackedStyles;
			this.getStyleProviderForClass(SearchInput).defaultStyleFunction = this.setSearchInputStyles;
			this.getStyleProviderForClass(ItemRendererToPackList).defaultStyleFunction = this.setItemRendererToPackListStyles;
			
			this.getStyleProviderForClass(Header).setFunctionForStyleName(Constants.CUSTOM_HEADER_NAME, this.setCustomHeaderStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Constants.BUTTON_ADD_LIST, this.setCustomButtonAddStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Constants.BUTTON_MENU, this.setCustomButtonMenuStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Constants.BUTTON_APPLY, this.setCustomButtonApplyStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Constants.BUTTON_CUSTOM_BACK, this.setCustomButtonBackStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Constants.BUTTON_STEPPER_UP, this.setButtonStepperUpStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Constants.BUTTON_STEPPER_DOWN, this.setButtonStepperDownStyles);
			this.getStyleProviderForClass(TextInput).setFunctionForStyleName(Constants.INPUT_TEXT_TITLE_CUSTOM, this.setCustomTextInputStyles);
			this.getStyleProviderForClass(TextInput).setFunctionForStyleName(Constants.INPUT_TEXT_SEARCH_CUSTOM, this.setCustomTextInputSearchStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Constants.BUTTON_REMOVE_LIST_CKIN, this.setButtonRemoveListStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Constants.BUTTON_EDIT_LIST_CKIN, this.setButtonEditListStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Constants.BUTTON_INFO_POPUP, this.setButtonInfoPopupStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Constants.SKIN_POPUP_WHITE_BUTTON, this.setButtonPopupWhiteStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Constants.BUTTON_CUSTOM_SEARCH, this.setButtonCustomSearchStyles);
			
		}	
	
		override protected function initializeFonts():void{
			super.initializeFonts();
			
			this.headerCustomElementFormat = new ElementFormat(this.regularFontDescription, this.extraLargeFontSize, WHITE_TEXT_COLOR);
			this.labelMenuElementFormat = new ElementFormat(this.regularFontDescription, int(42*scaleWidth), WHITE_TEXT_COLOR);
			this.efTitleRendererList = new ElementFormat(this.regularFontDescription, int(48*scaleHeight), 0x1c1c1c);
			this.efPersentRendererList = new ElementFormat(this.regularFontDescription, int(34*scaleHeight), 0x262626);
			this.efDateRendererList = new ElementFormat(this.regularFontDescription, int(24*scaleHeight), 0x929292);
			this.efTitleCreateList = new ElementFormat(this.boldFontDescription, int(30*scaleHeight), 0x333333);
			this.elementFormatLabelStepper = new ElementFormat(this.regularFontDescription, int(36*scaleHeight), 0x333333);
			this.efPopupInfoTitle = new ElementFormat(this.boldFontDescription, int(36*scaleHeight), WHITE_TEXT_COLOR);
			this.efPopupInfoDesc = new ElementFormat(this.regularFontDescription, int(28*scaleHeight), WHITE_TEXT_COLOR);
			this.efPopupRemoveDesc = new ElementFormat(this.regularFontDescription, int(28*scaleHeight), 0x333333);
			this.efTitleChildList = new ElementFormat(this.boldFontDescription, int(24*scaleHeight), 0x1c1c1c);
			this.efCountChildList = new ElementFormat(this.regularFontDescription, int(34*scaleHeight), 0x1c1c1c);
			
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// STYLES METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		protected function setSearchInputStyles(view:SearchInput):void{			
			view.scaleW = this.scaleWidth;
			view.scaleH = this.scaleHeight;
			view.backgroundGrey = backgroundRendererListGrey;
		}
		
		protected function setItemRendererPackedStyles(renderer:ItemRendererPackedList):void{			
			renderer.scaleWidth = scaleWidth;
			renderer.iconArrow = iconArrowRight;
			renderer.iconUncheck = iconUncheck;
			renderer.iconCheck = iconCheck;
			renderer.atlas = atlas;			
			renderer.efTitleRendererList = efTitleRendererList;
			renderer.efTitleChildList = efTitleChildList;
			renderer.efCountChildList = efCountChildList;
			renderer.backgroundRendererListWhite = backgroundRendererListWhite;
			renderer.backgroundRendererListGrey = backgroundRendererListGrey;
		}
		
		protected function setItemRendererToPackListStyles(renderer:ItemRendererToPackList):void{			
			renderer.scaleWidth = scaleWidth;
			renderer.iconArrow = iconArrowRight;
			renderer.iconUncheck = iconUncheck;
			renderer.iconCheck = iconCheck;
			renderer.atlas = atlas;			
			renderer.efTitleRendererList = efTitleRendererList;
			renderer.efTitleChildList = efTitleChildList;
			renderer.efCountChildList = efCountChildList;
			renderer.backgroundRendererListWhite = backgroundRendererListWhite;
			renderer.backgroundRendererListGrey = backgroundRendererListGrey;
		}
		
		protected function setPopupAbstractStyles(view:PopupAbstract):void{
			view.scaleHeight = scaleHeight;
			view.scaleWidth = scaleWidth;	
		}
		
		protected function setPopupInfoStyles(view:PopupInfo):void{
			setPopupAbstractStyles(view);
			view.efPopupInfoTitle = efPopupInfoTitle;
			view.efPopupInfoDesc = efPopupInfoDesc;
		}
		protected function setPopupRemoveListStyles(view:PopupRemoveList):void{
			setPopupAbstractStyles(view);
			view.efPopupRemoveDesc = efPopupRemoveDesc;
		}
		
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
		
		protected function setCustomTextInputSearchStyles(input:TextInput):void{
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
			input.defaultIcon = new Image(iconSearchGrey);
			input.defaultIcon.scaleX = input.defaultIcon.scaleY = scaleHeight; 
		}
		
		private function setItemrendererOpenListStyles(view:ItemrendererList):void{
			view.scale = this.scaleWidth;
			view.backgroundRendererList = backgroundRendererListWhite;
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
		
		protected function setButtonCustomSearchStyles(button:Button):void{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			var pSize:Number = int(88*this.scaleWidth);
			skinSelector.defaultValue = this.iconSearch;
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
		
		protected function setButtonInfoPopupStyles(button:Button):void{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonInfoPopup;
			skinSelector.setValueForState(this.buttonInfoPopup, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonInfoPopup, Button.STATE_DISABLED, false);
			
			skinSelector.displayObjectProperties =
				{
					width: this.controlSize,
						height: this.controlSize,
						textureScale: this.scale
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			button.defaultLabelProperties.elementFormat = new ElementFormat(this.boldFontDescription, int(24*scaleHeight), WHITE_TEXT_COLOR);
		}
		
		protected function setButtonPopupWhiteStyles(button:Button):void{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundWhite;
			skinSelector.setValueForState(this.backgroundWhite, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.backgroundWhite, Button.STATE_DISABLED, false);
			
			skinSelector.displayObjectProperties =
				{
					width: this.controlSize,
						height: this.controlSize,
						textureScale: this.scale
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			button.defaultLabelProperties.elementFormat = new ElementFormat(this.boldFontDescription, int(24*scaleHeight), 0x333333);
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
		
		protected function setViewPackedListStyles(view:ViewPackedList):void{
			initializeViewAbstract(view);
		}
		
		protected function setViewListStyles(view:ViewList):void{
			initializeViewAbstract(view);
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
