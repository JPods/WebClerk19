// https://discuss.4d.com/t/a-short-tutorial-on-how-to-create-a-timestamp-class-in-4d-v18-r4/15169
// Modified by: Bill James (2022-07-20T05:00:00Z)
// Method: cDateTime
// Description 
// Parameters
// ----------------------------------------------------


Class constructor($date : Date; $time : Time)
	// date is a local variable that does not show to the user as an attribute
	If ($date=!00-00-00!)
		This:C1470.date:=Current date:C33
	Else 
		This:C1470.date:=$date
	End if 
	If ($time=?00:00:00?)
		This:C1470.time:=Current time:C178
	Else 
		This:C1470.time:=$time
	End if 
	If (This:C1470.time=?00:00:01?)
		This:C1470.setDateTime(!00-00-00!; ?00:00:00?)
	Else 
		This:C1470.setDateTime(This:C1470.date; This:C1470.time)
	End if 
	
	This:C1470.begin:=New object:C1471("date"; This:C1470.date+Storage:C1525.dateSpan.begin.days; \
		"epoch"; 0; \
		"time"; This:C1470.time)
	This:C1470.end:=New object:C1471("date"; This:C1470.date+Storage:C1525.dateSpan.end.days; \
		"epoch"; 0; \
		"time"; ?00:00:00?)
	
	
	
	
	//MARK:-  setters
	// is setting not returning
Function setDateTime($date : Date; $time : Time)
	This:C1470.date:=$date
	This:C1470.time:=$time
	This:C1470.dt90:=((This:C1470.date-!1990-01-01!)*86400)+This:C1470.time
	This:C1470.dtEpoch:=((This:C1470.date-!1970-01-01!)*86400*1000)+This:C1470.time
	
Function setYear($year : Integer)
	This:C1470.date:=Add to date:C393(!00-00-00!; $year; This:C1470.month; This:C1470.day)
	
	// you can have internal functions only useable within the class
	// control access with getters and setters
	
Function setMonth($month : Integer)
	This:C1470.date:=Add to date:C393(!00-00-00!; This:C1470.year; $month; This:C1470.day)
	
Function setDay($day : Integer)
	This:C1470.date:=Add to date:C393(!00-00-00!; This:C1470.year; This:C1470.month; $day)
	
Function setDT90($date : Date; $time : Time)->$dt : Integer
	If ($date=!00-00-00!)
		$date:=This:C1470.date
	End if 
	If ($time=?00:00:00?)
		$time:=This:C1470.time
	End if 
	$dt:=($date-!1990-01-01!)*86400  //86400=24*60*60 date from 1990
	
Function setDJ($date : Date; $time : Time)->$dt : Integer
	If ($date=!00-00-00!)
		$date:=This:C1470.date
	End if 
	If ($time=?00:00:00?)
		$time:=This:C1470.time
	End if 
	// add GMT diff to this
	$dt:=($date-!1970-01-01!)*86400*1000  //86400=24*60*60 date from 1970
	
	// https://kb.4d.com/assetid=79140
	//#DECLARE($date : Date; $time : Time)->$result : Real
	
	//var $start_d : Date
	//var $current_t : Text
	//var $days_l : Integer
	
	//$start_d:=!1970-01-01!
	
	//If (Count parameters=0)
	//$current_t:=Timestamp
	//$current_t:=Substring($current_t; 1; Length($current_t)-5)
	//$date:=Date($current_t)
	//$time:=Time($current_t)
	//End if 
	
	//$days_l:=$date-$start_d
	//$result:=($days_l*86400)+($time+0)
	
Function setDP($date : Date; $time : Time)->$dt : Integer
	If ($date=!00-00-00!)
		$date:=This:C1470.date
	End if 
	If ($time=?00:00:00?)
		$time:=This:C1470.time
	End if 
	// add GMT diff to this
	$dt:=($date-!1970-01-01!)*86400  //86400=24*60*60 date from 1990
	
	//Case of 
	//: (Value type($date)=Is date)
	//This.date:=$date
	//: (Value type($date)=Is text)
	
	//Date_GoFigure
	//: ((Value type($date)=Is integer) | (Value type($date)=Is integer 64 bits))
	//If (True)
	//var $dateGet : Date
	//var $timeGet : Time
	//DateTime_DTFrom($date; ->$dateGet; ->$timeGet)
	//This.date:=$dateGet
	//This.time:=$timeGet
	//Else 
	//// this changes all DT time to Epoch
	//DateTimeDTEpoch("ToEpoch"; ->$currentDT; ->dtEpochCurrent)
	//End if 
	//End case 
	//: (Count parameters=2)
	//If ($date=!00-00-00!)
	//This.date:=Current date
	//Else 
	//This.date:=$date
	//End if 
	//End case 
	//*/
	//If ($time=?00:00:00?)
	//This.time:=Current time
	//End if 
	
	
	
	
	
	
	//MARK:-  get
	
