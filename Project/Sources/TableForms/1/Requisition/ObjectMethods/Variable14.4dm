C_LONGINT:C283($k; $i)
$k:=Size of array:C274(aReqSelLns)
If ($k>0)
	For ($i; 1; $k)
		Rq_FillArrays(-4; aReqSelLns{$i}; 1)
	End for 
	//  --  CHOPPED  AL_UpdateArrays(eActiveReqs; -2)
Else 
	BEEP:C151
	BEEP:C151
End if 

