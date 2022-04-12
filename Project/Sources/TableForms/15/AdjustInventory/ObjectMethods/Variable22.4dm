TRACE:C157
C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aItemLines)
If ($k>0)
	For ($i; 1; $k)
		aLsQtySO{aItemLines{$i}}:=vr2
		aLsQtyPO{aItemLines{$i}}:=aLsQtyOH{aItemLines{$i}}+vr2
		vr3:=aLsQtyPO{aItemLines{$i}}
		aLsReason{aItemLines{$i}}:=v3
	End for 
	doSearch:=10
	vMod:=True:C214
End if 