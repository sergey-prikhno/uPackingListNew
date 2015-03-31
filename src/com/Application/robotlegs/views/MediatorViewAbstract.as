package com.Application.robotlegs.views {
	import org.robotlegs.starling.mvcs.Mediator;
	
	public class MediatorViewAbstract extends Mediator {		
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
		public function MediatorViewAbstract() 	{
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function onRegister():void{	
			super.onRegister();
			
			addViewListener(EventViewAbstract.UPDATE_SETTINGS, _handlerUpdateSettings, EventViewAbstract);
			addViewListener(EventViewAbstract.CREATE_NEW_LIST, _handlerCreateNewList, EventViewAbstract);
		}
		
		
		override public function onRemove():void {
			super.onRemove();
			
			removeViewListener(EventViewAbstract.UPDATE_SETTINGS, _handlerUpdateSettings, EventViewAbstract);
			removeViewListener(EventViewAbstract.CREATE_NEW_LIST, _handlerCreateNewList, EventViewAbstract);
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
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
		private function _handlerUpdateSettings(event:EventViewAbstract):void{
			dispatch(event);
		}
		
		private function _handlerCreateNewList(event:EventViewAbstract):void{
			dispatch(new EventViewAbstract(EventViewAbstract.ADD_NEW_LIST));
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