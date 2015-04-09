package com.Application.robotlegs.views.packedList.listPacked {
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.packedList.EventViewPackedList;
	
	import feathers.controls.List;
	import feathers.controls.Scroller;
	import feathers.controls.supportClasses.ListDataViewPort;
	import feathers.dragDrop.DragData;
	import feathers.dragDrop.IDropTarget;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	
	public class ListPacked extends List implements IDropTarget{		
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
		private var _isEditing:Boolean = false;		
		private var _isDragable:Boolean = true;
		public static const DRAG_FORMAT:String = "itemDrag";
				
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ListPacked() {
			super();			
			this.addEventListener(DragDropPackedListEvent.DRAG_ENTER, dragEnterHandler);
			this.addEventListener(DragDropPackedListEvent.DRAG_EXIT, dragExitHandler);
			this.addEventListener(DragDropPackedListEvent.DRAG_DROP, dragDropHandler);				
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function dispose():void{
			this.removeEventListener(DragDropPackedListEvent.DRAG_ENTER, dragEnterHandler);
			this.removeEventListener(DragDropPackedListEvent.DRAG_EXIT, dragExitHandler);
			this.removeEventListener(DragDropPackedListEvent.DRAG_DROP, dragDropHandler);			
			
			super.dispose();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get viewPordData():ListDataViewPort{
			return dataViewPort;			
		}
		
		public function get isEditing():Boolean { return _isEditing;}
		public function set isEditing(value:Boolean):void{
			_isEditing = value;
			
			dispatchEvent(new EventViewPackedList(EventViewPackedList.UPDATE_STATE));
		}		
		
		public function get isDragable():Boolean { return _isDragable;}
		public function set isDragable(value:Boolean):void{
			_isDragable = value;
		}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function dragEnterHandler(event:DragDropPackedListEvent, dragData:DragData):void {

			DragDropListPackedManager.limitYTopPos = y-((width/8)/4);
			DragDropListPackedManager.limitYBottomPos = y+height-((width/8)/2);
													
			if(!dragData.hasDataForFormat(DRAG_FORMAT)) {
				return;
			}
								
			
			if(this.alpha != .5){				
				completeAnimation();
				
				var pTween:Tween = new Tween(this,.2,Transitions.EASE_OUT);
				pTween.animate("alpha",.5);
				pTween.onComplete = completeAnimation;
				
				Starling.juggler.add(pTween);							
			}
			
			DragDropListPackedManager.acceptDrag(this);						
		}
		
		
		private function dragExitHandler(event:DragDropPackedListEvent, dragData:DragData):void {								
			
			if(this.alpha != 1){
				completeAnimation();
				
				var pTween:Tween = new Tween(this,.2,Transitions.EASE_OUT);
				pTween.animate("alpha",1);
				pTween.onComplete = completeAnimation;								
				Starling.juggler.add(pTween);							
			}
		//	this.verticalScrollPolicy = Scroller.SCROLL_POLICY_ON;
		}
		
		private function dragDropHandler(event:DragDropPackedListEvent, dragData:DragData):void {
		
			
				var droppedObject:ItemRendererPackedList = ItemRendererPackedList(dragData.getDataForFormat(DRAG_FORMAT))
				droppedObject.x = Math.min(Math.max(event.localX - droppedObject.width / 2,
					0), this.actualWidth - droppedObject.width); //keep within the bounds of the target
				droppedObject.y = Math.min(Math.max(event.localY - droppedObject.height / 2,
					0), this.actualHeight - droppedObject.height); //keep within the bounds of the target
				
				
				var pIndex:int = 0;
								
				if(droppedObject.y < droppedObject.height) {
					pIndex = 0;
				} else {
				//	var pCalcIndex:Number = droppedObject.y/droppedObject.height;
					
					
					
					pIndex = Math.round(droppedObject.y/droppedObject.height + verticalScrollPosition/droppedObject.height);
					
				}
							
				trace("------------------->> "+pIndex);
				
				var pItemDroppedData:VOPackedItem = VOPackedItem(droppedObject.data);
					
			
				
				//UPDATE_ORDER_INDEXES
											
				var pUnderItemData:VOPackedItem;
				var pVectorItems:Vector.<VOPackedItem> = new Vector.<VOPackedItem>();				
				
				var pDroppedOrderIndex:int = 1;
				
				if(!pItemDroppedData.isChild){
					
					//for Parent
					try{								
						pUnderItemData = VOPackedItem(dataProvider.getItemAt(pIndex));							
						
						if(!pUnderItemData.isChild){
							pDroppedOrderIndex = pItemDroppedData.orderIndex; 
							pItemDroppedData.orderIndex = pUnderItemData.orderIndex;				
							pVectorItems.push(pItemDroppedData);
						}
						
					} catch(error:Error) { }
																																		
					if(pUnderItemData && pUnderItemData.isChild) {
						pIndex = droppedObject.backIndex;
					}
					
					
					dataProvider.addItemAt(pItemDroppedData,pIndex);
					
					
					for(var i:int=0;i<dataProvider.data.length;i++){	
						var pItem:VOPackedItem = VOPackedItem(dataProvider.data[i]);
						
						if(!pItem.isChild){
							pItem.orderIndex = i+1;
							pVectorItems.push(pItem);						
						}
					}
					
					
				} else {
					//for Children
					
					try{						
						pUnderItemData = VOPackedItem(dataProvider.getItemAt(pIndex));	
						
					//	trace("Label "+pUnderItemData.label);	
					//	trace("pIndex " + pIndex);
						
					}catch(error:Error){}
					
					
					if(pUnderItemData && !pUnderItemData.isChild && pItemDroppedData.parentId == pUnderItemData.item_id){								
						pIndex++;
					
					} else if(pUnderItemData && !pUnderItemData.isChild && pItemDroppedData.parentId != pUnderItemData.item_id) {		
						
						var pTempIndex:int = pIndex - 1;
						var pTempItem:VOPackedItem; 
						
						
						try{
							pTempItem = dataProvider.data[pTempIndex];
						}catch(error:Error){}
						
						if(pTempItem && pTempItem.isChild && pTempItem.parentId == pItemDroppedData.parentId){
							
						} else {						
							pIndex = droppedObject.backIndex;
						}
					} else if(!pUnderItemData){
						pIndex = droppedObject.backIndex;
					}
					
					
					dataProvider.addItemAt(pItemDroppedData,pIndex);	
					
					if(pItemDroppedData.isChild){
						
						
						for(var k:int=0;k<dataProvider.data.length;k++){	
							var pItemCh:VOPackedItem = VOPackedItem(dataProvider.data[k]);
							
							if(pItemCh.isChild && pItemCh.parentId == pItemDroppedData.parentId){																							
								pItemCh.orderIndex = k+1;										
								pVectorItems.push(pItemCh);																																																			
							}							
						}					
					}					
																
				}
							
								
				
				
				droppedObject.dispose();
				droppedObject = null;		
				
				
				
				///////////traceee
			/*	for(var i:int=0;i<dataProvider.length; i++){
					
				//	if(pItemDroppedData.parentId ==VOPackedItem(dataProvider.data[i]).parentId){
					trace(VOPackedItem(dataProvider.data[i]).label);
					trace(VOPackedItem(dataProvider.data[i]).orderIndex);
					trace("-------------------------------------------");
				//	}
				}
				trace("+++++++++++++++++++++++++++++++++++++++++++++++++=");*/
				////////////////////
				
				
			
				if(pVectorItems && pVectorItems.length){
					dispatchEvent(new EventViewAbstract(EventViewAbstract.UPDATE_DB_ORDER_INDEXES, true, pVectorItems));
				}
							
				
			//anim List	
			if(this.alpha != 1){
				completeAnimation();
				var pTween:Tween = new Tween(this,.2,Transitions.EASE_OUT);
				pTween.animate("alpha",1);
				pTween.onComplete = completeAnimation;
				
				Starling.juggler.add(pTween);							
			}
			
			this.verticalScrollPolicy = Scroller.SCROLL_POLICY_ON;
		}						
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
		private function completeAnimation():void{
			Starling.juggler.removeTweens(this);
			
		}		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
	}
}