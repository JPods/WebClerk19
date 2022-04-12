$k:=Size of array:C274(aWDItemLine)
If ($k>0)
	C_LONGINT:C283($i; $k)
	For ($i; 1; $k)
		aWdSo{aWDItemLine{$i}}:=vi2
	End for 
End if 
doSearch:=55