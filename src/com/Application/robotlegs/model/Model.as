package com.Application.robotlegs.model {

	import com.Application.robotlegs.model.vo.VOAppSettings;
	import com.Application.robotlegs.model.vo.VOCopyList;
	import com.Application.robotlegs.model.vo.VOOpenList;
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.model.vo.VOTableName;
	
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
		private var _appLists:Vector.<VOTableName>;
		private var _VOAppSettings:VOAppSettings;
		
		private var _defaultCategories:Vector.<VOPackedItem>;
		private var _currentCategories:Vector.<VOPackedItem>;
		
		private var _currentTableName:VOTableName;
		
		private var _voOpenList:VOOpenList;
		
		private var _copyingListData:VOTableName;
		
		private var _isMore:Boolean = false;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function Model()	{
			super();
			
			_appLists = new Vector.<VOTableName>();
			_currentTableName = new VOTableName();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------		

		public function updateRemovedLists(value:VOTableName):void{
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

		public function get copyingListData():VOTableName{
			return _copyingListData;
		}

		public function set copyingListData(value:VOTableName):void{
			_copyingListData = value;
		}

		public function get voOpenList():VOOpenList{return _voOpenList;}
		public function set voOpenList(value:VOOpenList):void{_voOpenList = value;}

		public function get appLists():Vector.<VOTableName> {return _appLists;}
		public function set appLists(value:Vector.<VOTableName>):void {
			_appLists = value;		
		}

		public function set newList(value:VOTableName):void{
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
		
		public function get currentTableName():VOTableName { return _currentTableName;}
		public function set currentTableName(value:VOTableName):void{
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