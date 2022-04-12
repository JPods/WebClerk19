jPopUpArray(Self:C308; ->vNameID)
$k:=Size of array:C274(aWDItemLine)
If (($k>0) & (<>aNameID>1))
	C_LONGINT:C283($i; $k)
	For ($i; 1; $k)
		aWdNameID{aWDItemLine{$i}}:=<>aNameID{<>aNameID}
	End for 
End if 
doSearch:=55