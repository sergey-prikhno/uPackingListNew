package com.Application.robotlegs.views.packedList {
	import com.Application.robotlegs.model.vo.VOList;
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.Application.robotlegs.views.components.searchInput.EventSearchInput;
	import com.Application.robotlegs.views.components.searchInput.SearchInput;
	import com.Application.robotlegs.views.packedList.listPacked.CustomLayout;
	import com.Application.robotlegs.views.packedList.listPacked.ItemRendererPackedList;
	import com.common.Constants;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.skins.IStyleProvider;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class ViewPackedList extends ViewAbstract {				
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
		private var _list:List;
		private var _verticalLayout:CustomLayout;
		
		private var _buttonBack:Button;
		private var _buttonApply:Button;
		
		private var _items:Vector.<VOPackedItem>;
		
		private var _voList:VOList;
		
		private var _search:SearchInput;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ViewPackedList() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function destroy():void{
			
			if(_list){			
				_list.dataProvider= null;
				removeChild(_list,true);
				_list = null;
			}
			
			if(_buttonApply){
				_buttonApply.nameList.remove(Constants.BUTTON_APPLY);
				_buttonApply.removeEventListener(Event.TRIGGERED, _handlerButtonApply);
				removeChild(_buttonApply);
				_buttonApply = null;
			}			
			
			if(_buttonBack){
				_buttonBack.nameList.remove(Constants.BUTTON_CUSTOM_BACK);
				_buttonBack.removeEventListener(Event.TRIGGERED, _handlerBackbutton);
				removeChild(_buttonBack);
				_buttonBack = null;
			}
			
			_verticalLayout = null;
			
			if(_search){
				_search.destroy();
				removeChild(_search);
				_search = null;
			}
			
			
			super.destroy();			
		}
		
		public function update(pData:VOPackedItem):void{
			if(_list){
				_list.dispatchEvent(new EventViewPackedList(EventViewPackedList.UPDATE_PACKED_ITEM, false, pData));
			}
		}
		
		public function removed(pData:VOPackedItem):void{
			if(_list){		
				
				if(!pData.isChild && pData.isOpen && pData.childrens && pData.childrens.length > 0){
					
					var pLengthChildren:int = pData.childrens.length;
					
					for(var i:int=0; i < pLengthChildren;i++){						
						_list.dataProvider.removeItem(pData.childrens[i]);						
					}					
				}
				
				
				if(pData.isChild){
					
					var pLengthParent:int = _list.dataProvider.length;
					
					for(var j:int=0; j < pLengthParent;j++){	
						var pGetParentItem:VOPackedItem = VOPackedItem(_list.dataProvider.data[j]);
						
						if(pGetParentItem.id == pData.parentId){
							var pParentLen:int = pGetParentItem.childrens.length;
							
							for(var k:int=0;k<pParentLen; k++){
								var pFindChild:VOPackedItem = VOPackedItem(pGetParentItem.childrens[k]);
								
								if(pData.id == pFindChild.id){									
									pGetParentItem.childrens.splice(k,1);
									_list.dispatchEvent(new EventViewPackedList(EventViewPackedList.UPDATE_PACKED_ITEM, false, pData));	
									break;
								}
								
							}							
							
							break;
						}											
					}
					
				}
				
				_list.dataProvider.removeItem(pData);
				
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function set items(value:Vector.<VOPackedItem>):void{
			_items = value;
			
			if(_list && _items && _items.length > 0){
				_list.dataProvider = new ListCollection(_items);
			}
		}
		
		
		public function set tableName(value:VOList):void{
			_voList = value;
			
			/*if(this._header){
				this._header.title = _voList.title;
			}*/
		}
		override protected function get defaultStyleProvider():IStyleProvider {
			return ViewPackedList.globalStyleProvider;
		}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		override protected function _initialize():void{			
			super._initialize();

			_search = new SearchInput();	
			_search.addEventListener(EventSearchInput.CHANGE, _handlerChange);
			addChild(_search);			
			
			_verticalLayout = new CustomLayout();
			_verticalLayout.useVirtualLayout = true;			
			
			_list = new List();			
			_list.layout = _verticalLayout;	
			_list.width = _nativeStage.stageWidth;
			_list.hasElasticEdges = false;
			_list.itemRendererFactory = function():IListItemRenderer{
				var renderer:ItemRendererPackedList = new ItemRendererPackedList();
				
				return renderer;
			};
			
			addChild(_list);	
		
			if(_items && _items.length > 0){
				_list.dataProvider = new ListCollection(_items);
			}
			
			_list.addEventListener(EventViewPackedList.CLICK_ITEM, _handlerItemClick);
			
			
			
			_buttonBack = new Button();
			_buttonBack.nameList.add(Constants.BUTTON_CUSTOM_BACK);
			_buttonBack.addEventListener(Event.TRIGGERED, _handlerBackbutton);
						
			_buttonApply = new Button();
			_buttonApply.nameList.add(Constants.BUTTON_APPLY);
			_buttonApply.addEventListener(Event.TRIGGERED, _handlerButtonApply);
			
			var pLeftButtons:Vector.<DisplayObject> = new Vector.<DisplayObject>;
			pLeftButtons.push(_buttonBack);
			
			var pRightButtons:Vector.<DisplayObject> = new Vector.<DisplayObject>;
			pRightButtons.push(_buttonApply);
			
			
			this._header.leftItems = pLeftButtons;
			this._header.rightItems = pRightButtons;
			
			
		}
		
		
		override protected function draw():void{
			super.draw();
					
			if(_header){
				_header.title = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "header.createList");				
			}
			
			if(_search){
				_search.width = _nativeStage.stageWidth;
				_search.validate();
				_search.y = _header.height;
			}
			
			if(_list && !_list.dataProvider){															
				_list.y = _search.y + _search.height;
				_list.height = int(_nativeStage.fullScreenHeight - _search.y - _search.height);
				_list.validate();
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
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerItemClick(event:Event):void{
			event.stopPropagation();
			
			
			var pData:VOPackedItem = VOPackedItem(event.data);
			
			if(pData.childrens && pData.childrens.length > 0){
				
				var pLenght:Number = pData.childrens.length-1;
				
				if(!pData.isOpen){																		
					for(var i:int=pLenght; i>= 0 ;i--){
						_list.dataProvider.addItemAt(pData.childrens[i],pData.index+1);
					}					
				} else {										
					
					var pListLength:Number = _list.dataProvider.length-1;					
					for(var j:int=pLenght; j>= 0 ;j--){						
						_list.dataProvider.removeItem(pData.childrens[j]);						
					}				
				}				
			}						
		}
		
		
		private function _handlerButtonApply(event:Event):void{
			dispatchEvent(new EventViewPackedList(EventViewPackedList.GOTO_VIEW_LIST));
		}
		
		private function _handlerBackbutton(event:Event):void{
			dispatchEvent(new EventViewPackedList(EventViewPackedList.BACK_TO_VIEW_CREATE));
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
			
			if(pLabel.indexOf(pSearch) >= 0){
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