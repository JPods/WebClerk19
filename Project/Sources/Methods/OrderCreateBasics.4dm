//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/27/11, 08:22:48
// ----------------------------------------------------
// Method: OrderCreateBasics
// Description
// 
//
// Parameters
// ----------------------------------------------------


CREATE RECORD:C68([Order:3])
[Order:3]orderNum:2:=CounterNew(->[Order:3])
newOrd:=True:C214
changeOrd:=True:C214  //(Error=0)
[Order:3]labelCount:32:=1
[Order:3]takenBy:36:=Current user:C182
$theRec:=Record number:C243([Customer:2])
booWarn:=False:C215
LoadCustOrder
If (<>tcNeedDelay>-1)
	[Order:3]dateNeeded:5:=Current date:C33+<>tcNeedDelay
	[Order:3]dateShipOn:31:=Current date:C33+<>tcNeedDelay
End if 
[Order:3]dateOrdered:4:=Current date:C33
[Order:3]timeOrdered:58:=Current time:C178
If (<>tcCancelBy>0)
	[Order:3]dateCancel:53:=[Order:3]dateNeeded:5+<>tcCancelBy
End if 
[Order:3]autoFreight:40:=(<>tcAutoFrght=1)
[Order:3]fob:45:=Storage:C1525.default.fob
[Order:3]phone:67:=[Customer:2]phone:13
[Order:3]contactShipTo:78:=[Proposal:42]contactShipTo:63
OrdLnRays(0)