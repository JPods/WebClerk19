TRACE:C157
C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aWsRecNum)
If ($k>0)
	ARRAY LONGINT:C221(aWoStepLns; $k)
	For ($i; 1; $k)
		aWoStepLns{$i}:=$i
	End for 
	doSearch:=-3
Else 
	ALERT:C41("There must be lines to select.")
End if 