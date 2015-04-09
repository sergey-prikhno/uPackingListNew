package com.Application.components.calendar {
	import com.Application.components.calendar.stepper.CalendarStepper;
	import com.Application.components.calendar.stepper.EventCalendarStepper;
	import com.common.Constants;
	import com.common.Utils;
	
	import feathers.core.FeathersControl;
	import feathers.skins.IStyleProvider;
	
	public class PopupCalendar extends FeathersControl {		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		public static var globalStyleProvider:IStyleProvider;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		private var _calendarStepperMonth:CalendarStepper;
		private var _calendarStepperYear:CalendarStepper;
		private var _calendarStepperDay:CalendarStepper;
		
		private var _voDate:VODate;
		
		private var _scale:Number = 1;
		private var _nativeWidth:Number = 0;
		
		protected var _day:int;
		protected var _month:int;
		protected var _year:int;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function PopupCalendar() {
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------


		public function destroy():void{
			
			_voDate = null;
			
			if(_calendarStepperMonth){
				_calendarStepperMonth.destroy();
				_calendarStepperMonth.removeEventListener(EventCalendarStepper.CLICK_UP, _handlerCalendarStepperMonthUp);
				_calendarStepperMonth.removeEventListener(EventCalendarStepper.CLICK_DOWN, _handlerCalendarStepperMonthDown);
				removeChild(_calendarStepperMonth, true);
				_calendarStepperMonth = null;
			}
			if(_calendarStepperDay){
				_calendarStepperDay.destroy();
				_calendarStepperDay.removeEventListener(EventCalendarStepper.CLICK_UP, _handlerCalendarStepperDayUp);
				_calendarStepperDay.removeEventListener(EventCalendarStepper.CLICK_DOWN, _handlerCalendarStepperDayDown);
				removeChild(_calendarStepperDay, true);
				_calendarStepperDay = null;
			}
			if(_calendarStepperYear){
				_calendarStepperYear.destroy();
				_calendarStepperYear.removeEventListener(EventCalendarStepper.CLICK_UP, _handlerCalendarStepperYearUp);
				_calendarStepperYear.removeEventListener(EventCalendarStepper.CLICK_DOWN, _handlerCalendarStepperYearDown);
				removeChild(_calendarStepperYear, true);
				_calendarStepperYear = null;
			}
			
			
		}
		
		public function getCreateDate():String{
			var pCreateDate:String = "";

			var d:String = "";
			var m:String = "";
			var y:String = "";
			d = _calendarStepperDay._label.text;
			if(d.length == 1){
				d = "0"+d;
			}
			for (var i:int = 0; i < Constants.months.length; i++){
				if(Constants.months[i] == _calendarStepperMonth._label.text){
					m = String(i+1);
					if(m.length == 1){
						m = "0"+m;
					}
					break;
				}
			}
			y = _calendarStepperYear._label.text;
			pCreateDate = d+"."+m+"."+y;
			
			return pCreateDate;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get date():VODate{ return _voDate;}
		public function set scale(value:Number):void{_scale = value;}
		override protected function get defaultStyleProvider():IStyleProvider {
			return PopupCalendar.globalStyleProvider;
		}
		public function set nativeWidth(value:Number):void{	_nativeWidth = value;}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		override protected function initialize():void{
			
			if(!_calendarStepperMonth){
				_calendarStepperMonth = new CalendarStepper();
				_calendarStepperMonth.addEventListener(EventCalendarStepper.CLICK_UP, _handlerCalendarStepperMonthUp);
				_calendarStepperMonth.addEventListener(EventCalendarStepper.CLICK_DOWN, _handlerCalendarStepperMonthDown);
				addChild(_calendarStepperMonth);
			}
			if(!_calendarStepperDay){
				_calendarStepperDay = new CalendarStepper();
				_calendarStepperDay.addEventListener(EventCalendarStepper.CLICK_UP, _handlerCalendarStepperDayUp);
				_calendarStepperDay.addEventListener(EventCalendarStepper.CLICK_DOWN, _handlerCalendarStepperDayDown);
				addChild(_calendarStepperDay);
			}
			if(!_calendarStepperYear){
				_calendarStepperYear = new CalendarStepper();
				_calendarStepperYear.addEventListener(EventCalendarStepper.CLICK_UP, _handlerCalendarStepperYearUp);
				_calendarStepperYear.addEventListener(EventCalendarStepper.CLICK_DOWN, _handlerCalendarStepperYearDown);
				addChild(_calendarStepperYear);
			}
			
			if(!_voDate){
				_voDate = new VODate();
			}
			
			
		}
		
		override protected function draw():void{
			_getCurrentDate();
			
			if(_calendarStepperDay){
				_calendarStepperDay.width = int(100*_scale);
				_calendarStepperDay.height = int(72*_scale);
				_calendarStepperDay.data = String(_day);
				_calendarStepperDay.validate();
				_calendarStepperDay.x = int(80*_scale);
			}
			
			if(_calendarStepperMonth){
				_calendarStepperMonth.width = int(200*_scale);
				_calendarStepperMonth.height = int(72*_scale);
				_calendarStepperMonth.data = String(Constants.months[_month]);
				_calendarStepperMonth.validate();
				_calendarStepperMonth.x = _nativeWidth/2 - _calendarStepperMonth.width/2;
			}
			
			if(_calendarStepperYear){
				_calendarStepperYear.width = int(100*_scale);
				_calendarStepperYear.height = int(72*_scale);
				_calendarStepperYear.data = String(_year);
				_calendarStepperYear.validate();
				_calendarStepperYear.x = _nativeWidth - _calendarStepperYear.width - int(80*_scale);
			}
			
			
		}
		
		private function _getCurrentDate():void{
			var pDate:Date = new Date();
			_month = pDate.month;
			_day = pDate.date;
			_year = pDate.fullYear;
		}
		
		private function _updateSteppers():void{
			_calendarStepperMonth.data = String(Constants.months[_month]);
			_calendarStepperMonth.validate();
			
			_calendarStepperDay.data = String(_day);
			_calendarStepperDay.validate();

			_calendarStepperYear.data = String(_year);
			_calendarStepperYear.validate();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		private function _handlerCalendarStepperDayUp(event:EventCalendarStepper):void{
			var pEndDay:int = Utils.getEndDay(_month,_year);
			_day++;
			if(_day > pEndDay){
				_day = 1;
			}
			_updateSteppers();
		}
		
		private function _handlerCalendarStepperDayDown(event:EventCalendarStepper):void{
			var pEndDay:int = Utils.getEndDay(_month,_year);
			_day--;
			if(_day < 1){
				_day = pEndDay;
			}
			_updateSteppers();
		}
		
		private function _handlerCalendarStepperYearUp(event:EventCalendarStepper):void{
			_year++;
			_day = Math.min(_day, Utils.getEndDay(_month,_year));
			_updateSteppers();
		}
		
		private function _handlerCalendarStepperYearDown(event:EventCalendarStepper):void{
			_year--;
			_day = Math.min(_day, Utils.getEndDay(_month,_year));
			_updateSteppers();
		}
		
		private function _handlerCalendarStepperMonthUp(event:EventCalendarStepper):void{
			_month++;
			if(_month > 11) {
				_month = 0;
				_year++;
			}
			_day = Math.min(_day, Utils.getEndDay(_month,_year));
			
			_updateSteppers();
		}

		private function _handlerCalendarStepperMonthDown(event:EventCalendarStepper):void{
			_month--;
			if(_month < 0) 	{
				_month = 11;
				_year--;
			}
			_day = Math.min(_day, Utils.getEndDay(_month,_year));
			
			_updateSteppers();
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