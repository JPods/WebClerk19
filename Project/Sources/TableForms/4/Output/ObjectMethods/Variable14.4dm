Case of 
	: (aLooLoProcedures<2)
		aLooLoProcedures:=1
		
	: (aLooLoProcedures=2)  //BarCode39
		BarC_MultiLabel(->[Item:4]; ->[Item:4]qtyOnHand:14)
	: (aLooLoProcedures=3)  //BOM_Top Levels
		BOM_TopLevel
	: (aLooLoProcedures=4)  //LifoFifo_Value
		Troy_ValueLifoF
	: (aLooLoProcedures=5)  //Mark_XRef
		
		vi2:=Records in selection:C76([Item:4])
		FIRST RECORD:C50([Item:4])
		For (vi1; 1; vi2)
			QUERY:C277([ItemXRef:22]; [ItemXRef:22]ItemNumMaster:1=[Item:4]itemNum:1)
			NEXT RECORD:C51([Item:4])
		End for 
		ProcessTableOpen(Table:C252(->[ItemXRef:22]); ""; "XRef for Item selection")
		
	: (aLooLoProcedures=6)  //Repeat_PriceQty
		//KeyModifierCurrent 
		//If (OptKey=0)
		//ForestsImport 
		//Else 
		
		//End if 
	: (aLooLoProcedures=7)  //XRefLoadByClass
		XRefLoadByClass("")
End case 
aLooLoProcedures:=1

//IE_ItemDiscounts 