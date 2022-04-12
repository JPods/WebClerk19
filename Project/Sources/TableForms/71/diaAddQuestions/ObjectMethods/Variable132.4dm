$k:=Size of array:C274(aQQuestKey)
If ($k>0)
	C_LONGINT:C283($i; $k)
	
	ARRAY LONGINT:C221(aQQLns; $k)
	For ($i; 1; $k)
		aQQLns{$i}:=$i
	End for 
	myOK:=2
	CANCEL:C270
End if 