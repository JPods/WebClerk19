//%attributes = {"publishedWeb":true}
//(GP) BarCodeFill39
//called by SuperLabel
If (Count parameters:C259=0)
	$theRecName:=""
Else 
	//Method: Execute_TallyResult
	C_TEXT:C284($1; $theRecName; $vtSearch)
	C_PICTURE:C286($vpSearch)
	//
	If (Count parameters:C259=0)
		$theRecName:=""
	Else 
		$theRecName:=$1
	End if 
	//checkThis, why [TallyResult]TextBlk2, why not TallyMaster
	QUERY:C277([TallyResult:73]; [TallyResult:73]Name:1=$theRecName; *)
	QUERY:C277([TallyResult:73];  & [TallyResult:73]Purpose:2="Execute_Text2")
	ExecuteText(0; [TallyResult:73]TextBlk2:6)
End if 
If (vlongCnt<Size of array:C274(aItemRecs))
	vlongCnt:=vlongCnt+1
	If (aItemRecs{vlongCnt}#Record number:C243([Item:4]))
		GOTO RECORD:C242([Item:4]; aItemRecs{vlongCnt})
	End if 
	If ([Item:4]barCode:34#"")
		BarCode39:="*"+[Item:4]barCode:34+"*"
	Else 
		BarCode39:="*"+[Item:4]itemNum:1+"*"
	End if 
	Case of 
		: (Not:C34([Item:4]specification:42))
			UNLOAD RECORD:C212([ItemSpec:31])
		: ([Item:4]specId:62="")
			QUERY:C277([ItemSpec:31]; [ItemSpec:31]ItemNum:1=[Item:4]itemNum:1)
		Else 
			QUERY:C277([ItemSpec:31]; [ItemSpec:31]ItemNum:1=[Item:4]specId:62)
	End case 
	Case of 
		: (aTmpLong1{vlongCnt}=0)
			//        
		: (aTmpLong1{vlongCnt}=3)
			QUERY:C277([Order:3]; [Order:3]orderNum:2=aTmpLong2{vlongCnt})
			QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2; *)
			QUERY:C277([OrderLine:49];  & [OrderLine:49]lineNum:3=aTmpLong3{vlongCnt})
		: (aTmpLong1{vlongCnt}=Table:C252(->[Invoice:26]))
			QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=aTmpLong2{vlongCnt})
			QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2; *)
			QUERY:C277([InvoiceLine:54];  & [InvoiceLine:54]lineNum:3=aTmpLong3{vlongCnt})
		: (aTmpLong1{vlongCnt}=Table:C252(->[PO:39]))
			QUERY:C277([PO:39]; [PO:39]poNum:5=aTmpLong2{vlongCnt})
			QUERY:C277([QQQPOLine:40]; [QQQPOLine:40]poNum:1=[PO:39]poNum:5; *)
			QUERY:C277([QQQPOLine:40];  & [QQQPOLine:40]lineNum:14=aTmpLong3{vlongCnt})
			If ([QQQPOLine:40]orderNum:16#0)
				QUERY:C277([Order:3]; [Order:3]orderNum:2=[QQQPOLine:40]orderNum:16)
			End if 
			//If ([POLine]RefOrderNum#0)
			//QUERY([Order];[Order]OrderNum=[POLine]RefOrderNum)
			//End if 
		: (aTmpLong1{vlongCnt}=Table:C252(->[InventoryStack:29]))
			QUERY:C277([InventoryStack:29]; [InventoryStack:29]idUnique:1=aTmpLong2{vlongCnt})
	End case 
End if 