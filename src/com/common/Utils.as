package com.common{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.display3D.Context3D;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	
	import avmplus.getQualifiedClassName;
	
	import starling.core.RenderSupport;
	import starling.core.Starling;
	import starling.display.DisplayObject;

	public class Utils{
		/**
		 * Delete empty space in string
		 */ 
		public static function Trim(pStr:String): String {
			var len:Number = pStr.length;
			if(pStr.charCodeAt(0)==32) pStr = Trim(pStr.substring(1,len));
			if(pStr.charCodeAt(len-1)==32) pStr = Trim(pStr.substring(0,len-1));			
			return pStr;
		}		
		
		public static function copyAsBitmapData(sprite:DisplayObject,sprite2:DisplayObject):BitmapData {
			if (sprite == null) return null;
			
			var resultRect:Rectangle = new Rectangle(0,0,Starling.current.stage.stageWidth,Starling.current.stage.stageHeight);
			
			var context:Context3D = Starling.context;
			var support:RenderSupport = new RenderSupport();
			RenderSupport.clear();
			
			support.setProjectionMatrix(0,0,Starling.current.stage.stageWidth, Starling.current.stage.stageHeight);
			support.transformMatrix(sprite.root);
			support.translateMatrix( -resultRect.x, -resultRect.y);
			
			var result:BitmapData = new BitmapData(resultRect.width, resultRect.height, true, 0xffffff);
						
			support.pushMatrix();
			support.transformMatrix(sprite);
			sprite.render(support, 1);
			
			support.popMatrix();
			support.finishQuadBatch();
			
			context.drawToBitmapData(result);
			
			var croppedRes:BitmapData = new BitmapData(sprite2.width, sprite2.height, true, 0xffffff );
			//croppedRes.copyPixels(result, new Rectangle(0,0,Math.round(sprite.width),Math.round(sprite.height)), new Point(Math.round(sprite.pivotX),Math.round(sprite.pivotY)));			
			croppedRes.copyPixels(result, new Rectangle(Math.round(sprite2.x-sprite2.width/2) ,Math.round(sprite2.y-sprite2.height/2),sprite2.width,sprite2.height), new Point(0,0));
			
			return croppedRes;		
		}
		
		public static function bitmapScaled(pSource:Bitmap):BitmapData {
			var pMatrix:Matrix = new Matrix();
			pMatrix.scale(1,1);
			
			var pTempSprite:flash.display.Sprite = new flash.display.Sprite();
			pTempSprite.addChild(pSource);
			
			var pBitmapData:BitmapData = new BitmapData(pTempSprite.width, pTempSprite.height, false);
			pBitmapData.draw(pTempSprite, pMatrix, null, null, null, true);
			
			
			return pBitmapData;
		}
		
		public static function resizeAcpectRation(pSource:Bitmap,pWidth:Number,pHeight:Number):BitmapData {
						
			pSource.smoothing = true;
			pSource.pixelSnapping = PixelSnapping.ALWAYS;
			pSource.bitmapData.lock();
			
			var mat:Matrix = new Matrix();
			var ratio:Number = Math.min(pWidth/pSource.width,pHeight/pSource.height);
						
			mat.scale(ratio,ratio);
			var bmpData:BitmapData = new BitmapData(Math.round(pSource.width*ratio), Math.round(pSource.height*ratio), true, 0xFFFFFF);			
			bmpData.drawWithQuality(pSource,mat,null,null,null,true,StageQuality.BEST);
			//bmpData.draw(pSource, mat);						
			pSource.bitmapData.unlock();
			return bmpData;			
		}
		
		public static function resizeAcpectRation2(pSource:Bitmap,pWidth:Number,pHeight:Number):BitmapData {
			
			if(pSource.height > pSource.width){			
				pSource.height = pWidth * (pSource.height / pSource.width);
				pSource.width = pWidth;
			} else {
				pSource.width = pHeight * (pSource.width / pSource.height);
				pSource.height = pHeight;
			}
			
			var pScaledBitmapData:BitmapData = bitmapScaled(pSource)
			
			return pScaledBitmapData;
		}
		
		public static function angleInRadians(pNum:Number):Number{
			var pRadians:Number = Math.PI * 2 * (pNum / 360);
			return pRadians;
		}
		
		
		public static function rotateBitmapData( bitmapData:BitmapData, degree:int = 0 ):BitmapData{
			var newBitmap:BitmapData = new BitmapData( bitmapData.height, bitmapData.width, true );
			var matrix:Matrix = new Matrix();
			matrix.rotate( angleInRadians( degree ));
			
			if ( degree == 90 ) {
				matrix.translate( bitmapData.height, 0 );
			} else if ( degree == -90 || degree == 270 ) {
				matrix.translate( 0, bitmapData.width );
			} else if ( degree == 180 ) {
				newBitmap = new BitmapData( bitmapData.width, bitmapData.height, true );
				matrix.translate( bitmapData.width, bitmapData.height );
			}
			
			newBitmap.draw( bitmapData, matrix, null, null, null, true )
			return newBitmap;
		}
		
		
		public static function cropBitmap(pSource:BitmapData,pWidth:Number,pHeight:Number):BitmapData {
			
			/*	var pBitmapData:BitmapData = new BitmapData(pWidth,pHeight);
			pBitmapData.draw(pSource);*/
			
			var croppedRes:BitmapData = new BitmapData(pWidth, pHeight, true,0xffffff );
			//croppedRes.copyPixels(result, new Rectangle(0,0,Math.round(sprite.width),Math.round(sprite.height)), new Point(Math.round(sprite.pivotX),Math.round(sprite.pivotY)));			
			croppedRes.copyPixels(pSource, new Rectangle(Math.round(pSource.width/2 - pWidth/2),Math.round(pSource.height/2 - pHeight/2),pWidth,pHeight), new Point(0,0));
			
			return croppedRes;
		}		
		
		
		public static function emailValidation(pSource:String):Boolean {
			
			var regExpPattern:RegExp = /^[0-9a-zA-Z][-._a-zA-Z0-9]*@([0-9a-zA-Z][-._0-9a-zA-Z]*\.)+[a-zA-Z]{2,4}$/;
			
			if(pSource.match(regExpPattern) == null ){
				return false;
			} else {
				return true;
			}
		}
		
		public static function resize(_w:Number,_h:Number,_targetW:Number,_targetH:Number,_ratio:Number = 0):Object {
			var ratio:Number = (_ratio ==0) ? _w / _h : _ratio;
			var rW:Number = _targetW;
			var rH:Number = _targetH;
			if (ratio >= 1) {
				rH = _targetW / ratio;
				if (rH > _targetH) {
					rH = _targetH;
					rW = rH * ratio;
				}
			}else {
				rW = _targetH * ratio;
				if (rW > _targetW) {
					rW = _targetW;
					rH = rW / ratio;
				}
			}
			var newDimensions:Object = {width:rW,height:rH };
			return newDimensions;
		}
		
		public static function validatePassword(pPass1:String, pPass2:String):Boolean{
			var pIsValid:Boolean = false;
			
			if(pPass1 == pPass2 && pPass1.length > 0 && pPass2.length > 0){
				pIsValid = true;
			}
			return pIsValid;
		}
		
		
		//objectCopy Util
		public static function newSibling(sourceObj:Object):* {
			if(sourceObj) {
				
				var objSibling:*;
				try {
					var classOfSourceObj:Class = getDefinitionByName(getQualifiedClassName(sourceObj)) as Class;
					objSibling = new classOfSourceObj();
				}
				
				catch(e:Object) {}
				
				return objSibling;
			}
			return null;
		}
		
		public static function clone(source:Object):Object {
			
			var clone:Object;
			if(source) {
				clone = newSibling(source);
				
				if(clone) {
					copyData(source, clone);
				}
			}
			
			return clone;
		}
		
		public static function copyData(source:Object, destination:Object):void {
			
			//copies data from commonly named properties and getter/setter pairs
			if((source) && (destination)) {
				
				try {
					var sourceInfo:XML = describeType(source);
					var prop:XML;
					
					for each(prop in sourceInfo.variable) {
						
						if(destination.hasOwnProperty(prop.@name)) {
							destination[prop.@name] = source[prop.@name];
						}
						
					}
					
					for each(prop in sourceInfo.accessor) {
						if(prop.@access == "readwrite") {
							if(destination.hasOwnProperty(prop.@name)) {
								destination[prop.@name] = source[prop.@name];
							}
							
						}
					}
				}
				catch (err:Object) {
					;
				}
			}
		}
		
		
	}
}







