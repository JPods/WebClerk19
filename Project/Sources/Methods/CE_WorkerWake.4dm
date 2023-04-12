//%attributes = {}

// Modified by: Bill James (2021-12-05T06:00:00Z)
// Method: CE_WorkerWake
// Description 
// Parameters
// ----------------------------------------------------
var $1; process_o : Object
process_o:=$1
Case of 
	: (process_o.method="Start")
		APPEND TO ARRAY:C911(<>aCEThreadProcess; Current process:C322)
		APPEND TO ARRAY:C911(<>aCEThreadAvailable; False:C215)
		APPEND TO ARRAY:C911(<>aCEThreadName; String:C10(Current process:C322)+"-pending")
		Process_InitLocal
		
	: (process_o.method="Start")
		$index:=Find in array:C230(<>aCEThreadProcess; Current process:C322)
		<>aCEThreadAvailable{$index}:=False:C215
		<>aCEThreadName{$index}:=String:C10(<>aCEThreadProcess{$index})+" - pending"
		If (procerss_o.method=Null:C1517)
			EXECUTE FORMULA:C63("ProcessObject")
		Else 
			EXECUTE FORMULA:C63(procerss_o.method)
		End if 
		
		POST OUTSIDE CALL:C329(Storage:C1525.process.processList)
		
End case 

