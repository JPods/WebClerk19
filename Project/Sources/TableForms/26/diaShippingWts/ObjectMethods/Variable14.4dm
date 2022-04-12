TRACE:C157
Case of 
	: (Size of array:C274(aShipSel)=0)
		Ship_FillArray(-3; Size of array:C274(atrackID)+1; 1)
	: (aLongInt1{aShipSel}#0)
		Ship_FillArray(-3; Size of array:C274(atrackID)+1; 1)
		//SET ENTERABLE(vi1;True)
		//SET ENTERABLE(vR1;True)
		//SET ENTERABLE(vR2;True)
		//SET ENTERABLE(vi3;True)
		//SET ENTERABLE(v1;True)
	Else 
		GOTO OBJECT:C206(vi1)
End case 
doSearch:=6