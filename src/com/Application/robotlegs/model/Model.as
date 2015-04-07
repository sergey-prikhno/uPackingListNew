package com.Application.robotlegs.model {

	import com.Application.robotlegs.model.vo.VOAppSettings;
	import com.Application.robotlegs.model.vo.VOCopyList;
	import com.Application.robotlegs.model.vo.VOOpenList;
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.model.vo.VOList;
	
	import org.robotlegs.starling.mvcs.Actor;
	
	public class Model extends Actor implements IModel {						
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
		private var _appLists:Vector.<VOList>;
		private var _VOAppSettings:VOAppSettings;
		
		private var _defaultCategories:Vector.<VOPackedItem>;
		private var _currentCategories:Vector.<VOPackedItem>;
		
		private var _currentTableName:VOList;
		
		private var _voOpenList:VOOpenList;
		
		private var _copyingListData:VOList;
		
		private var _isMore:Boolean = false;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function Model()	{
			super();
			
			_appLists = new Vector.<VOList>();
			_currentTableName = new VOList();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------		

		public function updateRemovedLists(value:VOList):void{
			var pLength:int = _appLists.length;
			for (var i:int = 0; i < pLength; i++){
				if(value.id == _appLists[i].id){
					_appLists.splice(i,1);
					break;
				}
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------

		public function get copyingListData():VOList{
			return _copyingListData;
		}

		public function set copyingListData(value:VOList):void{
			_copyingListData = value;
		}

		public function get voOpenList():VOOpenList{return _voOpenList;}
		public function set voOpenList(value:VOOpenList):void{_voOpenList = value;}

		public function get appLists():Vector.<VOList> {return _appLists;}
		public function set appLists(value:Vector.<VOList>):void {
			_appLists = value;		
		}

		public function set newList(value:VOList):void{
			if(value.isScratch && !_copyingListData){
				dispatch(new EventModel(EventModel.INSERT_TABLE_NAMES, false, value)); 																
			}
			if(value.isScratch && _copyingListData){
				var pVOCopy:VOCopyList = new VOCopyList();
					pVOCopy.listCopy = _copyingListData;
					pVOCopy.listNew = value;
				dispatch(new EventModel(EventModel.COPY_LIST_FORM_EXISTING, false, pVOCopy)); 
				_copyingListData = null;
			}
		}
						
		public function get appSettings():VOAppSettings { return _VOAppSettings;}
		public function set appSettings(value:VOAppSettings):void{
			_VOAppSettings = value;	
		}	
		
		
		public function get defaultCategories():Vector.<VOPackedItem> { return _defaultCategories;}
		public function set defaultCategories(value:Vector.<VOPackedItem>):void{
			_defaultCategories = value;	
		}	
		
		public function get currentCategories():Vector.<VOPackedItem> { return _currentCategories;}
		public function set currentCategories(value:Vector.<VOPackedItem>):void{
			_currentCategories = value;	
			
			
			if(!_isMore){
				/*var pVO:VOScreenID = new VOScreenID();
					pVO.screenID = Main.VIEW_PACKED_LIST;
				dispatch(new EventModel(EventModel.CHANGE_APP_SCREEN, false, pVO));*/
			}
			
			_isMore = false;
		}
		
		public function get currentTableName():VOList { return _currentTableName;}
		public function set currentTableName(value:VOList):void{
			_currentTableName = value;							
		}
		
		public function set isMore(value:Boolean):void{
			_isMore = value;
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