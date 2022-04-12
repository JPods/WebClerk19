//%attributes = {}

// Modified by: Bill James (2021-12-04T06:00:00Z)
// Method: CE_ThreadPool
// Description 
// Parameters
// ----------------------------------------------------
var $1 : Object

C_COLLECTION:C1488(<>CE_Threads_c)
If (Storage:C1525.ce.count=Null:C1517)
	If (Storage:C1525.ce=Null:C1517)
		Use (Storage:C1525)
			Storage:C1525.ce:=New shared object:C1526
			Use (Storage:C1525.ce)
				If (Storage:C1525.ce.count=Null:C1517)
					Storage:C1525.ce.count:=New shared object:C1526
				End if 
				Use (Storage:C1525.ce.count)
					Storage:C1525.ce.count:=15
				End use 
			End use 
		End use 
	End if 
End if 

If (Size of array:C274(<>aCEThreadProcess)=0)
	var $start_o : Object
	For ($inc; 1; Storage:C1525.ce.count)
		$start_o:=New object:C1471("method"; "Start")
		CALL WORKER:C1389("worker-"+String:C10($inc); "CE_WorkerWake")
	End for 
End if 
