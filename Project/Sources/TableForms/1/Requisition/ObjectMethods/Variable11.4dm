C_LONGINT:C283($k; $i)
$k:=Size of array:C274(aRqRecNum)
If ($k>0)
	CREATE EMPTY SET:C140([Requisition:83]; "Current")
	For ($i; 1; $k)
		If (aRqRecNum{$i}>-1)
			GOTO RECORD:C242([Requisition:83]; aRqRecNum{$i})
			ADD TO SET:C119([Requisition:83]; "Current")
		End if 
	End for 
	USE SET:C118("Current")
	CLEAR SET:C117("Current")
Else 
	BEEP:C151
	BEEP:C151
End if 


