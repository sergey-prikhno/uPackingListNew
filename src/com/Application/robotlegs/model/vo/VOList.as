package com.Application.robotlegs.model.vo {
	
	public class VOList {
		
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
		private var _id:Number = 0;
		private var _title:String = "";
		private var _table_name:String = "";
		private var _dateCreate:String = "";
		private var _persents:Number = 0;
		private var _isOpenEdit:Boolean = false;
		private var _isOpenRemove:Boolean = false;
		private var _isCreating:Boolean = false;
		private var _isEditing:Boolean = false;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------

		

		public function get isEditing():Boolean
		{
			return _isEditing;
		}

		public function set isEditing(value:Boolean):void
		{
			_isEditing = value;
		}

		public function get isCreating():Boolean
		{
			return _isCreating;
		}

		public function set isCreating(value:Boolean):void
		{
			_isCreating = value;
		}

		public function get persents():Number{
			return _persents;
		}

		public function set persents(value:Number):void
		{
			_persents = value;
		}

		public function get isOpenRemove():Boolean
		{
			return _isOpenRemove;
		}

		public function set isOpenRemove(value:Boolean):void
		{
			_isOpenRemove = value;
		}

		public function get isOpenEdit():Boolean
		{
			return _isOpenEdit;
		}

		public function set isOpenEdit(value:Boolean):void
		{
			_isOpenEdit = value;
		}

		public function get date_create():String{return _dateCreate;}
		public function set date_create(value:String):void{
			_dateCreate = value;
		}

		public function get id():Number { return _id;}
		public function set id(value:Number):void{
			_id = value;
		}	
		
		public function get title():String { return _title;}
		public function set title(value:String):void{
			_title = value;
		}
		
		public function get table_name():String { return _table_name;}
		public function set table_name(value:String):void{
			_table_name = value;
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