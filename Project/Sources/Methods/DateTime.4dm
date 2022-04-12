//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-09-11T00:00:00, 08:46:25
// ----------------------------------------------------
// Method: DateTime
// Description
// Modified: 09/11/14
// Structure: CEv13_131005
// 
//  ISO date yyyy-mm-ddThh:mm:ss
//  jim's date code yyyymmdd_hhmm
//  date spinners yyyy-mm-dd
// Parameters
// ----------------------------------------------------
// ### jwm ### 20140926_1259 updated date format yyyymmdd_hhmm


C_LONGINT:C283($theYear; $theMonth; $theDay; $theTime; $countparameters)
C_TEXT:C284($0; $1; $action)
$countparameters:=Count parameters:C259
Case of 
	: ($countparameters=0)  // spinners
		$0:=String:C10(Year of:C25(Current date:C33); "0000")+"-"+String:C10(Month of:C24(Current date:C33); "00")+"-"+String:C10(Day of:C23(Current date:C33); "00")
		
	: ($1="mmddyyyy hhmm AM")
		$0:=String:C10(Current date:C33; Internal date short:K1:7)+",  "+String:C10(Current time:C178; HH MM AM PM:K7:5)
		
	: ($1="yyyymmdd")
		$0:=String:C10(Year of:C25(Current date:C33); "0000")+String:C10(Month of:C24(Current date:C33); "00")+String:C10(Day of:C23(Current date:C33); "00")  // ### jwm ### 20140926_1259 finished
		
	: ($1="yyyymmdd_hhmm")
		$0:=String:C10(Year of:C25(Current date:C33); "0000")+String:C10(Month of:C24(Current date:C33); "00")+String:C10(Day of:C23(Current date:C33); "00")+"_"+Replace string:C233(String:C10(Current time:C178; HH MM:K7:2); ":"; "")  // ### jwm ### 20140926_1259 finished
		
	: ($1="yyyymmdd_hhmmss")
		$0:=String:C10(Year of:C25(Current date:C33); "0000")+String:C10(Month of:C24(Current date:C33); "00")+String:C10(Day of:C23(Current date:C33); "00")+"_"+Replace string:C233(String:C10(Current time:C178; HH MM SS:K7:1); ":"; "")  // ### jwm ### 20140926_1259 finished
		
	: ($1="ISO")
		//$0:=String(Year of(Current date);"0000")+"-"+String(Month of(Current date);"00")+"-"+String(Day of(Current date);"00")+"T"+String(Current time)
		$0:=String:C10(Current date:C33; ISO date:K1:8; Current time:C178)
		
	: ($1="GMT")
		$0:=String:C10(Current date:C33; ISO date GMT:K1:10; Current time:C178)
		
	Else 
		// spinners
		$0:=String:C10(Year of:C25(Current date:C33); "0000")+"-"+String:C10(Month of:C24(Current date:C33); "00")+"-"+String:C10(Day of:C23(Current date:C33); "00")
End case 