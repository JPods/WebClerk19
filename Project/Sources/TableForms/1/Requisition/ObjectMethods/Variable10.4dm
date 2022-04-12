C_LONGINT:C283($k; $i)
$k:=Size of array:C274(aReqSelLns)
If ($k>0)
	For ($i; $k; 1; -1)
		Rq_FillArrays(-1; aReqSelLns{$i}; 1)
	End for 
	//  --  CHOPPED  AL_UpdateArrays(eActiveReqs; -2)
Else 
	BEEP:C151
	BEEP:C151
End if 