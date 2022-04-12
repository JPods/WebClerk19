If (<>vbQtyAvailable)
	//iLoText1:="Avail"
	If (OptKey=0)
		iLoReal1:=[Item:4]qtyAvailable:73
	Else 
		iLoReal1:=[Item:4]qtyOnHand:14
	End if 
Else 
	//iLoText1:="O/H"
	iLoReal1:=[Item:4]qtyOnHand:14
	If (OptKey=1)
		iLoReal1:=[Item:4]qtyAvailable:73
	Else 
		iLoReal1:=[Item:4]qtyOnHand:14
	End if 
End if 