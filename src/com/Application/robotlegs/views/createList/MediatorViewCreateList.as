package com.Application.robotlegs.views.createList {
	import com.Application.robotlegs.model.vo.VOInfo;
	import com.Application.robotlegs.model.vo.VOList;
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.MediatorViewAbstract;
	
	public class MediatorViewCreateList extends MediatorViewAbstract {		
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
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function MediatorViewCreateList() 	{
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function onRegister():void{	
			super.onRegister();
			addViewListener(EventViewCreateList.CREATE_NEW_LIST, _handlerCreateList, EventViewCreateList);
			addViewListener(EventViewAbstract.SHOW_INFO_POPUP, _handlerShowInfoPopup, EventViewAbstract);
		}
		
		
		override public function onRemove():void {
			super.onRemove();
			removeViewListener(EventViewCreateList.CREATE_NEW_LIST, _handlerCreateList, EventViewCreateList);
			removeViewListener(EventViewAbstract.SHOW_INFO_POPUP, _handlerShowInfoPopup, EventViewAbstract);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get view():ViewCreateList{
			return ViewCreateList(viewComponent);
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
		
		private function _handlerShowInfoPopup(event:EventViewAbstract):void{
			dispatch(new EventViewAbstract(EventViewAbstract.SHOW_INFO_POPUP, false, VOInfo(event.data)));
		}
		
		private function _handlerCreateList(event:EventViewCreateList):void{
			dispatch(new EventViewCreateList(EventViewCreateList.CREATE_NEW_LIST, false, VOList(event.data)));
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