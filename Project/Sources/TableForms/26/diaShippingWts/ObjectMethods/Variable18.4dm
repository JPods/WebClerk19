If (v1#"")  // Modified by: williamjames (111216 checked for <= length protection)
	If (v1[[1]]="{")
		v1:=Substring:C12(v1; 2)
	End if 
End if 
$k:=Size of array:C274(aShipSel)
For ($i; 1; $k)
	atrackID{aShipSel{$i}}:=v1
End for 
doSearch:=6