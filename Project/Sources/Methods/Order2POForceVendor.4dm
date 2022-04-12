//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/26/19, 02:52:25
// ----------------------------------------------------
// Method: Order2POForceVendor
// Description
// 
//
// Parameters
// ----------------------------------------------------



If (Is nil pointer:C315(ptCurTable))
	ptCurTable:=(->[Order:3])
End if 
$ptTableStart:=ptCurTable
allowAlerts_boo:=False:C215
ptCurTable:=(->[Order:3])
vbRecordsPassing:=True:C214
strCurrency:=""
booAccept:=True:C214
vRunningBal:=0
myTrap:=0
newOrd:=False:C215
vtVendorID:="AZ"

If (False:C215)  // testing
	
	Process_InitLocal
	C_POINTER:C301($ptTableStart; ptCurTable)
	C_LONGINT:C283(vHere)
	ptCurTable:=(->[Order:3])
	
	QUERY:C277([Order:3]; [Order:3]orderNum:2=2930)
	QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=2930)
	// OrderCalcArrays would normally have the array loaded
	
	ARRAY LONGINT:C221(aOrdLinesProcessed; 0)
	OrderCalcArrays(-3000)
	arraySellectAll(->aOItemNum; ->aOrdLnSel)
	// ### bj ### 20190122_2123
	COPY ARRAY:C226(aOrdLnSel; aoLnSelect)
	
	//  aoLnSelect) we should only have one of these
	
	QUERY:C277([POLine:40]; [POLine:40]orderNum:16=2930)
	DELETE SELECTION:C66([POLine:40])
	QUERY:C277([PO:39]; [PO:39]orderNum:18=2930)
	DELETE SELECTION:C66([PO:39])
	
	// this needs to be done in the web accept script 
	//  WccExecuteTask ("Http_Parse_End";$tableNum)
	// call Execute_TallyMaster ("SOtoPOBefore";"WebClerk")
	QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1="az")
	
End if 
Execute_TallyMaster("SOtoPOBefore"; "WebClerk")
If (vbRecordsPassing)
	QUERY:C277([SyncRelation:103]; [SyncRelation:103]name:8="POstoVendor-"+[Vendor:38]vendorID:1)
	// get the vendor records loaded
	// get vtVendorID from one of the webtemp records line items
	booAccept:=False:C215
	QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=vtVendorID)
	CREATE RECORD:C68([PO:39])
	POBasicsNew
	loadVendor2PO
	PoLnFillRays(0)
	myCycle:=10
	C_BOOLEAN:C305($vbShipToCustomer)
	$vbShipToCustomer:=<>vbCust2PO  // shipping to store
	<>vbCust2PO:=False:C215
	PO_AddNewLines
	<>vbCust2PO:=$vbShipToCustomer
	myCycle:=0
	booAccept:=True:C214
	acceptPO  //transactions are in accept Procedure  
	PoLnFillRays(0)
	Execute_TallyMaster("SOtoPOAfter"; "WebClerk")
	
	// [SyncRelation]Action must = POstoVendor
	RP_JSONSend
End if 

ptCurTable:=$ptTableStart
