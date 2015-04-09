package com.Application.robotlegs.model.managerPopup {
	import com.Application.robotlegs.model.vo.VOInfo;
	import com.Application.robotlegs.model.vo.VOList;
	import com.Application.robotlegs.views.popups.info.EventPopupInfo;
	import com.Application.robotlegs.views.popups.info.PopupInfo;
	import com.Application.robotlegs.views.popups.removeList.EventPopupRemoveList;
	import com.Application.robotlegs.views.popups.removeList.PopupRemoveList;
	
	import flash.display.Stage;
	
	import ch.ala.locale.LocaleManager;
	
	import feathers.core.PopUpManager;
	
	import org.robotlegs.starling.mvcs.Actor;
	
	import starling.core.Starling;
	
	public class ManagerPopup extends Actor implements IManagerPopup {		
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
		
		private var _nativeStage:Stage;
		private var _resourceManager:LocaleManager;
		
		private var _popupInfo:PopupInfo;
		private var _popupRemoveList:PopupRemoveList;
		
		private var _voRemovingList:VOList;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ManagerPopup() {
			super();
			_nativeStage = Starling.current.nativeStage;
			
			_resourceManager = LocaleManager.getInstance();

		}				
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function popupInfo(value:VOInfo):void{
			if(!_popupInfo){
				_popupInfo = new PopupInfo();
				_popupInfo.voInfo = value;
				_popupInfo.addEventListener(EventPopupInfo.CLOSE_POPUP_INFO, _handlerClosePopupInfo);
			}
			_popupInfo.width = _nativeStage.fullScreenWidth;
			_popupInfo.height = _nativeStage.fullScreenHeight;
			PopUpManager.addPopUp(_popupInfo,true);
		}
		
		public function popupRemoveList(value:VOList):void{
			_voRemovingList = null;
			_voRemovingList = value;
			if(!_popupRemoveList){
				_popupRemoveList = new PopupRemoveList();
				_popupRemoveList.addEventListener(EventPopupRemoveList.CANCEL_POPUP, _handlerClosePopupRemove);
				_popupRemoveList.addEventListener(EventPopupRemoveList.REMOVE_LIST, _handlerAccseptRemove);
			}
			_popupRemoveList.width = _nativeStage.fullScreenWidth;
			_popupRemoveList.height = _nativeStage.fullScreenHeight;
			PopUpManager.addPopUp(_popupRemoveList,true);
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
		
		private function _removePopupRemoveList():void{
			if(_popupRemoveList){
				_popupRemoveList.removeEventListener(EventPopupRemoveList.CANCEL_POPUP, _handlerClosePopupRemove);
				_popupRemoveList.removeEventListener(EventPopupRemoveList.REMOVE_LIST, _handlerAccseptRemove);
				_popupRemoveList.destroy();
				PopUpManager.removePopUp(_popupRemoveList, true);
				_popupRemoveList = null;
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------		
		
		private function _handlerClosePopupRemove(event:EventPopupRemoveList):void{
			_removePopupRemoveList();
		}
		
		private function _handlerAccseptRemove(event:EventPopupRemoveList):void{
			_removePopupRemoveList();
			dispatch(new EventManagerPopup(EventManagerPopup.ACCEPT_REMOVE_LIST,false,_voRemovingList));
		}
		
		private function _handlerClosePopupInfo(event:EventPopupInfo):void{
			if(_popupInfo){
				_popupInfo.removeEventListener(EventPopupInfo.CLOSE_POPUP_INFO, _handlerClosePopupInfo);
				_popupInfo.destroy();
				PopUpManager.removePopUp(_popupInfo, true);
				_popupInfo = null;
			}
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