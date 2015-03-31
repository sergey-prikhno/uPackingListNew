package com.Application.themes {
	import com.Application.components.loadingIndicator.LoadingIndicator;
	import com.Application.robotlegs.views.ViewAbstract;
	
	import flash.geom.Rectangle;
	
	import feathers.textures.Scale9Textures;
	import feathers.themes.MetalWorksMobileThemeWithAssetManager;
	
	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class ApplicationTheme extends MetalWorksMobileThemeWithAssetManager {
		
		
		
		protected var loadingIndicator:Texture;
		protected var baseViewBackground:Scale9Textures;
		protected var background1:Scale9Textures;
		protected var background2:Scale9Textures;
		protected var iconArrow:Texture;
		protected var iconEdit:Texture;
		protected var iconBag:Texture;
		protected var iconMark:Texture;
		protected var iconRemove:Texture;
				
		
		public function ApplicationTheme(assetsBasePath:String = null, assetManager:AssetManager = null) {
			super(assetsBasePath, assetManager);
		}
		
		
		override protected function initializeTextures():void{
			super.initializeTextures();
			
			this.loadingIndicator = this.atlas.getTexture("loading-white-indicator");
			this.baseViewBackground = new Scale9Textures(this.atlas.getTexture("background-base"),new Rectangle(10,10,20,20));			
			
			this.background1 = new Scale9Textures(this.atlas.getTexture("background1"),new Rectangle(10,10,20,20));	
			this.background2 = new Scale9Textures(this.atlas.getTexture("background2"),new Rectangle(10,10,20,20));	
			
			this.iconArrow = this.atlas.getTexture("arrow-right");
			this.iconEdit = this.atlas.getTexture("edit-icon");
			this.iconBag = this.atlas.getTexture("icon-bag");
			this.iconMark = this.atlas.getTexture("icon-mark");
			this.iconRemove = this.atlas.getTexture("icon-remove");
		}
		
		override protected function initializeStyleProviders():void {
			super.initializeStyleProviders();
	
			this.getStyleProviderForClass(LoadingIndicator).defaultStyleFunction = this.setLoadingIndicatorStyles;
			
		}	
	
		protected function setLoadingIndicatorStyles(component:LoadingIndicator):void{
			component.circle = loadingIndicator;
			component.scaleWidth = scaleWidth;
		}
		
		
		protected function initializeViewAbstract(view:ViewAbstract):void{
			view.scaleHeight = scaleHeight;
			view.scaleWidth = scaleWidth;	
			view.baseBackground = baseViewBackground;
		}
		
	}
}
