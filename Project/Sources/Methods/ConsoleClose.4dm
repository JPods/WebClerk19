//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-02-27T00:00:00, 23:12:14
// ----------------------------------------------------
// Method: ConsoleClose
// Description
// Modified: 02/27/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($found)

$found:=Prs_CheckRunnin("Console")
If ($found>0)
	<>vConsoleMessage:="ConsoleClose"
	POST OUTSIDE CALL:C329($found)  //<>theProcessList)
End if 

