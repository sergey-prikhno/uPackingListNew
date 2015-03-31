package com.Application.robotlegs.model {

	import com.Application.robotlegs.model.vo.VOAppSettings;
	import com.Application.robotlegs.model.vo.VOOpenList;
	import com.Application.robotlegs.model.vo.VOPackedItem;
	import com.Application.robotlegs.model.vo.VOTableName;

	
	public interface IModel {				
		function get appSettings():VOAppSettings
		function set appSettings(value:VOAppSettings):void
				
		function set newList(value:VOTableName):void
		function get appLists():Vector.<VOTableName>
		function set appLists(value:Vector.<VOTableName>):void

		function get defaultCategories():Vector.<VOPackedItem>
		function set defaultCategories(value:Vector.<VOPackedItem>):void	
			
		function get currentCategories():Vector.<VOPackedItem>
		function set currentCategories(value:Vector.<VOPackedItem>):void
			
		function get currentTableName():VOTableName
		function set currentTableName(value:VOTableName):void
		
		function get voOpenList():VOOpenList
		function set voOpenList(value:VOOpenList):void
	
		function get copyingListData():VOTableName
		function set copyingListData(value:VOTableName):void
		
		function updateRemovedLists(value:VOTableName):void
			
		function set isMore(value:Boolean):void

	}
	
	
}