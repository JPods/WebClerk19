CREATE SET:C116([Item:4]; "MfgItems")
QUERY:C277([Item:4]; [Item:4]itemNum:1=vPartNum)
If (Records in selection:C76([Item:4])=0)
	If (vPartNum#"")
		CREATE RECORD:C68([Item:4])
		[Item:4]itemNum:1:=vPartNum
		[Item:4]location:9:=[Customer:2]mfrLocationid:67
		[Item:4]mfrID:53:=[Customer:2]customerID:1
		[Item:4]priceA:2:=1
		[Item:4]priceB:3:=1
		[Item:4]priceC:4:=1
		[Item:4]priceD:5:=1
		[Item:4]description:7:="Commissions for "+[Customer:2]company:2
		[Item:4]unitOfMeasure:11:="ea"
		[Item:4]qtyOnHand:14:=10000000
		[Item:4]type:26:="Comm"
		[Item:4]profile1:35:="Comm"
		[Item:4]mfrItemNum:39:=[Customer:2]customerID:1
		[Item:4]dtItemDate:33:=DateTime_DTTo
		[Item:4]commissionA:29:=100
		[Item:4]commissionB:30:=100
		[Item:4]commissionC:31:=100
		[Item:4]commissionD:32:=100
		[Item:4]discountable:28:=True:C214
		[Item:4]taxID:17:=""
		READ ONLY:C145([DefaultAccount:32])
		GOTO RECORD:C242([DefaultAccount:32]; 0)
		[Item:4]salesGlAccount:21:=[DefaultAccount:32]itemSalesAcct:24
		[Item:4]costGLAccount:22:=[DefaultAccount:32]itemCostofGoods:25
		[Item:4]inventoryGlAccount:23:=[DefaultAccount:32]itemInventory:26
		UNLOAD RECORD:C212([DefaultAccount:32])
		READ WRITE:C146([DefaultAccount:32])
		CREATE RECORD:C68([ItemSpec:31])
		
		[ItemSpec:31]itemNum:1:=[Item:4]itemNum:1
		SAVE RECORD:C53([ItemSpec:31])
		SAVE RECORD:C53([Item:4])
		ONE RECORD SELECT:C189([Item:4])
		MODIFY RECORD:C57([Item:4])
	Else 
		BEEP:C151
		BEEP:C151
		ALERT:C41("Define Item Number.")
	End if 
	//  ADD RECORD([Item])
Else 
	MODIFY RECORD:C57([Item:4])
End if 
ADD TO SET:C119([Item:4]; "MfgItems")
USE SET:C118("MfgItems")
CLEAR SET:C117("MfgItems")