Function getString($format : Text)->$return : Text
	If (Count parameters:C259=0)
		$return:=String:C10(This:C1470.date; System date long:K1:3)+" : "+Time string:C180(Time:C179(This:C1470.time))
	Else 
		$return:=String:C10(This:C1470.date; $format)+" : "+Time string:C180(Time:C179(This:C1470.time))
	End if 
	
	
Function getDateObject()->$dto : Object
	$dto:=New object:C1471("date"; This:C1470.date; "time"; This:C1470.time; "DT"; 0)
	
Function getTime()->$time : Time
	$time:=This:C1470.time
	
Function getTimeString($format : Text)->$time : Text
	$time:=This:C1470.time
	
Function getDate()->$date : Date
	$date:=This:C1470.date
	
Function getDateString()->$date : Text
	$date:=String:C10(This:C1470.date)
	
Function toString($format : Integer)->$return : Text
	If (Count parameters:C259=0)
		$format:=System date long:K1:3
	End if 
	If (This:C1470.time>0)
		// time is an integer
		$return:=String:C10(This:C1470.date; $format)+" : "+Time string:C180(Time:C179(This:C1470.time))
	Else 
		$return:=String:C10(This:C1470.date; $format)
	End if 
	// leaving a space returns the get function as an attribute
	// lowercase naming is a convention
	// not ()
Function getYear->$year : Integer
	$year:=Year of:C25(This:C1470.date)
	
Function getMonth->$month : Integer
	$month:=Month of:C24(This:C1470.date)
	
Function getDay->$day : Integer
	$day:=Day of:C23(This:C1470.date)
	
