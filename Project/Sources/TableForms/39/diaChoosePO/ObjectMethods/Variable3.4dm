If (Before:C29)
	b1:=1
	b2:=0
	b3:=0
	vOrdNum:=0
	myOK:=0
	ARRAY TEXT:C222(aText1; 4)
	aText1{1}:="Select Quantity"
	aText1{2}:="Zero Quantity"
	aText1{3}:="Order Quantity"
	aText1{4}:="Backlog Quantity"
	If (<>vOrder2POByBLQ>0)
		aText1:=<>vOrder2POByBLQ+1
	Else 
		aText1:=3
	End if 
End if 