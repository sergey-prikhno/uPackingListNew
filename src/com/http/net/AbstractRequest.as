/**
 * 
 * Generic async request, provides timeout functionality and responder implementation
 *
 */

package com.http.net {
	
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
	//public class AbstractRequest extends EventDispatcher implements IRequest {
	public class AbstractRequest extends EventDispatcher {
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		protected var _loadTimer:Timer;
		protected var _timeout:uint = SERVER_REQUEST__TIMEOUT_VALUE;
		protected var _result:Object;
		protected var _data:*;
		protected var _isLoading:Boolean = false;

		protected var _requestAttemptCurrent:int = 0;
		protected var _requestAttempts:int = 3;			
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		public static const SERVER_REQUEST__TIMEOUT_VALUE:Number = 30;
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//--------------------------------------------------------------------------------------------------------- 
		public function AbstractRequest(){      
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		/**
		 * Starts loading the request
		 */
		public function load():void {                      
			if(_isLoading){
				return;
			}
			_initTimer();
			_initRequest();
		}
		
		/**
		 * Cancels pending request
		 */
		public function cancel():void{      
			_errorHandle();
			dispatchEvent(new EventNetwork(EventNetwork.REQUEST_CANCELED, false, false));
		}
		
		
		override public function toString():String {
			return '[Request]';
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get requestAttempts():int {
			return _requestAttempts;
		}
		public function set requestAttempts(value:int):void {
			_requestAttempts = value;
		}

		
		
		public function get timeout():uint {
			return _timeout;
		}
		
		
		public function set timeout(seconds:uint):void {
			_timeout = seconds;
		}
		
		/**
		 * Access to a formatted result object (XML, decoded JSON, etc. - depends on implementation)
		 * This is what gets passed to the responder's result handler
		 */
		public function get result():Object {
			return _result;
		}
		
		
		/**
		 * The raw data retrieved from the server
		 */
		public function get data():* {
			return _data;
		}
		
		/**
		 * Are we loading?
		 */
		public function get loading():Boolean {
			var pLoadStatus:Boolean = false
			if (_loadTimer!=null && _loadTimer.running){
				pLoadStatus = true;
			}
			return pLoadStatus;
		}		
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		// Chech number of attempts left
		protected function _tryAgain():Boolean {
			++_requestAttemptCurrent;
			if(_requestAttemptCurrent < requestAttempts){
				// Retry
				_initRequest();
				return true; 
			} else {
				return false;
			}
		}
		
		// pass message to responder fault handlers
		protected function _errorHandle():void {
			_killRequest();
			_killTimer();
		}
		
		/**
		 * Starts listening to load events and start the loading process
		 */    
		protected function _initRequest():void {
			throw new Error('_initRequest() must be implemented in a subclass');
		}

		
		/**
		 * closes the URLLoader and stops listening to URLLoader events
		 */
		protected function _killRequest():void{      
			throw new Error('_initRequest() must be implemented in a subclass');
		}
		
		
		/**
		 * Kills the request, processes result, and triggers complete event
		 * This should be called from an onComplete handler and passed some raw data to process
		 */
		protected function _finishCompletedRequest(rawData:*):void{
			_data = rawData;
			_result = _getResult();
			_killRequest();
			_killTimer();                
			// dispatch the complete event
			dispatchEvent(new EventNetwork(EventNetwork.REQUEST_COMPLETE, false, false));
		}
		
		
		/**
		 * This should be overrided by subclasses to parse XML, JSON, etc.
		 * By default, we just set the result to be the raw data
		 */
		protected function _getResult():*{
			return data;
		}
		
		/**
		 * Starts the timer that is used to manage timeouts
		 */
		protected function _initTimer():void{
			_loadTimer = new Timer(timeout * 1000);
			_loadTimer.addEventListener(TimerEvent.TIMER_COMPLETE, _handleFinalTimeout);
			_loadTimer.start();
		}
		
		
		/**
		 * Stops the timer used to manage timeout
		 */
		protected function _killTimer():void{
			if(!_loadTimer){
				return;
			}
			_loadTimer.stop();
			_loadTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, _handleFinalTimeout);
		}
		
		/**
		 * If Timer has expired.
		 */
		private function _handleFinalTimeout(event:TimerEvent):void{
			_errorHandle();
			dispatchEvent(new EventNetwork(EventNetwork.REQUEST_TIMED_OUT, false, false));
		}
		
	}
}
