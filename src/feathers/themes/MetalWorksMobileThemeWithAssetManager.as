/*
 Copyright 2012-2015 Joshua Tynjala

 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 */
package feathers.themes
{
	import starling.core.Starling;
	import starling.events.Event;
	import starling.utils.AssetManager;
	import starling.utils.SystemUtil;

	/**
	 * Dispatched when the theme's assets are loaded, and the theme has
	 * initialized. Feathers component will not be skinned automatically by the
	 * theme until this event is dispatched.
	 *
	 * <p>The properties of the event object have the following values:</p>
	 * <table class="innertable">
	 * <tr><th>Property</th><th>Value</th></tr>
	 * <tr><td><code>bubbles</code></td><td>false</td></tr>
	 * <tr><td><code>currentTarget</code></td><td>The Object that defines the
	 *   event listener that handles the event. For example, if you use
	 *   <code>myButton.addEventListener()</code> to register an event listener,
	 *   myButton is the value of the <code>currentTarget</code>.</td></tr>
	 * <tr><td><code>data</code></td><td>null</td></tr>
	 * <tr><td><code>target</code></td><td>The Object that dispatched the event;
	 *   it is not always the Object listening for the event. Use the
	 *   <code>currentTarget</code> property to always access the Object
	 *   listening for the event.</td></tr>
	 * </table>
	 *
	 * @eventType starling.events.Event.COMPLETE
	 */
	[Event(name="complete",type="starling.events.Event")]

	/**
	 * The "Metal Works" theme for mobile Feathers apps.
	 *
	 * <p>This version of the theme requires loading assets at runtime. To use
	 * embedded assets, see <code>MetalWorksMobileTheme</code> instead.</p>
	 *
	 * <p>To use this theme, the following files must be included when packaging
	 * your app:</p>
	 * <ul>
	 *     <li>images/metalworks_mobile.png</li>
	 *     <li>images/metalworks_mobile.xml</li>
	 * </ul>
	 *
	 * @see http://feathersui.com/help/theme-assets.html
	 */
	public class MetalWorksMobileThemeWithAssetManager extends BaseMetalWorksMobileTheme
	{
		/**
		 * @private
		 * The name of the texture atlas in the asset manager.
		 */
		protected static const ATLAS_NAME:String = "atlas";

		/**
		 * Constructor.
		 * @param assetsBasePath The root folder of the assets.
		 * @param assetManager An optional pre-created AssetManager. The scaleFactor property must be equal to Starling.contentScaleFactor. To load assets with a different scale factor, use multiple AssetManager instances.
		 */
		public function MetalWorksMobileThemeWithAssetManager(assetsBasePath:String = null, assetManager:AssetManager = null)
		{
			super();
			this.loadAssets(assetsBasePath, assetManager);
		}

		/**
		 * @private
		 * The paths to each of the assets, relative to the base path.
		 */
		protected var assetPaths1x:Vector.<String> = new <String>
		[
			"1x/atlas.xml",
			"1x/atlas.png"
		];

		protected var assetPaths2x:Vector.<String> = new <String>
			[
				"2x/atlas.xml",
				"2x/atlas.png"
			];
			
		
		/**
		 * @private
		 */
		protected var assetManager:AssetManager;

		/**
		 * @private
		 */
		override public function dispose():void
		{
			super.dispose();
			if(this.assetManager)
			{
				this.assetManager.removeTextureAtlas(ATLAS_NAME);
				this.assetManager = null;
			}
		}

		/**
		 * @private
		 */
		override protected function initialize():void
		{
			this.initializeTextureAtlas();
			super.initialize();
		}

		/**
		 * @private
		 */
		protected function initializeTextureAtlas():void
		{
			this.atlas = this.assetManager.getTextureAtlas(ATLAS_NAME);
		}

		/**
		 * @private
		 */
		protected function assetManager_onProgress(progress:Number):void
		{
			if(progress < 1)
			{
				return;
			}
			this.initialize();
			this.dispatchEventWith(Event.COMPLETE);
		}

		/**
		 * @private
		 */
		protected function loadAssets(assetsBasePath:String, assetManager:AssetManager):void
		{
			var oldScaleFactor:Number = -1;
			if(assetManager)
			{
				oldScaleFactor = assetManager.scaleFactor;
				assetManager.scaleFactor = Starling.contentScaleFactor;
			}
			else
			{
				assetManager = new AssetManager(Starling.contentScaleFactor);
			}
			this.assetManager = assetManager;
			//add a trailing slash, if needed
			if(assetsBasePath.lastIndexOf("/") != assetsBasePath.length - 1)
			{
				assetsBasePath += "/";
			}
			
			
			var assetPaths:Vector.<String>;
			
			var iOS:Boolean = SystemUtil.platform == "IOS";
			
			if(iOS){
				
				if(scale >= 1){
					assetPaths = this.assetPaths2x;
				} else {
					assetPaths = this.assetPaths1x;	
				}
				
			} else {
				assetPaths = this.assetPaths1x;
			}
			
			
			var assetCount:int = assetPaths.length;
			for(var i:int = 0; i < assetCount; i++)
			{
				var asset:String = assetPaths[i];
				this.assetManager.enqueue(assetsBasePath + asset);
			}
			if(oldScaleFactor != -1)
			{
				//restore the old scale factor, just in case
				this.assetManager.scaleFactor = oldScaleFactor;
			}
			this.assetManager.loadQueue(assetManager_onProgress);
		}
	}
}
