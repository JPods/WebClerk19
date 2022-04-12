// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/06/10, 09:09:00
// ----------------------------------------------------
// Method: Object Method: bSerialOrd
// Description
// Action: blocked until testthis, then delete
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($ptCurTable)
Case of 
		//: ([ItemSrlAction]FileRef=File([Order]))
		//<>ptCurFile:=([Order])
		//
		//SEARCH([Order];[Order]OrderNum=[ItemSrlAction]DocID)
		//
	: ([ItemSerialAction:64]tableNum:3=Table:C252(->[Invoice:26]))
		$ptCurTable:=(->[Invoice:26])
		QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]serialRc:26=[ItemSerialAction:64]docid:4)
		QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=[InvoiceLine:54]invoiceNum:1)
	: ($ptCurTable=(->[PO:39]))
		<>ptCurTable:=(->[PO:39])
		QUERY:C277([POLine:40]; [POLine:40]serialRc:18=[ItemSerialAction:64]docid:4)
		QUERY:C277([PO:39]; [PO:39]poNum:5=[POLine:40]poNum:1)
		UNLOAD RECORD:C212([PO:39])
		UNLOAD RECORD:C212([POLine:40])
End case 
If (Not:C34(Is nil pointer:C315($ptCurTable)))
	If (Records in selection:C76($ptCurTable->)>0)
		DB_ShowCurrentSelection($ptCurTable; ""; 1; "")
		myOK:=0
		CANCEL:C270
	Else 
		BEEP:C151
	End if 
End if 