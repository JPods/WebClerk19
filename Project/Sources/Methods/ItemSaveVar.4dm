//%attributes = {"publishedWeb":true}
If (UserInPassWordGroup("AdminControl"))
	If (aPartBom{aCrtRecs}=[Item:4]itemNum:1)
		[Item:4]priceA:2:=vR1
		[Item:4]priceB:3:=vR2
		[Item:4]priceC:4:=vR3
		[Item:4]priceD:5:=vR4
		[Item:4]qtySaleDefault:15:=vR5
		[Item:4]qtyMinStock:18:=vR6
		[Item:4]reOrdQty:27:=vR7
		[Item:4]qtyOnHand:14:=vR8
		[Item:4]qtyOnSalesOrder:16:=vR9
		[Item:4]qtyOnPo:20:=vR10
		[Item:4]weightAverage:8:=vR11
		[Item:4]leadTimeSales:12:=vL1
		[Item:4]location:9:=vL2
		SAVE RECORD:C53([Item:4])
	End if 
End if 