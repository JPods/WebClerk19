//%attributes = {}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/02/21, 23:28:32
// ----------------------------------------------------
// Method: ParseOrderRecord
// Description
// 
// Parameters
// ----------------------------------------------------


//  RRRR to Objects
// ParseOrdersORDA work on this
C_LONGINT:C283($1)
If ($1#[Order:3]orderNum:2)
	QUERY:C277([Order:3]; [Order:3]orderNum:2=$1)
End if 
If (Locked:C147([Order:3]))
	WCapi_SetParameter("isLocked"; "true")
	vResponse:="Error: Proposals record locked: "+String:C10([Proposal:42]proposalNum:5)
Else 
	NxPvOrders
	
	booAccept:=True:C214
	vMod:=True:C214
	QUERY:C277([OrderLine:49]; [OrderLine:49]orderNum:1=[Order:3]orderNum:2)
	$k:=Records in selection:C76([OrderLine:49])
	OrdLnFillRays
	vMod:=calcOrder(True:C214)
	booAccept:=True:C214
	vMod:=True:C214
	KeyWordsMake(->[Order:3])
	acceptOrders
	Execute_TallyMaster("OrdersAfterParse"; "WebScript")
	
End if 