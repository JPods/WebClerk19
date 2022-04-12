jPopUpArray(Self:C308; ->v3)
TRACE:C157
$k:=Size of array:C274(aItemLines)
If ($k>0)
	C_LONGINT:C283($i; $k)
	For ($i; 1; $k)
		aLsReason{aItemLines{$i}}:=v3
	End for 
	doSearch:=10
End if 