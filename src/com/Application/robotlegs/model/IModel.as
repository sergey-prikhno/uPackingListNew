package com.Application.robotlegs.model {

	import com.Application.robotlegs.model.vo.VOAppSettings;
	import com.Application.robotlegs.model.vo.VOOpenList;
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.model.vo.VOList;

	
	public interface IModel {				
		function get appSettings():VOAppSettings
		function set appSettings(value:VOAppSettings):void
				
		function set newList(value:VOList):void
		function get appLists():Vector.<VOList>
		function set appLists(value:Vector.<VOList>):void

		function get defaultCategories():Vector.<VOPackedItem>
		function set defaultCategories(value:Vector.<VOPackedItem>):void	
			
		function get currentCategories():Vector.<VOPackedItem>
		function set currentCategories(value:Vector.<VOPackedItem>):void
			
		function get currentTableName():VOList
		function set currentTableName(value:VOList):void
		
		function get voOpenList():VOOpenList
		function set voOpenList(value:VOOpenList):void
	
		function updateRemovedLists(value:VOList):void
			
		function set isMore(value:Boolean):void

	}
	
	
}