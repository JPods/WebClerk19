READ ONLY:C145([Item:4])
vi2:=Records in selection:C76([PO:39])
FIRST RECORD:C50([PO:39])
For (vi1; 1; vi2)
	If (Locked:C147([PO:39]))
		ALERT:C41("PO "+String:C10([PO:39]poNum:5)+" is locked.")
	Else 
		QUERY:C277([QQQPOLine:40]; [QQQPOLine:40]poNum:1=[PO:39]poNum:5)
		PoLnFillRays(Records in selection:C76([QQQPOLine:40]))
		vi4:=Size of array:C274(aPOUnitCost)
		For (vi3; 1; vi4)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=aPoItemNum{vi3})
			If (<>Order2POCost210=2)  //
				pUnitPrice:=[Item:4]costLastInShip:47
			Else   // (<>Order2POCost210=1)
				pUnitPrice:=[Item:4]costAverage:13
			End if 
			aPoUnitCost{vi3}:=pUnitPrice
			aPOLineAction:=vi3
			PoLnExtend(aPOLineAction)
		End for 
		booAccept:=True:C214
		acceptPO
	End if 
End for 
UNLOAD RECORD:C212([Item:4])
READ WRITE:C146([Item:4])




If (False:C215)
	C_TEXT:C284($myText)
	$myText:=WccQuery3BuildSignIn(->[PO:39]; ->[QQQVendor:38]; 1)
	
End if 