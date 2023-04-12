//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/16/15, 11:04:43
// ----------------------------------------------------
// Method: EDI_OrdOpen
// Description
// 
//
// Parameters
// ----------------------------------------------------

// should already have Order selected to open

Case of 
	: (Records in selection:C76([Order:3])=1)
		<>passMeText1:=""
		If (Record number:C243([Customer:2])>=0)
			myCycle:=3  //add customer info into order
		Else 
			myCycle:=0  //add order w/o customer, hope EDI fills in
		End if 
		ptCurTable:=->[Order:3]
		vHere:=2
		bExchange:=0
		allowAlerts_boo:=False:C215  //prevents code surrounded by blocking ifs
		NxPvOrders
		allowAlerts_boo:=True:C214
	: (Records in selection:C76([Order:3])=0)
		ELog_NewRecMsg(-1; "TIOI Error"; "Error: EDI_OrdOpen - No Order Selected")
	: (Records in selection:C76([Order:3])>1)
		ELog_NewRecMsg(-1; "TIOI Error"; "Error: EDI_OrdOpen - Multiple Orders Selected")
End case 


