C_LONGINT:C283($k; $i)
$k:=Size of array:C274(aRqRecNum)
If ($k>0)
	For ($i; $k; 1; -1)
		$w:=Find in array:C230(aReqSelLns; $i)
		If ($w>0)
			Rq_FillArrays(-1; $i; 1)
		End if 
	End for 
	//  --  CHOPPED  AL_UpdateArrays(eActiveReqs; -2)
Else 
	BEEP:C151
	BEEP:C151
End if 
