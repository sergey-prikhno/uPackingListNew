package com.Application.robotlegs.services.settings {
	import com.Application.robotlegs.model.vo.VOAppSettings;
	
	public interface IServiceSettings {
		function getSettingsFirst():void
		function update(value:VOAppSettings):void
	}
}