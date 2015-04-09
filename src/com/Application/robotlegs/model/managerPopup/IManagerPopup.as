package com.Application.robotlegs.model.managerPopup {
	import com.Application.robotlegs.model.vo.VOInfo;
	import com.Application.robotlegs.model.vo.VOList;
	
	
	public interface IManagerPopup {			
		function popupInfo(value:VOInfo):void
		function popupRemoveList(value:VOList):void
	}
}