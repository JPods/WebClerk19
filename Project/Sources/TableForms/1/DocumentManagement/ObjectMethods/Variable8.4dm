C_LONGINT:C283($i; $k; $err; $noStyle)
$k:=Size of array:C274(aRayLines)
CREATE EMPTY SET:C140([Document:100]; "Current")
For ($i; 1; $k)
	$recID:=Num:C11(aHtvLink{aRayLines{$i}})
	If ($recID>9)
		QUERY:C277([Document:100]; [Document:100]idNum:1=$recID)
		If (Records in selection:C76([Document:100])>0)
			ADD TO SET:C119([Document:100]; "Current")
		End if 
	End if 
End for 
If (Records in set:C195("Current")>0)
	USE SET:C118("Current")
	ProcessTableOpen(Table:C252(->[Document:100]))
End if 
CLEAR SET:C117("Current")
