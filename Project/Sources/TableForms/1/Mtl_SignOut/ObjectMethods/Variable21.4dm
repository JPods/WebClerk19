$k:=Size of array:C274(aWDItemLine)
If ($k>0)
	C_LONGINT:C283($i; $k)
	For ($i; 1; $k)
		aWdQty{aWDItemLine{$i}}:=vR1
	End for 
	doSearch:=18
End if 