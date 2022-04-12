If (False:C215)
	//Method:
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 
//
//aTmp20Str3{1}:="Shread"
////////////aTmp20Str3{2}:="Item"
//aTmp20Str3{2}:="Package/Pallet"
//aTmp20Str3{3}:="Invoice"
//aTmp20Str3:=1
//TRACE
C_LONGINT:C283(bShred)

$vtSelected:=String:C10(Size of array:C274(aShipSel))
CONFIRM:C162("WARNING: THERE IS NO UNDO ! \r\rShred "+$vtSelected+" Packages"; " Shred "+$vtSelected+" Packages "; " Cancel ")
If (OK=1)
	//TRACE
	//Case of 
	//: (aTmp20Str3=2)
	//PKShredItem 
	//: (aTmp20Str3=2)
	PKShredPackage
	//: (aTmp20Str3=3)
	//ALERT("Disabled")
	//If (False)
	//PKShredInvoice 
	//End if 
	//End case 
End if 