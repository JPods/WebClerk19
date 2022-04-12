//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-06T00:00:00, 17:43:41
// ----------------------------------------------------
// Method: //  CHOPPED ContactAddFromCustomer
// Description
// Modified: 08/06/13
// 
// 
//
// Parameters
// ----------------------------------------------------



KeyModifierCurrent
If (CmdKey=0)
	ADD RECORD:C56([Contact:13])
	//QUERY([Contact];[Contact]customerID=[Customer]customerID)
	////  CHOPPED FillContactArrays (Records in selection([Contact]);eContactsAreaList)
	//pPartNum:=""
	//pDescript:=""
	//pUnitPrice:=0
	//pDiscnt:=0
	//pExtPrice:=0
	//pPricePt:=""
	//pQtyBL:=pQtyOrd//
Else 
	QUERY:C277([Contact:13]; [Contact:13]customerID:1=[Customer:2]customerID:1)
	If (Records in selection:C76([Contact:13])=0)
		ADD RECORD:C56([Contact:13])
	Else 
		ProcessTableOpen(Table:C252(->[Contact:13])*-1)
	End if 
End if 