//%attributes = {}

// Modified by: Bill James (2021-12-04T06:00:00Z)
// Method: CE_WorkerInit
// Description 
// Parameters
// ----------------------------------------------------
var procerss_o : Object
Process_InitLocal
While (<>vbWCstop=False:C215)
	procerss_o:=New object:C1471
	PAUSE PROCESS:C319(Current process:C322)  // go to sleep until called
	
	$index:=Find in array:C230(<>aCEThreadProcess; Current process:C322)
	If (<>aCEThreadOb{$index}#Null:C1517)
		procerss_o:=<>aCEThreadOb{$index}
		If (procerss_o.method=Null:C1517)
			EXECUTE FORMULA:C63("ProcessObject")
		Else 
			EXECUTE FORMULA:C63(procerss_o.method)
		End if 
		<>aCEThreadAvailable{$index}:=True:C214
		<>aCEThreadName{$index}:=String:C10(<>aCEThreadProcess{$index})+" - pending"
		POST OUTSIDE CALL:C329(Storage:C1525.process.processList)
	End if 
End while 