C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aItemLines)
If ($k>0)
	For ($i; 1; $k)
		aLsCost{aItemLines{$i}}:=vr4
	End for 
	doSearch:=10
End if 