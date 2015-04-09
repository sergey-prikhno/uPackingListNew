package com.Application.robotlegs.views.components.renderers{
	import com.Application.robotlegs.model.vo.VOList;
	import com.Application.robotlegs.views.main.EventViewMain;
	import com.common.Constants;
	
	import flash.text.engine.ElementFormat;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	import feathers.display.Scale9Image;
	import feathers.skins.IStyleProvider;
	import feathers.textures.Scale9Textures;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	public class ItemrendererList extends FeathersControl implements IListItemRenderer{
		
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
		
		protected var touchPointID:int = -1;
		private var _isTouch:Boolean = false;
		private var _index:int = -1;
		protected var _owner:List;
		private var _isSelected:Boolean;
		private var _data:VOList;
		private var _scale:Number;
		
		private var _labelTitle:Label;
		private var _labelPersent:Label;
		private var _labelDate:Label;
		
		private var _imageBG:Scale9Image;
		private var _imageArrow:Image;
		
		private var _efTitleRendererList:ElementFormat;
		private var _efPersentRendererList:ElementFormat;
		private var _efDateRendererList:ElementFormat;
		
		private var _buttonRemove:Button;
		private var _buttonEdit:Button;
		
		private var _isSwipe:Boolean = false;
		private var _containerSwipe:Sprite;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ItemrendererList(){
			this.addEventListener(TouchEvent.TOUCH, _touchHandler);
			this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------

		override public function dispose():void{
			//_data = null;
			
			this.removeEventListener(TouchEvent.TOUCH, _touchHandler);
			this.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			if(_buttonRemove){
				_buttonRemove.nameList.remove(Constants.BUTTON_REMOVE_LIST_CKIN);
				_buttonRemove.removeEventListener(Event.TRIGGERED, _handlerButtonRemove);
				removeChild(_buttonRemove);
				_buttonRemove = null;
			}
			if(_buttonEdit){
				_buttonEdit.nameList.remove(Constants.BUTTON_EDIT_LIST_CKIN);
				_buttonEdit.removeEventListener(Event.TRIGGERED, _handlerButtonEdit);
				removeChild(_buttonEdit);
				_buttonEdit = null;
			}
			
			if(_labelDate){
				_containerSwipe.removeChild(_labelDate);
				_labelDate = null;
			}
			
			if(_labelTitle){
				_containerSwipe.removeChild(_labelTitle);
				_labelTitle = null;
			}
			if(_labelPersent){
				_containerSwipe.removeChild(_labelPersent);
				_labelPersent = null;
			}
			if(_imageBG){
				_containerSwipe.removeChild(_imageBG);
				_imageBG = null;
			}
			if(_imageArrow){
				removeChild(_imageArrow);
				_imageArrow = null;
			}
			if(_containerSwipe){
				if(_containerSwipe.hasEventListener(TouchEvent.TOUCH)){
					_containerSwipe.removeEventListener(TouchEvent.TOUCH, _handlerTouchContainer);
				}
				removeChild(_containerSwipe);
				_containerSwipe = null;
			}
			super.dispose();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function set efDateRendererList(value:ElementFormat):void{	_efDateRendererList = value;}
		public function set iconArrowRight(value:Texture):void{
			if(value){
				if(!_imageArrow){
					_imageArrow = new Image(value);
				}
			}
		}
		
		public function set efPersentRendererList(value:ElementFormat):void{_efPersentRendererList = value;}
		public function set efTitleRendererList(value:ElementFormat):void{_efTitleRendererList = value;}
		
		public function set backgroundRendererList(value:Scale9Textures):void{
			if(value){
				if(!_imageBG){
					_imageBG = new Scale9Image(value, _scale);
					_imageBG.smoothing = TextureSmoothing.BILINEAR;
				}
			}
		}
		
		override protected function get defaultStyleProvider():IStyleProvider {
			return ItemrendererList.globalStyleProvider;
		}
		
		public function set scale(value:Number):void{_scale = value;}
		public function get index():int	{return this._index;}
		public function set index(value:int):void{
			if(this._index == value){
				return;
			}
			this._index = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		public function get owner():List{return List(this._owner);}
		public function set owner(value:List):void{
			if(this._owner == value){
				return;
			}
			this._owner = value;
			if(this._owner){
				this._owner.addEventListener(EventRenderer.RENDERER_HIDE_BUTTONS, _handlerHideButton);
			}
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		
		public function get data():Object{return this._data;}
		public function set data(value:Object):void{			
			if(value){
				
				if(!value)	{
					return;
				}
				_data = VOList(value);			
				invalidate(INVALIDATION_FLAG_DATA);
			}
		}
		public function get isSelected():Boolean{return this._isSelected;}
		public function set isSelected(value:Boolean):void{
			if(this._isSelected == value){
				return;
			}
			this._isSelected = value;
			this.dispatchEventWith(Event.CHANGE);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		override protected function initialize():void{
			if(!_buttonRemove){
				_buttonRemove = new Button();
				_buttonRemove.nameList.add(Constants.BUTTON_REMOVE_LIST_CKIN);
				_buttonRemove.addEventListener(Event.TRIGGERED, _handlerButtonRemove);
				addChild(_buttonRemove);
			}
			if(!_buttonEdit){
				_buttonEdit = new Button();
				_buttonEdit.nameList.add(Constants.BUTTON_EDIT_LIST_CKIN);
				_buttonEdit.addEventListener(Event.TRIGGERED, _handlerButtonEdit);
				addChild(_buttonEdit);
			}
			if(!_containerSwipe){
				_containerSwipe = new Sprite();
				_containerSwipe.addEventListener(TouchEvent.TOUCH, _handlerTouchContainer);
				addChildAt(_containerSwipe, 2);
			}
			if(!_labelDate){
				_labelDate = new Label();
				_containerSwipe.addChild(_labelDate);
			}
			
			if(!_labelTitle){
				_labelTitle = new Label();
				_containerSwipe.addChild(_labelTitle);
			}
			if(!_labelPersent){
				_labelPersent = new Label();
				_containerSwipe.addChild(_labelPersent);
			}
			
			
		}
		
		override protected function draw():void{
			if(_data){
				if(_owner){
					width = _owner.width;
				}
				
				if(_imageBG){
					if(_containerSwipe && !_containerSwipe.contains(_imageBG)){
						_containerSwipe.addChildAt(_imageBG, 0);
					}
					_imageBG.width = actualWidth;
				}
				height = int(_imageBG.height);
				
				if(_imageArrow){
					if(_containerSwipe && !_containerSwipe.contains(_imageArrow)){
						_containerSwipe.addChild(_imageArrow);
					}
					_imageArrow.scaleX = _imageArrow.scaleY = _scale;
					_imageArrow.x = actualWidth - int(40*_scale) - _imageArrow.width;
					_imageArrow.y = actualHeight/2 - _imageArrow.height/2;
				}
				
				if(_labelDate){	
					_labelDate.text = _data.date_create;
					_labelDate.textRendererProperties.elementFormat = _efDateRendererList;
					_labelDate.x = int(40*_scale);
					_labelDate.y = actualHeight/4;
					_labelDate.validate();
				}
				if(_labelPersent){
					_labelPersent.text = "0 %";
					_labelPersent.textRendererProperties.elementFormat = _efPersentRendererList;
					_labelPersent.validate();
					_labelPersent.x = _imageArrow.x - int(40*_scale) - _labelPersent.width;
					_labelPersent.y = actualHeight/2 - _labelPersent.height/2;
				}
				if(_labelTitle){	
					_labelTitle.text = _data.title.toUpperCase();
					_labelTitle.width = _labelPersent.x - int(40*_scale); 
					_labelTitle.textRendererProperties.elementFormat = _efTitleRendererList;
					_labelTitle.x = int(40*_scale);
					_labelTitle.y = actualHeight/2;
					_labelTitle.validate();
				}
				if(_buttonEdit){
					_buttonEdit.width = int(actualWidth/2.5);
					_buttonEdit.height = actualHeight;
				}
				if(_buttonRemove){
					_buttonRemove.width = int(actualWidth/2.5);
					_buttonRemove.height = actualHeight;
					_buttonRemove.validate();
					_buttonRemove.x = actualWidth - _buttonRemove.width; 
				}
				
				if(_containerSwipe){
					if(!_data.isOpenEdit && !_data.isOpenRemove){
						_containerSwipe.x = 0;	
					}
					if(_data.isOpenEdit){
						_containerSwipe.x = _buttonEdit.width;
					}
					if(_data.isOpenRemove){
						_containerSwipe.x = _buttonRemove.x - _containerSwipe.width;
					}
				}
			
			}
		}
		
		private function _showEdit(value:Boolean):void{
			_isSwipe = true;
			_data.isOpenEdit = value;
			var pX:Number = 0;
			if(value){
				pX = _buttonEdit.width;
				_owner.dispatchEvent(new EventRenderer(EventRenderer.RENDERER_HIDE_BUTTONS, _index));
			}else{
				_data.isOpenRemove = false;
			}
			var tween:Tween = new Tween(_containerSwipe, Constants.TWEEN_SWIPE_SPEED, Transitions.EASE_IN);
			tween.moveTo(pX,0);
			tween.onComplete = _completeMove;
			Starling.juggler.add(tween);
		}
		
		private function _completeMove():void{
			if(_containerSwipe && !_containerSwipe.hasEventListener(TouchEvent.TOUCH)){
				_containerSwipe.addEventListener(TouchEvent.TOUCH, _handlerTouchContainer);
			}
			_isSwipe = false;
		}
		
		private function _showRemove(value:Boolean):void{
			_isSwipe = true;
			_data.isOpenRemove = value;
			var pX:Number = 0;
			if(value){
				pX = _buttonRemove.x - _containerSwipe.width;
				_owner.dispatchEvent(new EventRenderer(EventRenderer.RENDERER_HIDE_BUTTONS, _index));
			}else{
				_data.isOpenEdit = false;
			}
			var tween:Tween = new Tween(_containerSwipe, Constants.TWEEN_SWIPE_SPEED, Transitions.EASE_IN);
			tween.moveTo(pX,0);
			tween.onComplete = _completeMove;
			Starling.juggler.add(tween);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		private function _handlerHideButton(event:EventRenderer):void{
			if(_index == event.payload){
				return;
			}
			if(_data && _data.isOpenEdit || _data.isOpenRemove){
				if(_containerSwipe && _containerSwipe.x != 0){
					var tween:Tween = new Tween(_containerSwipe, Constants.TWEEN_SWIPE_SPEED, Transitions.EASE_IN);
					tween.moveTo(0,0);
					tween.onComplete = _completeMove;
					Starling.juggler.add(tween);
					_data.isOpenEdit = false;
					_data.isOpenRemove = false;
				}
			}
		}
		
		
		private function _handlerTouchContainer(event:TouchEvent):void{			
			
			var touch:Touch = event.getTouch(_containerSwipe);
			
			if(touch){
				if(touch.phase == TouchPhase.MOVED){
					var pDeltaX:Number = touch.globalX - touch.previousGlobalX;
					var pDeltaY:Number = touch.globalY - touch.previousGlobalY;
					var pCanSwipe:Boolean = true;
					
					if(pDeltaY > actualHeight || pDeltaY < ((-1)*actualHeight)){
						pCanSwipe = false;
					}
					
					if(pDeltaX > 20 && pCanSwipe){
						_containerSwipe.removeEventListener(TouchEvent.TOUCH, _handlerTouchContainer);
						_owner.stopScrolling();
						if(_data.isOpenRemove){
							_showEdit(false);
						}else{
							_showEdit(true);
						}
					}
					if(pDeltaX < -20 && pCanSwipe){
						_containerSwipe.removeEventListener(TouchEvent.TOUCH, _handlerTouchContainer);
						_owner.stopScrolling();
						if(_data.isOpenEdit){
							_showRemove(false);
						}else{
							_showRemove(true);
						}
					}
					
				}
			}
		}
		
	
		private function _handlerButtonRemove(event:Event):void{
			dispatchEvent(new EventViewMain(EventViewMain.SHOW_REMOVE_LIST_POPUP, true, _data));
		}
		
		private function _handlerButtonEdit(event:Event):void{

		}
		
		protected function removedFromStageHandler(event:starling.events.Event):void{
			this.touchPointID = -1;
		}
		
		protected function _touchHandler(event:TouchEvent):void{
			var touch:Touch = event.getTouch(stage);
			if(touch){
				if(touch.phase == TouchPhase.ENDED && !_owner.isScrolling) {
					if(!_data.isOpenEdit && !_data.isOpenRemove){
						dispatchEvent(new EventViewMain(EventViewMain.GET_SELECTED_LIST_DATA, true, _data));
					}
				}
			}
			
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