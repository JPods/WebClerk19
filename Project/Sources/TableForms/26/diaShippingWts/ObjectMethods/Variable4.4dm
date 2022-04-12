If (Size of array:C274(aShipSel)>0)
	If (Size of array:C274(atrackID)>=aShipSel{1})
		Ship_FillArray(-1; aShipSel{1}; 1)
	End if 
End if 
GOTO OBJECT:C206(vi1)
If (Size of array:C274(atrackID)>0)
	ARRAY LONGINT:C221(aShipSel; 1)
	Case of 
		: (aShipSel{1}>Size of array:C274(atrackID))
			aShipSel{1}:=Size of array:C274(atrackID)
		: (aShipSel{1}=1)
			//no change
		Else 
			aShipSel{1}:=aShipSel{1}-1
	End case 
	doSearch:=2
Else 
	ARRAY LONGINT:C221(aShipSel; 0)
	doSearch:=1
End if 