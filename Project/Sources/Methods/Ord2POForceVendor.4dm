//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/25/19, 21:45:47
// ----------------------------------------------------
// Method: Ord2POForceVendor
// Description
// 
//
// Parameters
// ----------------------------------------------------




C_POINTER:C301($ptTableStart; ptCurTable)
If (Is nil pointer:C315(ptCurTable))
	ptCurTable:=(->[Order:3])
	$ptTableStart:=ptCurTable
Else 
	$ptTableStart:=ptCurTable
End if 
If (False:C215)  // testing
	Process_InitLocal
	
	C_POINTER:C301($ptTableStart; ptCurTable)
	C_LONGINT:C283(vHere)
	If (Is nil pointer:C315(ptCurTable))
		ptCurTable:=(->[Order:3])
	End if 
	$ptTableStart:=ptCurTable
	
	ptCurTable:=(->[Order:3])
	
	vbRecordsPassing:=True:C214
	strCurrency:=""
	booAccept:=True:C214
	vRunningBal:=0
	myTrap:=0
	newOrd:=False:C215
	
	vtVendorID:="AZ"
	ptCurTable:=(->[Order:3])
	
	QUERY:C277([Order:3]; [Order:3]orderNum:2=2930)
	QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=2930)
	// OrderCalcArrays would normally have the array loaded
	
	// ### bj ### 20190210_1228
	// bad to have two arrays for selected records
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
	
	// both need to already be loaded when not in test mode
	QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1="az")
	QUERY:C277([SyncRelation:103]; [SyncRelation:103]name:8="POstoVendor-"+[Vendor:38]vendorID:1)
End if 
Execute_TallyMaster("SOtoPOBefore"; "webscript")


// get the vendor records loaded
// get vtVendorID from one of the webtemp records line items
booAccept:=False:C215
// QUERY([Vendor];[Vendor]VendorID=vtVendorID) vendor is alread set
CREATE RECORD:C68([PO:39])
C_BOOLEAN:C305($vbEDI)
$vbEDI:=allowAlerts_boo
allowAlerts_boo:=False:C215
POBasicsNew
loadVendor2PO
PoLnFillRays(0)
myCycle:=10
C_BOOLEAN:C305($vbShipToCustomer)
$vbShipToCustomer:=<>vbCust2PO  // shipping to store
<>vbCust2PO:=False:C215

// bad to have two arrays for selected records
// do not block any lines
ARRAY LONGINT:C221(aOrdLinesProcessed; 0)
// populate the orderline arrays
OrderCalcArrays(-3000)
// select all elements
arraySellectAll(->aOItemNum; ->aOrdLnSel)
// ### bj ### 20190122_2123
COPY ARRAY:C226(aOrdLnSel; aoLnSelect)

PO_AddNewLines
<>vbCust2PO:=$vbShipToCustomer
myCycle:=0
booAccept:=True:C214
acceptPO  //transactions are in accept Procedure  
PoLnFillRays(0)
Execute_TallyMaster("SOtoPOAfter"; "WebClerk")

// [SyncRelation]Action must = POstoVendor
//  RP_JSONSend 
ptCurTable:=$ptTableStart
allowAlerts_boo:=$vbEDI
