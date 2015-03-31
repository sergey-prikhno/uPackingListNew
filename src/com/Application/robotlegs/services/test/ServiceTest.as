package com.Application.robotlegs.services.test {
	import com.http.net.EventNetwork;
	import com.http.robotlegs.events.EventServiceAbstract;
	import com.http.robotlegs.services.mobile.serviceHTTPAbstract.ServiceHTTPAbstract;
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class ServiceTest extends ServiceHTTPAbstract implements IServiceTest {						
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
		private var _dataRequst:VORequestTest;  
		private var _dataResult:VOResponseTest;				
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ServiceTest() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function load(value:VORequestTest):void {			
			_dataRequst = value;							
				
			_dataResult = new VOResponseTest();
			
			_killRequest();
			_initRequest();			
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
		override protected function _initRequest():void{						
			
			_requestURL = "http://test.php";				
			
			_urlRequest = new URLRequest(_requestURL);
			_urlRequest.method = URLRequestMethod.POST;																									
						
			var pDataRequest:URLVariables = new URLVariables();				
				pDataRequest.email = _dataRequst.test;
													
			_urlRequest.data = pDataRequest;
			
			_sendRequest();		
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		/**
		 * overriding to handle 3 variants of response instead of two basic
		 * 
		 */
		override protected function _completeEventHandler(event:EventNetwork):void {			
			
			event.stopImmediatePropagation();
			try{
				_result = _httpRequest.result;
				_parseResponse();
				if(_serviceResponseIsValid) {
					_successEventHandler();
				}
			} catch(error:Error) {
				_errorHandler();
			}
			
			
			_loadCompletedHandler();			
		}
		
		
		/***
		 * 1. Succsessfull test start: .swf embedded into html page text  
		 * 2. No test available now for this user: 
		 * 3. Error while logging in
		 * 
		 */
		override protected function _parseResponse():void{
			try{
				_serviceResponseIsValid = true;
				
				
				var pResponseJSON:Object = JSON.parse(_result.toString());
				
				var pSuccess:String = pResponseJSON.success;
				
				if(pSuccess == "false"){
					_serviceResponseIsValid = false;
					
					var pErrorObject:* = pResponseJSON.error_msg;
					
						_VOError.message = pResponseJSON.error_msg;

					
				} else {
					_dataResult.parseData(pResponseJSON.result);													
				}
				
				
			} catch (error:Error){
				
				_serviceResponseIsValid = false;
			}
			
			if(!_serviceResponseIsValid){
				dispatch(new EventServiceAbstract(EventServiceAbstract.ERROR, false, _VOError));
			}
			
		}
		
		
		override protected function _successEventHandler():void {																	
			dispatch(new EventServiceTest(EventServiceTest.RESULT, false,  _dataResult));
		}			
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