Function getCommentDateTime($comment : Text; $user : Text)->$dateTime : Text
	If ($user="")
		$user:=Current user:C182
	End if 
	If ($comment#"")
		$comment:=Char:C90(Carriage return:K15:38)+$comment
	End if 
	
	$dateTime:=String:C10(Current date:C33; System date short:K1:1)+\
		":_ "+String:C10(Current time:C178; System time short:K7:9)+":_ "+$user+":_ "+$comment
	
	
	
	//Date_ThisWeek
	//jDateTimeStamp
	//DateTime_DTFrom
	//jDateTimeRDate
Function getDateFromDT90($dt : Integer)->$date : Date
	If ($dt=0)  //0 is undefined
		$date:=!00-00-00!
	Else 
		$date:=!1990-01-01!+($1\86400)  //86400=24*60*60
	End if 
	
Function getTimeFromDT90($dt : Integer)->$date : Date
	If ($dt=0)  //0 is undefined
		$date:=!00-00-00!
	Else 
		$date:=!1990-01-01!+($1\86400)  //86400=24*60*60
	End if 
	
	//Function get epoch($date : Variant; $time : Time)->$epoch : Integer
	//var $doCalc : Boolean
	//$doCalc:=True
	//Case of 
	//: (Count parameters=0)
	//$date:=This.date
	//$time:=This.time
	//: (Count parameters=1)
	//: (Value type($date)=Is date)
	
	//: (Value type($date)=Is integer)
	//$epoch:=DateTimeDTEpoch(DateTime_DTTo(This.date; This.time))
	//DateTime_DTFrom
	//$doCalc:=False
	//End case 
	//If ($doCalc)
	//$epoch:=$date-!1970-01-01!*86400*1000
	//End if 
	
	//jDateTimeRBoth
	
	//jDateTimeUserCl
	//jDayName
	//jDaysWork
	
	//Date_24Months
	//Date_AddPeriod
	//Date_Century
	//Date_CvrtYyMmDd
	//DatedateMMYY
	//Date_ExportToString
	//Date_FromObject
	
	//Date_GetMonthFullName
Function getMonthNameFull($date : Date)->$monthName : Text
	var $monthNum; $index : Integer
	var $c : Collection
	var $string : Text
	$monthNum:=Month of:C24(Current date:C33)
	$string:="January,February,March,April,May,June,July,August,September,October,November,December"
	$c:=Split string:C1554($string; ";")
	$monthName:=$c[$monthNum-1]
	
	//Date_GetMonthShortName
Function getMonthNameShort($date : Date)->$monthName : Text
	var $monthNum; $index : Integer
	var $c : Collection
	var $string : Text
	$monthNum:=Month of:C24(Current date:C33)
	$string:="Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec"
	$c:=Split string:C1554($string; ";")
	$monthName:=$c[$monthNum-1]
	
Function getMonthEnd($date : Date)->$endDate : Date
	var $workDate : cs:C1710.cDateTime
	$workDate:=cs:C1710.cDateTime.new($date).addMonth(1)
	$endDate:=$workDate.addDay(-1)
	
	//Date_GetPeriodBeginDates
Function getPeriodObject($name : Text; $dateBeg : Date; $dateEnd : Date)->$period : Object
	var $length : Integer
	Case of 
		: ($name="week")
			$length:=7
		: ($name="")
			$name:="month"
			$length:=30
		: ($name="month")
			$length:=30
		: ($name="quarter")
			$length:=90
		: ($name="year")
			$length:=365
		Else 
			$length:=Num:C11($name)
			If ($length=0)
				$length:=30
				$name:="month"
			End if 
	End case 
	
	//If (($length<1) | ($length<10000))
	//$length:=30
	//end if
	var $doEnd : Boolean
	Case of 
		: (($dateBeg=!00-00-00!) & ($dateEnd=!00-00-00!))
			If (This:C1470.date#!00-00-00!)
				$dateBeg:=This:C1470.date-Day of:C23(This:C1470.date)+1
			Else 
				$dateBeg:=Current date:C33-Day of:C23(Current date:C33)+1
			End if 
			$doEnd:=True:C214
		: ($dateBeg#!00-00-00!)
			$dateEnd:=$dateBeg+$length
			$doEnd:=True:C214
		Else 
			$dateBeg:=$dateEnd-$length
			If (($name="month") | ($name="quarter") | ($name="year"))
				$dateBeg:=$dateBeg+5
				$dateBeg:=$dateBeg-Day of:C23($dateEnd)+1
			End if 
	End case 
	
	If (($name="month") | ($name="quarter") | ($name="year"))
		$dateEnd:=$dateEnd+5
		$dateEnd:=$dateEnd-Day of:C23($dateEnd)-1
	End if 
	
	$period:=New object:C1471("name"; $name; "begin"; $dateBeg; "end"; $dateEnd; "length"; 0)
	//Date_GetWoDName
	//Date_GoFigure
	//Date_iCal2RFC
	//Date_ImportFromString
	//Date_RFC2iCal
	//Date_ServiceRec
	//Date_Set
	//Date_SetProc
	//Date_StrMMddYY
	//Date_StrMMYY
	//Date_strYrMmDd
	//Date_StrYYYY MM DDTHH MM SS
	//Date_strYyyymmdd
	//Date_ThisMon
	//Date_ThisQtr
	//Date_ThisWeek
	//Date_ThisYear
	//Date_UnStringify
	//Date_YrCent
	//Date_yyyy_mm_dd_hh_mm
	//DateBeginDateEnd
	//DateFromString
	//DateTime
	//DateTime_DTTo
	//DateTime_Gantt
	//DateTime_RFCString
	//DateTimeDTEpoch
	//DateTimeEpoch
	//DateTimeofDT
	//DaysPastDue
	
	//DT_ExportStr
	//DT_ExportToString
	//DT_ImportFromDateAndTime
	//DT_ImportFromString
	//DT_ParseImport
	
	
	
Function getDTjava($date : Date; $time : Time)
	Case of 
		: (Count parameters:C259=0)
			
	End case 
	
Function getDTjs($date : Date; $time : Time)
	Case of 
		: (Count parameters:C259=0)
			
			
	End case 
	
	
	//MARK:-  calc
	
Function isAfter($dateTime : cs:C1710.cDateTime)->$result : Boolean
	$result:=(This:C1470.date>$dateTime.date) | ((This:C1470.date=$dateTime.date) & (This:C1470.time>$dateTime.time))
	
Function isBefore($dateTime : cs:C1710.cDateTime)->$result : Boolean
	$result:=Not:C34(This:C1470.isAfter($dateTime))
	
Function isEqual($dateTime : cs:C1710.cDateTime)->$result : Boolean
	$result:=(This:C1470.date=$dateTime.date) & (This:C1470.time=$dateTime.time)
	
Function clear
	This:C1470.date:=!00-00-00!
	This:C1470.time:=?00:00:00?
	
Function addToDate($years : Integer; $months : Integer; $days : Integer)
	This:C1470.date:=Add to date:C393(This:C1470.date; $years; $months; $days)
	
	
Function addDay($number : Integer)
	If (Count parameters:C259=0)
		This:C1470.addToDate(0; 0; 1)
	Else 
		This:C1470.addToDate(0; 0; $number)
	End if 
	
Function addMonth($number : Integer)
	If (Count parameters:C259=0)
		This:C1470.addToDate(0; 1; 0)
	Else 
		This:C1470.addToDate(0; $number; 0)
	End if 
	
Function addYear($number : Integer)
	If (Count parameters:C259=0)
		This:C1470.addToDate(1; 0; 0)
	Else 
		This:C1470.addToDate($number; 0; 0)
	End if 
	
Function endOfMonth($date : Date)->$endOfMonth : Date
	If (Count parameters:C259=0)
		$date:=This:C1470.date
	End if 
	