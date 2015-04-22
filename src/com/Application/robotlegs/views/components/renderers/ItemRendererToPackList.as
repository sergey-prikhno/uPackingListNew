package com.Application.robotlegs.views.components.renderers{	
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.list.EventViewList;
	
	import flash.geom.Point;
	import flash.text.engine.ElementFormat;
	
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.IFocusDisplayObject;
	import feathers.display.Scale9Image;
	import feathers.skins.IStyleProvider;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;
	import starling.utils.deg2rad;
	
	public class ItemRendererToPackList extends FeathersControl implements IListItemRenderer, IFocusDisplayObject {						
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
		protected var _data:VOPackedItem;
		protected var _owner:List;
		protected var _index:int = -1;
		protected var _backIndex:int = -1;
		protected var _isSelected:Boolean = false;	
		
		
		protected var touchPointID:int = -1;
		
		private static const HELPER_POINT:Point = new Point();
		
		private var _containerMain:Sprite;
		
				
		private var _iconArrowTexture:Texture;
		private var _iconUncheckTexture:Texture;
		private var _iconCheckTexture:Texture;
		
		private var _iconArrow:Image;
		private var _iconUncheck:Image;
		private var _iconCheck:Image;
		private var _mainIcon:Image;
		
		
		private var _imageBGWhite:Scale9Image;
		private var _imageBGGrey:Scale9Image;
		
		private var _label:Label;
		private var _scaleWidth:Number;
		private var _labelCount:Label;
		
		private var _efTitleRendererList:ElementFormat;
		private var _efTitleChildList:ElementFormat;
		private var _efCountChildList:ElementFormat;
		
		private var _atlas:TextureAtlas;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ItemRendererToPackList() {
			super();			
			this.isFocusEnabled = true;
			this.isQuickHitAreaEnabled = false;
			this.addEventListener(TouchEvent.TOUCH, button_touchHandler);	
			this.addEventListener(Event.REMOVED_FROM_STAGE, button_removedFromStageHandler);
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		override public function dispose():void	{
			if(_owner){
				this._owner.removeEventListener(EventViewList.UPDATE_PACKED_ITEM, _handlerUpdatePacked);
			}
			this._owner = null;
			if(_imageBGGrey){
				_containerMain.removeChild(_imageBGGrey);
				_imageBGGrey = null;
			}
			if(_imageBGWhite){
				_containerMain.removeChild(_imageBGWhite);
				_imageBGWhite = null;
			}								
			if(_iconArrow){
				_containerMain.removeChild(_iconArrow);
				_iconArrow = null;
			}
			if(_iconUncheck){
				_containerMain.removeChild(_iconUncheck);
				_iconUncheck = null;
			}
			if(_iconCheck){
				_containerMain.removeChild(_iconCheck);
				_iconCheck = null;
			}
			if(_label){
				_containerMain.removeChild(_label);
				_label = null;
			}
			if(_labelCount){
				_containerMain.removeChild(_labelCount);
				_labelCount = null;
			}
			if(_mainIcon){				
				_containerMain.removeChild(_mainIcon);
				_mainIcon = null;
			}		
			if(_containerMain){
				removeChild(_containerMain);
				_containerMain = null;
			}			
			_iconUncheckTexture = null;
			_iconCheckTexture = null;
			_iconArrowTexture = null;
			
			super.dispose();
		}		
		
		override public function invalidate(flag:String = INVALIDATION_FLAG_ALL):void{
			super.invalidate(flag);			
			if(flag == INVALIDATION_FLAG_DATA){
				if(_data){
					if(!_containerMain){
						_createImage();
					} else {
						_refreshImage();
					}
				}				
			}				
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------

		override protected function get defaultStyleProvider():IStyleProvider {	return ItemRendererToPackList.globalStyleProvider;}
		public function set efCountChildList(value:ElementFormat):void{_efCountChildList = value;}
		public function set backgroundRendererListGrey(value:Scale9Textures):void{
			if(value){
				if(!_imageBGGrey){
					_imageBGGrey = new Scale9Image(value, _scaleWidth);
					_imageBGGrey.smoothing = TextureSmoothing.BILINEAR;
				}
			}
		}
		public function set backgroundRendererListWhite(value:Scale9Textures):void{
			if(value){
				if(!_imageBGWhite){
					_imageBGWhite = new Scale9Image(value, _scaleWidth);
					_imageBGWhite.smoothing = TextureSmoothing.BILINEAR;
				}
			}
		}
		public function set efTitleChildList(value:ElementFormat):void{	_efTitleChildList = value;}
		public function set efTitleRendererList(value:ElementFormat):void{_efTitleRendererList = value;}
		public function set scaleWidth(value:Number):void{	_scaleWidth = value;}
		public function set iconArrow(value:Texture):void{_iconArrowTexture = value;}
		public function set iconUncheck(value:Texture):void{_iconUncheckTexture = value;}
		public function set iconCheck(value:Texture):void{_iconCheckTexture = value;}
		public function set atlas(value:TextureAtlas):void{	_atlas = value;}

		public function get data():Object {	return this._data;}
		public function set data(value:Object):void	{		
			if(!value)	{
				return;
			}
			_data = VOPackedItem(value);			
			invalidate(INVALIDATION_FLAG_DATA);
		}
		public function get index():int {return this._index;}
		public function set index(value:int):void {	this._index = value;}
		public function get backIndex():int{ return _backIndex;}
		public function set backIndex(value:int):void{_backIndex = value;}
		public function get owner():List {	return List(this._owner);}
		public function set owner(value:List):void {
			if(_owner == value)	{
				return;
			}
			_owner = List(value);	
			if(_owner){
				_owner.addEventListener(EventViewList.UPDATE_PACKED_ITEM, _handlerUpdatePacked);
			}
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		public function get isSelected():Boolean {return this._isSelected;}
		public function set isSelected(value:Boolean):void {
			if(this._isSelected == value) {
				return;
			}
			this._isSelected = value;
			this.invalidate(INVALIDATION_FLAG_SELECTED);
			this.dispatchEventWith(Event.CHANGE);
		}		
		
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		override protected function draw():void {					
			
			if(_owner){
				width = _owner.width;
			}
			
			if(_imageBGWhite){
				_imageBGWhite.width = width;
				height = _imageBGWhite.height;					
			}
			
			if(_imageBGGrey){
				_imageBGGrey.width = width;
				height = _imageBGGrey.height;
			}
			
			if(_mainIcon){
				_mainIcon.scaleX = _mainIcon.scaleY = _scaleWidth;	
				
				if(_data.isChild){
					_mainIcon.visible = false;
				} else {
					_mainIcon.visible = true;
					_mainIcon.x = int(40*_scaleWidth);
				}
				
				_mainIcon.y = int(height/2 - _mainIcon.height/2);
				
			}
			
			if(_iconArrow){
				_iconArrow.scaleX = _iconArrow.scaleY = _scaleWidth;								
				_iconArrow.y = int(height/2);			
				_iconArrow.x = int(width - _iconArrow.width/2 - 40*_scaleWidth);
			}			
			
			
			if(_labelCount){				
				_labelCount.textRendererProperties.elementFormat = _efCountChildList;
				_labelCount.validate();
				_labelCount.x = _iconArrow.x - int(20*_scaleWidth) - _labelCount.width;		
				_labelCount.y = int(height/2 - _labelCount.height/2);			
			}
			
			
			if(_label && _data){
				if(_data.isChild) {					
					_label.textRendererProperties.elementFormat = _efTitleChildList;
					_label.validate();
					_label.x = int(40*_scaleWidth);					
				} else {
					_label.textRendererProperties.elementFormat = _efTitleRendererList;
					_label.width = _labelCount.x - int(_mainIcon.x + _mainIcon.width * 1.2);
					_label.validate();
					_label.x = int(_mainIcon.x + _mainIcon.width * 1.2);					
				}																	
				_label.y = int(height/2 - _label.height/2);					
			}
			
			if(_iconUncheck){
				_iconUncheck.scaleX = _iconUncheck.scaleY = _scaleWidth;
				_iconUncheck.x = int(width - _iconUncheck.width/2 - 40*_scaleWidth);
				_iconUncheck.y = int(height/2);
			}
			
			if(_iconCheck){
				_iconCheck.scaleX = _iconCheck.scaleY = _scaleWidth;
				_iconCheck.x = int(width - _iconCheck.width/2 - 40*_scaleWidth);
				_iconCheck.y = int(height/2);
			}
			
														
		}
		
		override protected function initialize():void{			
			_createImage();					
		}
		
		
		private function _createImage():void{
			if(_data){
				
				if(!_containerMain){
																
					_containerMain = new Sprite();										
					addChild(_containerMain);	
					
					_containerMain.addChild(_imageBGGrey);								
					_containerMain.addChild(_imageBGWhite);
					
					_iconArrow = new Image(_iconArrowTexture);
					_iconArrow.smoothing = TextureSmoothing.TRILINEAR;
					_iconArrow.pivotX = _iconArrow.pivotY = _iconArrow.width/2; 
					_containerMain.addChild(_iconArrow);
					
					_iconUncheck = new Image(_iconUncheckTexture);
					_iconUncheck.smoothing = TextureSmoothing.TRILINEAR;
					_iconUncheck.pivotX = _iconUncheck.pivotY = _iconUncheck.width/2; 
					_containerMain.addChild(_iconUncheck);										
					
					
					_iconCheck = new Image(_iconCheckTexture);
					_iconCheck.smoothing = TextureSmoothing.TRILINEAR;
					_iconCheck.pivotX = _iconCheck.pivotY = _iconCheck.width/2; 
					_containerMain.addChild(_iconCheck);
									
					_label = new Label();
					_containerMain.addChild(_label);					
					
					_labelCount = new Label();
					_containerMain.addChild(_labelCount);
					
					_refreshImage();
																						
				}
			}
		}

		
		private function _refreshImage():void{
			if(_data && _containerMain){	
				if(_data.isChild){
					_imageBGGrey.visible = true;
					_iconUncheck.visible = true;
					
					if(_data.toPack == "1"){
						_iconCheck.visible = true;
					} else {
						_iconCheck.visible = false;
					}
					
					
					_imageBGWhite.visible = false;					
					_iconArrow.visible = false;
					_labelCount.visible = false;
					
				} else {
					_imageBGGrey.visible = false;
					_iconCheck.visible = false;
					_iconUncheck.visible = false;
					_imageBGWhite.visible = true;
					_iconArrow.visible = true;
					_labelCount.visible = true;
				}
				
																	
				if(!_mainIcon){
					_mainIcon = new Image(_atlas.getTexture("icon_"+_data.icon_id));
					_containerMain.addChild(_mainIcon);
				} else {
					_mainIcon.texture = _atlas.getTexture("icon_"+_data.icon_id);
				}														
				
				
				_label.text = _data.label.toUpperCase();
				_label.validate();
				
				
				if(_data.childrens){
					_labelCount.text = _getCountChild();	
				} else {
					_labelCount.text = "0 / 0";
				}				
				
				_labelCount.validate();
			}			
		}
		
		
		protected function resetTouchState(touch:Touch = null):void {
			this.touchPointID = -1;
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------			
		
		protected function button_touchHandler(event:TouchEvent):void{
			
			
			var touch:Touch = event.getTouch(this, null, this.touchPointID);
			if(!touch){
				//this should never happen
				return;
			}
			
			touch.getLocation(this.stage, HELPER_POINT);
			
			const isInBounds:Boolean = this.contains(this.stage.hitTest(HELPER_POINT, true));
			
			if(touch.phase == TouchPhase.ENDED){
				this.resetTouchState(touch);
				//we we dispatched a long press, then triggered and change
				//won't be able to happen until the next touch begins
				if(isInBounds) {
					//this.dispatchEventWith(Event.TRIGGERED,true,_data);													
					
					if(_data.isChild){
						//_data.isPacked = !_data.isPacked;
						if(_data.toPack == "0"){
							_data.toPack = "1";
						}else{
							_data.toPack = "0";
						}
						
						if(_data.isChild){								
							if(_data.toPack == "1"){
								_iconCheck.visible = true;
							} else {
								_iconCheck.visible = false;
							}
						}
							
						dispatchEvent(new EventViewAbstract(EventViewAbstract.UPDATE_DB_PACKED_ITEM, true, _data));
						
					} else if(_data.childrens && _data.childrens.length > 0){
						_data.index = _index;
						this.dispatchEventWith(EventViewList.CLICK_ITEM,true,_data);
						if(!_data.isOpen){					
							_data.isOpen = true;								
							_iconArrow.rotation = deg2rad(90);	
						} else {					
							_data.isOpen = false;								
							_iconArrow.rotation = deg2rad(0);
						}	
					}
					isSelected = true;
				}
			}
			
		} 
		
		
		
		protected function button_removedFromStageHandler(event:Event):void	{
			this.resetTouchState();
		}
		
		private function _handlerUpdatePacked(event:EventViewList):void{
			
			var pData:VOPackedItem = VOPackedItem(event.data);
			
			if(pData.parentId == _data.id){
				if(_data.childrens){
					_labelCount.text = _getCountChild();	
				} else {
					_labelCount.text = "0 / 0";
				}	
			}			
		}
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//--------------------------------------------------------------------------------------------------------- 										
		
		private function _getCountChild():String{
			var pCount:String = "";
			var pChildLength:int = 0;
			var pChildPack:int = 0;
			
			var pLength:int = _data.childrens.length;
			for (var i:int = 0; i < pLength; i++){
				if(_data.childrens[i].isPacked){
					pChildLength++;
				}
				if(_data.childrens[i].toPack == "1"){
					pChildPack++;
				}
			}
			
			
			pCount = pChildPack+" / "+pChildLength;
			
			return pCount;
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}


