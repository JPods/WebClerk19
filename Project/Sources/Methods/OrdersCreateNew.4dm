//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-08T00:00:00, 23:33:11
// ----------------------------------------------------
// Method: 
// Description
// Modified: 11/08/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305($1; $keepOrd)
$keepOrd:=True:C214
If (Count parameters:C259=1)
	$keepOrd:=$1
End if 

// Modified by: Bill James (2015-01-28T00:00:00 Fixing DataMemory XML read in. Orders is already created)
If (Not:C34(Is new record:C668([Order:3])))
	CREATE RECORD:C68([Order:3])
	$keepOrd:=False:C215
End if 
If (($keepOrd) & ([Order:3]orderNum:2=0))  //$newOrd, do not increment if web is not saving order
	[Order:3]orderNum:2:=CounterNew(->[Order:3])
End if 
//  Alert("Assigning Order Num: "+string([Order]OrderNum))
[Order:3]labelCount:32:=1
[Order:3]takenBy:36:=Current user:C182
[Order:3]dateNeeded:5:=Current date:C33+<>tcNeedDelay
[Order:3]dateShipOn:31:=Current date:C33+<>tcNeedDelay
[Order:3]dateOrdered:4:=Current date:C33
[Order:3]timeOrdered:58:=Current time:C178

[Order:3]action:150:="Confirm with Customer"
[Order:3]actionBy:55:=Current user:C182
[Order:3]actionDate:149:=Current date:C33+3
[Order:3]actionTime:37:=?07:31:00?


If (<>tcCancelBy>0)
	[Order:3]dateCancel:53:=[Order:3]dateNeeded:5+<>tcCancelBy
End if 
[Order:3]autoFreight:40:=(<>tcAutoFrght=1)
[Order:3]fob:45:=Storage:C1525.default.fob
newOrd:=True:C214
changeOrd:=True:C214  //(Error=0)