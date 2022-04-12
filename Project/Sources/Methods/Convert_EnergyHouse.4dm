//%attributes = {}
If (False:C215)
	Convert_EnergyHouse
	Version_0602
	
	
End if 




allowAlerts_boo:=False:C215
ALL RECORDS:C47([Order:3])
vi2:=Records in selection:C76([Order:3])
FIRST RECORD:C50([Order:3])
For (vi1; 1; vi2)
	NxPvOrders
	booAccept:=True:C214
	vMod:=True:C214
	acceptOrders
	NEXT RECORD:C51([Order:3])
End for 
allowAlerts_boo:=True:C214




If (False:C215)
	READ WRITE:C146([OrderLine:49])
	ALL RECORDS:C47([OrderLine:49])
	//QUERY([POLine];[POLine]Complete="")
	vi2:=Records in selection:C76([OrderLine:49])
	FIRST RECORD:C50([OrderLine:49])
	vi1:=0
	For (vi1; 1; vi2)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[OrderLine:49]itemNum:4)
		If (Records in selection:C76([Item:4])=0)
			[OrderLine:49]description:5:="Orphaned Item"
			SAVE RECORD:C53([OrderLine:49])
		Else 
			[OrderLine:49]description:5:=[Item:4]description:7
		End if 
		QUERY:C277([Order:3]; [Order:3]orderNum:2=[OrderLine:49]orderNum:1)
		If (Records in selection:C76([Order:3])#1)
			[OrderLine:49]class:53:="Orphaned Order"
			
		Else 
			[Order:3]dateOrdered:4:=[Order:3]dateNeeded:5
			SAVE RECORD:C53([Order:3])
			[OrderLine:49]dateOrdered:25:=[Order:3]dateOrdered:4
			[OrderLine:49]dateShipOn:38:=[Order:3]dateOrdered:4
			[OrderLine:49]dateRequired:23:=[Order:3]dateOrdered:4
			[OrderLine:49]qtyBackLogged:8:=[OrderLine:49]qty:6
			[OrderLine:49]qtyShipped:7:=0
		End if 
		SAVE RECORD:C53([OrderLine:49])
		NEXT RECORD:C51([OrderLine:49])
	End for 
	
End if 


If (False:C215)
	
	allowAlerts_boo:=False:C215
	QUERY:C277([PO:39]; [PO:39]complete:65<2)
	vi2:=Records in selection:C76([PO:39])
	FIRST RECORD:C50([PO:39])
	For (vi1; 1; vi2)
		NxPvPOs
		booAccept:=True:C214
		vMod:=True:C214
		acceptPO
		NEXT RECORD:C51([PO:39])
	End for 
	allowAlerts_boo:=True:C214
	
	
	If (False:C215)
		READ WRITE:C146([POLine:40])
		QUERY:C277([POLine:40]; [POLine:40]complete:25="")
		vi2:=Records in selection:C76([POLine:40])
		FIRST RECORD:C50([POLine:40])
		vi1:=0
		For (vi1; 1; vi2)
			If ([POLine:40]qtyReceived:4>=[POLine:40]qtyOrdered:3)
				[POLine:40]complete:25:="x"
				SAVE RECORD:C53([POLine:40])
			End if 
			NEXT RECORD:C51([POLine:40])
		End for 
		
		If (False:C215)
			ALL RECORDS:C47([POLine:40])
			vi2:=Records in selection:C76([POLine:40])
			FIRST RECORD:C50([POLine:40])
			For (vi1; 1; vi2)
				QUERY:C277([PO:39]; [PO:39]poNum:5=[POLine:40]poNum:1)
				[POLine:40]dateExpected:15:=[PO:39]dateNeeded:3
				If ([POLine:40]dateExpected:15<!2006-01-01!)
					[POLine:40]complete:25:="x"
				End if 
				SAVE RECORD:C53([POLine:40])
				NEXT RECORD:C51([POLine:40])
			End for 
		End if 
		
		QUERY:C277([PO:39]; [PO:39]dateNeeded:3<!2006-01-01!; *)
		
		QUERY:C277([PO:39];  & [PO:39]complete:65<2)
		vi2:=Records in selection:C76([PO:39])
		FIRST RECORD:C50([PO:39])
		For (vi1; 1; vi2)
			If ([PO:39]dateNeeded:3<!2006-01-01!)
				[PO:39]complete:65:=2
				SAVE RECORD:C53([PO:39])
			End if 
			NEXT RECORD:C51([PO:39])
		End for 
		
		
		If (False:C215)
			If (False:C215)
				ALL RECORDS:C47([POLine:40])
				vi2:=Records in selection:C76([POLine:40])
				FIRST RECORD:C50([POLine:40])
				For (vi1; 1; vi2)
					//QUERY([Item];[Item]ItemNum=[POLine]ItemNum)
					//[POLine]Description:=[Item]Description
					[POLine:40]qtyBackLogged:5:=[POLine:40]qtyOrdered:3
					[POLine:40]backOrderAmount:13:=[POLine:40]qtyBackLogged:5*[POLine:40]unitCost:7
					[POLine:40]qtyReceived:4:=0
					SAVE RECORD:C53([POLine:40])
					NEXT RECORD:C51([POLine:40])
				End for 
			End if 
			If (False:C215)
				ALL RECORDS:C47([PO:39])
				vi2:=Records in selection:C76([PO:39])
				FIRST RECORD:C50([PO:39])
				For (vi1; 1; vi2)
					//[PO]AmountBackLog
					[PO:39]totalLanded:66:=[PO:39]total:24
					//[PO]AmountBackLog
					QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[PO:39]vendorID:1)
					If (Records in selection:C76([Vendor:38])=1)
						loadVendor2PO
						SAVE RECORD:C53([PO:39])
					End if 
					NEXT RECORD:C51([PO:39])
				End for 
			End if 
			
			//If (False)
			ALL RECORDS:C47([POLine:40])
			vi2:=Records in selection:C76([POLine:40])
			FIRST RECORD:C50([POLine:40])
			For (vi1; 1; vi2)
				//QUERY([Item];[Item]ItemNum=[POLine]ItemNum)
				//[POLine]Description:=[Item]Description
				//[POLine]QtyBackLogged:=[POLine]QtyOrdered
				//[POLine]BackOrderAmount:=[POLine]QtyBackLogged*[POLine]UnitCost
				//SAVE RECORD([POLine])
				QUERY:C277([InventoryStack:29]; [InventoryStack:29]lineNum:12=[POLine:40]idNum:32)
				vi4:=Records in selection:C76([InventoryStack:29])
				If (vi4>0)
					FIRST RECORD:C50([InventoryStack:29])
					For (vi3; 1; vi4)
						[POLine:40]qtyReceived:4:=[POLine:40]qtyReceived:4+[InventoryStack:29]qtyOnHand:9
						[POLine:40]qtyBackLogged:5:=[POLine:40]qtyBackLogged:5-[InventoryStack:29]qtyOnHand:9
						
						[InventoryStack:29]changeReason:6:="linked"
						
						SAVE RECORD:C53([InventoryStack:29])
						NEXT RECORD:C51([InventoryStack:29])
					End for 
					[POLine:40]backOrderAmount:13:=[POLine:40]qtyBackLogged:5*[POLine:40]unitCost:7
					[POLine:40]siteAdder:26:=1
					SAVE RECORD:C53([POLine:40])
				End if 
				NEXT RECORD:C51([POLine:40])
			End for 
			//End if 
			
			If (False:C215)
				ALL RECORDS:C47([POLine:40])
				vi2:=Records in selection:C76([POLine:40])
				FIRST RECORD:C50([POLine:40])
				For (vi1; 1; vi2)
					[POLine:40]qtyBackLogged:5:=[POLine:40]qtyReceived:4+[POLine:40]qtyBackLogged:5
					[POLine:40]qtyReceived:4:=[POLine:40]qtyOrdered:3+[POLine:40]qtyBackLogged:5
					[POLine:40]backOrderAmount:13:=[POLine:40]qtyBackLogged:5*[POLine:40]unitCost:7
					SAVE RECORD:C53([POLine:40])
					NEXT RECORD:C51([POLine:40])
				End for 
				
			End if 
		End if 
	End if 
End if 