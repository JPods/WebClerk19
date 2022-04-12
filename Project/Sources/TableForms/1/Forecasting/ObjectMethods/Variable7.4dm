If (Size of array:C274(aFCSelect)>0)
	If (aFCSelect{1}<=Size of array:C274(aFCRecNum))
		QUERY:C277([Item:4]; [Item:4]itemNum:1=aFCItem{aFCSelect{1}})
		If (Records in selection:C76([Item:4])>0)
			vR1:=[Item:4]priceA:2
			vR2:=[Item:4]priceB:3
			vR3:=[Item:4]priceC:4
			vR4:=[Item:4]priceD:5
			vR5:=[Item:4]qtySaleDefault:15
			vR6:=[Item:4]qtyMinStock:18
			vR7:=[Item:4]reOrdQty:27
			vR8:=[Item:4]qtyOnHand:14
			vR9:=[Item:4]qtyOnSalesOrder:16
			vR10:=[Item:4]qtyOnPo:20
			vR11:=[Item:4]costAverage:13
			vL1:=[Item:4]leadTimeSales:12
			vL2:=[Item:4]location:9
			//    MODIFY RECORD([Item])
			//    jSetReturnCntrl ("Forcasting"+" - "+Current user)
			//    doSearch:=1
		End if 
	End if 
End if 