//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/03/09, 00:07:58
// ----------------------------------------------------
// Method: Method: Execute_Report
// Description
// 
//
// Parameters
// ----------------------------------------------------
#DECLARE($name : Text)
var $sel_o; $rec_o : Object
$sel_o:=ds:C1482.Report.query("name = :1"; $name)
Case of 
	: ($name="")
		ConsoleLog("No Report name provided")
	: ($sel_o.length=0)
		ConsoleLog("No Report name = "+$name)
	Else 
		If ($sel_o.length>1)
			ConsoleLog("Multiple Report name = "+$name)
		End if 
		ExecuteText(0; $sel_o[0].scriptBegin)
End case 