package com.common {
	import com.hurlant.util.Base64;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	public class FileSerializer {		
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
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function FileSerializer() {
			
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public static function writeObjectToFile(object:Object, fname:String):void	{
			var file:File = File.applicationStorageDirectory.resolvePath(fname);
			
			var pString:String = JSON.stringify(object);			
			pString = Base64.encode(pString);
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(pString);
			//fileStream.writeObject(object);
			fileStream.close();
		}
		
		
		public static function readObjectFromFile(fname:String):Object 	{
			var file:File = File.applicationStorageDirectory.resolvePath(fname);
			
			if(file.exists) {
				var objStr:String;
				var fileStream:FileStream = new FileStream();
				fileStream.open(file, FileMode.READ);
				objStr = fileStream.readUTFBytes(fileStream.bytesAvailable);
				fileStream.close();
				
				var pString:String = Base64.decode(objStr);
				
				var pObject:Object = JSON.parse(pString);
				
				return pObject;
			}
			return null;
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