//%attributes = {"publishedWeb":true}
//Procedure: 
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 04/21/19, 10:12:46
// ----------------------------------------------------
// Method: Date_strYyyymmdd
// Description
// 
//
// Parameters
// ----------------------------------------------------


If (False:C215)
	//Date: 03/01/02
	//Who: Peter Fleming, Arkware
	//Description: Function - pass a date - returns string in yyyymmdd format
	VERSION_960
End if 
C_TEXT:C284($0)
C_DATE:C307($1; $theDate)
$theDate:=Current date:C33
If (Count parameters:C259=1)
	$theDate:=$1
End if 
$0:=String:C10(Year of:C25($theDate); "0000")+"-"+String:C10(Month of:C24($theDate); "00")+"-"+String:C10(Day of:C23($theDate); "00")