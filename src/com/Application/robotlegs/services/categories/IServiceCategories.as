package com.Application.robotlegs.services.categories {
	import com.Application.robotlegs.model.vo.VOPackedItem;
	
	public interface IServiceCategories	{
		function createTable(pTableName:String, pDataToInsert:Vector.<VOPackedItem>):void
		function load(pTableName:String):void
		function update(value:VOPackedItem,pTableName:String):void
		function remove(value:VOPackedItem,pTableName:String):void
		function insert(value:VOPackedItem,pTableName:String):void
		function updateRows(pValues:Vector.<VOPackedItem>,pTableName:String):void
	}
	
}