// zzzqqq PopUpWildCard(->vNameID; -><>aNameID; ->[Employee:19])
$k:=Size of array:C274(aWDItemLine)
If ($k>0)
	C_LONGINT:C283($i; $k)
	For ($i; 1; $k)
		aWdNameID{aWDItemLine{$i}}:=vNameID
	End for 
End if 
doSearch:=55