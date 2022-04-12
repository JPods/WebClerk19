If ([Invoice:26]idNumTask:78=0)
	TaskIDAssign(->[Invoice:26]idNumTask:78)
	acceptInvoice
	C_LONGINT:C283($incRay; $cntRay)
	$cntRay:=Size of array:C274(aQaAnswrRec)
	For ($index; 1; $cntRay)
		GOTO RECORD:C242([QA:70]; aQaAnswrRec{$index})
		[QA:70]idNumTask:12:=[Invoice:26]idNumTask:78
		SAVE RECORD:C53([QA:70])
		aQataskID{$index}:=[Invoice:26]idNumTask:78
	End for 
	If (eAnsListInvoices>0)
		//  --  CHOPPED  AL_UpdateArrays(eAnsListInvoices; -2)
	End if 
	ALERT:C41("Complete")
End if 
