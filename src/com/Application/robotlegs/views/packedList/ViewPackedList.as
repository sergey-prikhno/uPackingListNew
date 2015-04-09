package com.Application.robotlegs.views.packedList {
	import com.Application.robotlegs.model.vo.VOList;
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.views.ViewAbstract;
	import com.Application.robotlegs.views.packedList.listPacked.CustomLayout;
	import com.Application.robotlegs.views.packedList.listPacked.ItemRendererPackedList;
	import com.Application.robotlegs.views.packedList.listPacked.ListPacked;
	import com.common.Constants;
	
	import feathers.controls.Button;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.skins.IStyleProvider;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
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
		private var _list:ListPacked;
		private var _verticalLayout:CustomLayout;
		
		private var _buttonBack:Button;
		private var _buttonSearch:Button;
		
		private var _items:Vector.<VOPackedItem>;
		
		private var _voList:VOList;
		
		private var _containerAddButtons:Sprite;
		
		private var _buttonAddCategory:Button;
		private var _buttonAddItem:Button;
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
			
			if(_buttonSearch){
				_buttonSearch.removeEventListener(Event.TRIGGERED, _handlerButtonSearch);
			}			
						
			if(_buttonAddCategory){
				_buttonAddCategory.removeEventListener(Event.TRIGGERED, _handlerAddNewCategory);
				_containerAddButtons.removeChild(_buttonAddCategory);	
			}
			 
			if(_buttonAddItem){
				_buttonAddItem.removeEventListener(Event.TRIGGERED, _handlerAddNewItem);
				_containerAddButtons.removeChild(_buttonAddItem);
				_buttonAddItem = null;
			}
			
			if(_containerAddButtons){
				removeChild(_containerAddButtons);
				_containerAddButtons = null;			
			}
			
			_verticalLayout = null;
			
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
			
			if(this._header){
				this._header.title = _voList.title;
			}
		}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		override protected function get defaultStyleProvider():IStyleProvider {
			return ViewPackedList.globalStyleProvider;
		}
		
		override protected function _initialize():void{			
			super._initialize();

			
			_verticalLayout = new CustomLayout();
			_verticalLayout.useVirtualLayout = true;			
			
			_list = new ListPacked();			
			_list.layout = _verticalLayout;	
			_list.width = _nativeStage.stageWidth;
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
						
			_buttonSearch = new Button();
			_buttonSearch.nameList.add(Constants.BUTTON_CUSTOM_SEARCH);
			_buttonSearch.addEventListener(Event.TRIGGERED, _handlerButtonSearch);
			
			var pLeftButtons:Vector.<DisplayObject> = new Vector.<DisplayObject>;
			pLeftButtons.push(_buttonBack);
			
			var pRightButtons:Vector.<DisplayObject> = new Vector.<DisplayObject>;
			pRightButtons.push(_buttonSearch);
			
			
			this._header.leftItems = pLeftButtons;
			this._header.rightItems = pRightButtons;
			
			_containerAddButtons = new Sprite();
			addChild(_containerAddButtons);
			_containerAddButtons.visible = false;
			
			
			_buttonAddCategory = new Button();
			_buttonAddCategory.width = int(_nativeStage.fullScreenWidth*0.9);
			_buttonAddCategory.label = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "button.addnewCategory");
			_buttonAddCategory.addEventListener(Event.TRIGGERED, _handlerAddNewCategory);
			_containerAddButtons.addChild(_buttonAddCategory);
			_buttonAddCategory.validate();
			
			_buttonAddItem = new Button();
			_buttonAddItem.width = int(_nativeStage.fullScreenWidth*0.9);
			_buttonAddItem.label = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "button.addnewItem");
			_buttonAddItem.addEventListener(Event.TRIGGERED, _handlerAddNewItem);
			_containerAddButtons.addChild(_buttonAddItem);
			_buttonAddItem.validate();
			_buttonAddItem.y = int(_buttonAddCategory.height*1.1);
			
			_containerAddButtons.x = int(_nativeStage.fullScreenWidth/2 - _containerAddButtons.width/2);
			
		}
		
		
		override protected function draw():void{
			super.draw();
						
			if(_list && !_list.dataProvider){															
				_list.y = _header.height;
				_list.height = int(_nativeStage.fullScreenHeight- _header.height);
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
		
		
		private function _handlerButtonSearch(event:Event):void{
			/*_list.isEditing = !_list.isEditing; 
			
			_containerAddButtons.visible = _list.isEditing;
			
						
			if(_list.isEditing){				
				_containerAddButtons.y = int(_header.y + _header.height);
				
				_list.height = int(_nativeStage.fullScreenHeight- (_containerAddButtons.y+ _containerAddButtons.height));
				_list.y = int(_containerAddButtons.y + _containerAddButtons.height);
				_buttonSearch.label = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "button.done");				
			} else {
				//_list.y = int(_search.y + _search.height);
				_list.height = int(_nativeStage.fullScreenHeight- _header.height);
				_buttonSearch.label = _resourceManager.getString(Constants.RESOURCES_BUNDLE, "button.edit");
			}
			*/
			 
			
		}
		
		private function _handlerBackbutton(event:Event):void{
			dispatchEvent(new EventViewPackedList(EventViewPackedList.BACK_TO_PREVIOUS_SCREEN));
		}
		
		/**
		 * 
		 * Add new Category Handler
		 * 
		 */
		private function _handlerAddNewCategory(event:Event):void{
			_collapseItems();
			dispatchEvent(new EventViewPackedList(EventViewPackedList.ADD_NEW_CATEGORY));
		}
		
		/**
		 * 
		 * Add new Item Handler
		 * 
		 */
		private function _handlerAddNewItem(event:Event):void{
			_collapseItems();
			dispatchEvent(new EventViewPackedList(EventViewPackedList.ADD_NEW_ITEM));
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
		
		
		/**
		 * 
		 * Collapse Items
		 * 
		 */
		private function _collapseItems():void{
			if(_list && _items && _items.length > 0){
				
				for(var i:int=0;i<_items.length;i++){				
					var pParentItem:VOPackedItem = VOPackedItem(_items[i]);					
					pParentItem.isOpen = false;		
					
					if(pParentItem.isChild){
						_items.splice(i,1);
						i--;
					}												
				}
				
				_list.dataProvider = new ListCollection(_items);
				_list.validate();															
			}			
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}