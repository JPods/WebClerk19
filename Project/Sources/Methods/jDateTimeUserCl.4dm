//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/02/11, 12:07:38
// ----------------------------------------------------
// Method: jDateTimeUserCl
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1)
If (Count parameters:C259=1)
	vDiaCom:=$1
Else 
	vDiaCom:="Date/Time Stamp Calculator"
End if 
jCenterWindow(320; 200)
DIALOG:C40([Admin:1]; "diaDateTimeCalc")
CLOSE WINDOW:C154

//MenuBarByLevel 