//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-22T00:00:00, 08:49:37
// ----------------------------------------------------
// Method: Console_Log
// Description
// Modified: 12/22/15
// Structure: CEv13_131005
// 
//
// Parameters: $1 = message; $2 = direction
// ----------------------------------------------------
C_TEXT:C284($1; $message)
C_LONGINT:C283($found)


If (Application type:C494#4D Server:K5:6)  // ### jwm ### 20190227_1732
	$found:=Prs_CheckRunnin("Console")
	$message:=$1
	If ($found<1)
		ARRAY TEXT:C222(<>aMessage; 0)
		ConsoleLaunch
		var $cnt : Integer
		$cnt:=0
		Repeat 
			$found:=Prs_CheckRunnin("Console")
			DELAY PROCESS:C323(Current process:C322; 6)
		Until (($found>1) | ($cnt>5))
	End if 
	If ($found>0)
		APPEND TO ARRAY:C911(<>aMessage; $message)
		CALL WORKER:C1389("Console"; "ConsolePost"; $message)
		
		POST OUTSIDE CALL:C329($found)
	End if 
End if 