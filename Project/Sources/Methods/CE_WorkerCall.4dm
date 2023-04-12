//%attributes = {}

// Modified by: Bill James (2021-12-04T06:00:00Z)
// Method: CE_WorkerCall
// Description 
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($index)
var $1 : Object
var $index : Integer
var $pass_o : Object
If (Count parameters:C259=0)
	$pass_o:=New object:C1471("tableName"; "testing")
Else 
	$pass_o:=$1
End if 

$index:=Find in array:C230(<>aCEThreadAvailable; True:C214)
If ($index>0)
	<>aCEThreadOb{$index}:=$pass_o
	<>aCEThreadAvailable{$index}:=False:C215
	<>aCEThreadName{$index}:=String:C10(<>aCEThreadProcess{$index})+" - "+$pass_o.tableName
	$index_process:=Find in array:C230(<>aPrsNum; <>aCEThreadProcess{$index})
	<>aPrsName{$index_process}:=<>aCEThreadName{$index}
	POST OUTSIDE CALL:C329(Storage:C1525.process.processList)
	DELAY PROCESS:C323(Current process:C322; 10)
	//SET PROCESS VARIABLE(<>aCEThreadProcess{$index}; process_o; $1)
	POST OUTSIDE CALL:C329(<>aCEThreadProcess{$index})
	CALL WORKER:C1389(<>aCEThreadProcess{$index}; "ProcessObject"; $pass_o)
Else 
	ALERT:C41("Out of workers: "+String:C10(<>CE_Threads_c.length))
End if 

If (False:C215)
	$index:=<>CE_Threads_c.indexOf("available = true")
	If ($index>0)
		RESUME PROCESS:C320(<>ThreadPool_ThreadID{$index})
		<>CE_Threads_c[$index].available:=False:C215
		
		If ($1.method=Null:C1517)
			EXECUTE FORMULA:C63("ProcessObject")
		Else 
			EXECUTE FORMULA:C63($1.method)
		End if 
		<>CE_Threads_c[$index].available:=True:C214
		
	Else 
		ALERT:C41("Out of workers: "+String:C10(<>CE_Threads_c.length))
	End if 
End if 