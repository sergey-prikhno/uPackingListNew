package com.Application.robotlegs.views.main {
	import com.Application.robotlegs.model.vo.VOList;
	import com.Application.robotlegs.views.EventViewAbstract;
	import com.Application.robotlegs.views.MediatorViewAbstract;
	
	public class MediatorViewMain extends MediatorViewAbstract {		
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
		
		private function _setLists(value:Vector.<VOList>):void {
			view.vectorLists = value;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function MediatorViewMain() 	{
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function onRegister():void{	
			super.onRegister();
						
			dispatch(new EventViewAbstract(EventViewAbstract.GET_CREATED_LISTS, false, null, _setLists));
		}
		
		
		override public function onRemove():void {
			super.onRemove();
					
	
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get view():ViewMain{
			return ViewMain(viewComponent);
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