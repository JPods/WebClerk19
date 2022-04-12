//%attributes = {"publishedWeb":true}
//Procedure: showInvLines
Case of 
	: (vHere=1)
		C_BOOLEAN:C305($doJoin)
		$doJoin:=True:C214
		Case of 
			: (ptCurTable=(->[Customer:2]))
				RELATE MANY SELECTION:C340([InvoiceLine:54]customerID:2)
			: (ptCurTable=(->[Invoice:26]))
				RELATE MANY SELECTION:C340([InvoiceLine:54]invoiceNum:1)
			Else 
				DB_ShowByTableName("InvoiceLine")
				$doJoin:=False:C215
		End case 
		If ($doJoin)
			If (Records in selection:C76([InvoiceLine:54])>0)
				ProcessTableOpen(Table:C252(->[InvoiceLine:54]))
				//ProcessTableOpen (->[InvoiceLine])
			End if 
		End if 
	: (vHere>1)
		Case of 
			: (ptCurTable=(->[Order:3]))
				QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]orderNum:60=[Order:3]orderNum:2)
				If (Records in selection:C76([InvoiceLine:54])>0)
					ProcessTableOpen(Table:C252(->[InvoiceLine:54])*-1)
				Else 
					BEEP:C151
					BEEP:C151
				End if 
			: (ptCurTable=(->[Invoice:26]))
				QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
				If (Records in selection:C76([InvoiceLine:54])>0)
					ProcessTableOpen(Table:C252(->[InvoiceLine:54])*-1)
				Else 
					BEEP:C151
					BEEP:C151
				End if 
			: ((ptCurTable=(->[Customer:2])) | (ptCurTable=(->[Proposal:42])) | (ptCurTable=(->[Contact:13])))
				QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]customerID:2=[Customer:2]customerID:1)
				If (Records in selection:C76([InvoiceLine:54])>0)
					ProcessTableOpen(Table:C252(->[InvoiceLine:54])*-1)
				Else 
					BEEP:C151
					BEEP:C151
				End if 
			Else 
				DB_ShowByTableName("OrderLine")
		End case 
		
	Else 
		DB_ShowByTableName("InvoiceLine")
End case 