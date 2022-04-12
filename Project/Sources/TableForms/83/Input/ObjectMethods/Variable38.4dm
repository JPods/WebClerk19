C_TEXT:C284($theItem)
If ([Requisition:83]ItemNum:38="zz@")
	$theItem:=<>UniqueIDPrefix+String:C10(CounterNew(->[Item:4]))
	$theItem:=Request:C163("Create or open item"; $theItem)
	If (OK=1)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$theItem)
	Else 
		$theItem:="exit"
	End if 
Else 
	QUERY:C277([Item:4]; [Item:4]itemNum:1=[Requisition:83]ItemNum:38)
End if 
Case of 
	: ($theItem="exit")  //drop out
	: (Records in selection:C76([Item:4])=0)
		[Requisition:83]ItemNum:38:=$theItem
		CREATE RECORD:C68([Item:4])
		[Item:4]itemNum:1:=[Requisition:83]ItemNum:38
		[Item:4]description:7:=[Requisition:83]Description:39
		[Item:4]costAverage:13:=[Requisition:83]CurCost:22
		[Item:4]leadTimeSales:12:=[Requisition:83]LeadDays:25
		[Item:4]vendorId:45:=[Requisition:83]VendorID:30
		[Item:4]costLastInShip:47:=[Requisition:83]CurCost:22
		If ([Requisition:83]CurSpec:21#"")
			CREATE RECORD:C68([ItemSpec:31])
			
			[ItemSpec:31]ItemNum:1:=[Requisition:83]ItemNum:38
			[ItemSpec:31]Specification:2:=[Requisition:83]CurSpec:21
			SAVE RECORD:C53([ItemSpec:31])
			[Item:4]specification:42:=True:C214
			[ItemSpec:31]DocType:26:=[Requisition:83]DocType:43
			[ItemSpec:31]DocReference:27:=[Requisition:83]DocReference:44
		End if 
		SAVE RECORD:C53([Requisition:83])
		SAVE RECORD:C53([Item:4])
		MODIFY RECORD:C57([Item:4])
	Else 
		MODIFY RECORD:C57([Item:4])
End case 