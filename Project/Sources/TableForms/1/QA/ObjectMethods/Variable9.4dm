$k:=Size of array:C274(aQaAnswrLns)
If ($k>0)
	SORT ARRAY:C229(aQaAnswrLns)
	C_LONGINT:C283($k; $i)
	For ($i; $k; 1; -1)
		//  CHOPPED QA_FillAnswRay(-1; aQaAnswrLns{$i}; 1)
	End for 
	ARRAY LONGINT:C221(aQaAnswrLns; 0)
	doSearch:=6
Else 
	BEEP:C151
	BEEP:C151
End if 