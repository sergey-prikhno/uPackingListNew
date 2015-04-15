package com.Application.robotlegs.services.tableNames
{
	import com.Application.robotlegs.model.vo.VOList;

	public interface IServiceTableNames
	{
		function getTableNamesFirst():void
		function insert(value:VOList):void
		function updateListPersent(value1:VOList):void
	}
}