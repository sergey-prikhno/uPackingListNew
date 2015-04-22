package com.Application.robotlegs.views.list {
	import com.Application.robotlegs.model.vo.VOList;
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.Application.robotlegs.views.components.renderers.ItemRendererToPackList;
	import com.Application.robotlegs.views.components.searchInput.EventSearchInput;
	import com.Application.robotlegs.views.components.searchInput.SearchInput;
	import com.common.Constants;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	import feathers.skins.IStyleProvider;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	
	public class ViewList extends ViewAbstract {									
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------		
		
		private var _verticalLayout:VerticalLayout;
		
		public static var globalStyleProvider:IStyleProvider;
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		
		private var _list:List;
		private var _items:Vector.<VOPackedItem>;
		
		private var _voList:VOList;
		
		private var _buttonBack:Button;	
		private var _buttonSearch:Button;	
		
		private var _search:SearchInput;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ViewList() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		override public function destroy():void{
			super.destroy();
			
			if(_search){
				_search.destroy();
				removeChild(_search);
				_search = null;
			}
		}
		
		public function update(pData:VOPackedItem):void{
			if(_list){
				_list.dispatchEvent(new EventViewList(EventViewList.UPDATE_PACKED_ITEM, false, pData));
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		override protected function get defaultStyleProvider():IStyleProvider {
			return ViewList.globalStyleProvider;
		}
		
		public function set tableName(value:VOList):void{
			_voList = value;
			
			if(this._header){
				this._header.title = _voList.title;
			}
		}
		
		public function set items(value:Vector.<VOPackedItem>):void{
			
			if(value){
				if(!_items){
					_items = new Vector.<VOPackedItem>;
				}else{
					_items = null;
				}
				var pLengthList:int = value.length;
				for (var i:int = 0; i < pLengthList; i++){
					var pCategory:VOPackedItem = VOPackedItem(value[i]);
					var pIsPack:Boolean = false;
					for (var j:int = 0; j < pCategory.childrens.length; j++){
						if(pCategory.childrens[j].isPacked){
							pIsPack = true;
							break;
						}
					}
					
					if(pIsPack){
						_items.push(pCategory);
					}
					
				}
				if(_list && _items && _items.length > 0){
					_list.dataProvider = new ListCollection(_items);
				}
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		override protected function _initialize():void{
			super._initialize();
			
			if(!_verticalLayout){
				_verticalLayout = new VerticalLayout();
				_verticalLayout.useVirtualLayout = true;
			}
						
			_search = new SearchInput();	
			_search.addEventListener(EventSearchInput.CHANGE, _handlerChange);
			addChildAt(_search, 0);
			
			
			_list = new List();			
			_list.layout = _verticalLayout;	
			_list.width = _nativeStage.stageWidth;
			_list.hasElasticEdges = false;
			_list.itemRendererFactory = function():IListItemRenderer{
				var renderer:ItemRendererToPackList = new ItemRendererToPackList();
				
				return renderer;
			};
			
			addChild(_list);	
			
			if(_items && _items.length > 0){
				_list.dataProvider = new ListCollection(_items);
			}
			
			_list.addEventListener(EventViewList.CLICK_ITEM, _handlerItemClick);
			
			_buttonBack = new Button();
			_buttonBack.addEventListener(Event.TRIGGERED, _handlerButtonBack);
			_buttonBack.nameList.add(Constants.BUTTON_CUSTOM_BACK);
			this._header.leftItems = new <DisplayObject>[this._buttonBack];
			
			_buttonSearch = new Button();
			_buttonSearch.addEventListener(Event.TRIGGERED, _handlerButtonSearch);
			_buttonSearch.nameList.add(Constants.BUTTON_CUSTOM_SEARCH);
			this._header.rightItems = new <DisplayObject>[this._buttonSearch];
			
			
		}
		
		override protected function draw():void{
			super.draw();
			
			if(_search){
				_search.width = int(_nativeStage.fullScreenWidth);
				_search.validate();
			}
			
			if(_list){
				_list.layout = _verticalLayout;	
				_list.width = _nativeStage.stageWidth;
				_list.validate();
				_list.x = _nativeStage.stageWidth/2 - _list.width/2;
				
				if(_search){
					if(_search.y > 0){
						_list.height = int(_nativeStage.fullScreenHeight- _search.y - _search.height);
						_list.validate();
						_list.y = _search.y + _search.height;
					} else {
						_list.height = _nativeStage.stageHeight - _header.height;
						_list.validate();
						_list.y = _header.height;
					}
				}
			}
			
		}
		
		private function _backToList():void{
			if(_list && _items && _items.length > 0){
				
				for(var i2:int=0;i2<_items.length;i2++){				
					var pParentItem:VOPackedItem = VOPackedItem(_items[i2]);					
					pParentItem.isOpen = false;		
					
					if(pParentItem.isChild){
						_items.splice(i2,1);
						i2--;
					}												
				}
				
				_list.dataProvider = new ListCollection(_items);
				_list.validate();															
			}
			if(_search){
				_search.reset();
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------				
		private function _handlerButtonBack(event:Event):void{
			dispatchEvent(new EventViewList(EventViewList.BACK_TO_MAIN_SCREEN));							
		}
	
		private function _handlerButtonSearch(event:Event):void{
			var pTween:Tween = new Tween(_search,.2,Transitions.EASE_OUT);
			var pTween2:Tween = new Tween(_list,.2,Transitions.EASE_OUT);
			
			if(_search.y == 0){
				pTween.moveTo(_search.x,_header.height);
				pTween.onComplete = onComplete;
				Starling.juggler.add(pTween);
		
				pTween2.moveTo(0,_search.height+_header.height);
				pTween2.onComplete = onComplete;
				Starling.juggler.add(pTween2);
			}else{
				pTween.moveTo(0,0);
				pTween.onComplete = onComplete;
				Starling.juggler.add(pTween);
				
				pTween2.moveTo(0,_header.height);
				pTween2.onComplete = onComplete;
				Starling.juggler.add(pTween2);
				_backToList();
			}
		}
		
		private function onComplete():void{
			
			if(_search.y > 0){
				_list.height = int(_nativeStage.fullScreenHeight- _search.y - _search.height);
				_list.validate();
				_list.y = _search.y + _search.height;
			} else {
				_list.height = _nativeStage.stageHeight - _header.height;
				_list.validate();
				_list.y = _header.height;
			}
			
			Starling.juggler.removeTweens(_search);
			Starling.juggler.removeTweens(_list);
		}
		
		private function _handlerItemClick(event:Event):void{
			event.stopPropagation();
			
			
			var pData:VOPackedItem = VOPackedItem(event.data);
			
			if(pData.childrens && pData.childrens.length > 0){
				
				var pLenght:Number = pData.childrens.length-1;
				
				if(!pData.isOpen){																		
					for(var i:int=pLenght; i>= 0 ;i--){
						if(pData.childrens[i].isPacked){
							_list.dataProvider.addItemAt(pData.childrens[i],pData.index+1);
						}
					}					
				} else {										
					var pListLength:Number = _list.dataProvider.length-1;					
					for(var j:int=pLenght; j>= 0 ;j--){	
						if(pData.childrens[j].isPacked){
							_list.dataProvider.removeItem(pData.childrens[j]);
						}
					}				
				}				
			}						
		}
		
		
		private function _handlerChange(event:EventSearchInput):void{
			if(_search.text.length > 0){
				var pFilteredVector:Vector.<VOPackedItem> = new Vector.<VOPackedItem>();
				for(var i:int=0;i<_items.length;i++){
					var pItem:VOPackedItem = VOPackedItem(_items[i]);
					
					if(!pItem.isChild){				
						var pFilTemp:Vector.<VOPackedItem> = Vector.<VOPackedItem>(pItem.childrens).filter(_searchFilter);					
						pFilteredVector = pFilteredVector.concat(pFilTemp);					
					}			
				}
				
				_list.dataProvider = new ListCollection(pFilteredVector);
			}else{
				_backToList();
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
		
		/**
		 * 
		 * Search Filter
		 * 
		 */
		private function _searchFilter(item:VOPackedItem, index:int, vector:Vector.<VOPackedItem>):Boolean {
			var pIsIsset:Boolean = false;
			// your code here
			
			var pLabel:String = item.label.toLowerCase();
			var pSearch:String = _search.text.toLowerCase();
			
			if(pLabel.indexOf(pSearch) >= 0 && item.isPacked){
				pIsIsset = true;
			}
			
			return pIsIsset;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}