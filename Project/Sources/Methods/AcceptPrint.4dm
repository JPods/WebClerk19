//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/29/11, 23:06:01
// ----------------------------------------------------
// Method: AcceptPrint
// Description
// 
//
// Parameters
// ----------------------------------------------------



Case of   //Must not reset to 0 is Accept button is selected.  6 allows the flow to continue
	: (Locked:C147(ptCurTable->))
		If (allowAlerts_boo)
			jAlertMessage(12009)
		End if 
	: (ptCurTable=(->[Order:3]))  //Orders
		acceptOrders
	: (ptCurTable=(->[Invoice:26]))  //Invoices
		If ([Invoice:26]dateInvoiced:35=!00-00-00!)
			[Invoice:26]dateInvoiced:35:=Current date:C33
		End if 
		acceptInvoice
	: (ptCurTable=(->[Item:4]))  //Items    
		SAVE RECORD:C53([ItemSpec:31])
		SAVE RECORD:C53([Item:4])
	: (ptCurTable=(->[Service:6]))
		If (Modified record:C314([Customer:2]))
			SAVE RECORD:C53([Customer:2])
		End if 
		SAVE RECORD:C53([Service:6])
		newService:=False:C215
	: (ptCurTable=(->[Customer:2]))
		If (Modified record:C314([Contact:13]))
			SAVE RECORD:C53([Contact:13])
		End if 
		SAVE RECORD:C53([Customer:2])
	: (ptCurTable=(->[Proposal:42]))
		acceptPropsl
		//PpLnFillRays (Records in selection([POLine]))
	: (ptCurTable=(->[PO:39]))
		acceptPO
		// PoLnFillRays (Records in selection([PrpLine]))
	Else 
		SAVE RECORD:C53(ptCurTable->)
End case 
//SET WINDOW TITLE(Table name(ptCurTable)+" ; Record number:  "+String(Record number(ptCurTable->)))
If (ptCurTable#(->[Control:1]))
	Set_Window_Title(ptCurTable)
End if 
myOK:=1
RP_SaveRecordtoSyncRecord(ptCurTable)
