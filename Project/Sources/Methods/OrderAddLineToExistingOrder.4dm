//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/21/11, 12:29:45
// ----------------------------------------------------
// Method: OrderAddLineToExistingOrder
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $itemNum)
$itemNum:=$1

If ([Item:4]itemNum:1#$itemNum)
	QUERY:C277([Item:4]; [Item:4]itemNum:1=$itemNum)
End if 
If ((Records in selection:C76([Item:4])=1) & (Record number:C243([Order:3])>-1))
	If (Not:C34(Locked:C147([Order:3])))
		pPartNum:=[Item:4]itemNum:1
		pDescript:=[Item:4]description:7
		OrdLnFillRays
		aoLineAction:=Size of array:C274(aoLineAction)
		pQtyOrd:=1
		OrdLnAdd((Size of array:C274(aoLineAction)+1); 1; True:C214)
		vMod:=True:C214
		booAccept:=True:C214
		acceptOrders
	Else 
		
	End if 
End if 

