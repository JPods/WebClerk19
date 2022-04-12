// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/05/09, 11:39:12
// ----------------------------------------------------
// Method: Object Method: b61
// Description
// 
//
// Parameters
// ----------------------------------------------------

If ([Order:3]idNumTask:85=0)
	TaskIDAssign(->[Order:3]idNumTask:85)
	acceptOrders
	C_LONGINT:C283($incRay; $cntRay)
	$cntRay:=Size of array:C274(aQaAnswrRec)
	For ($index; 1; $cntRay)
		GOTO RECORD:C242([QA:70]; aQaAnswrRec{$index})
		[QA:70]idNumTask:12:=[Order:3]idNumTask:85
		SAVE RECORD:C53([QA:70])
		aQataskID{$index}:=[Order:3]idNumTask:85
	End for 
	If (eAnsListOrders>0)
		//  --  CHOPPED  AL_UpdateArrays(eAnsListOrders; -2)
	End if 
	ALERT:C41("Complete")
End if 

