//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/03/08, 02:40:34
// ----------------------------------------------------
// Method: P_AddressesCustomer
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($showAddressName)
If (Count parameters:C259=0)
	$showAddressName:=True:C214
Else 
	$showAddressName:=$1
End if 

vAddressBillTo:=""
vAddressShipTo:=""
If ([Customer:2]contactBillTo:92<1)
	If ([Customer:2]addrAltBillTo:77#"")
		vAddressBillTo:=[Customer:2]addrAltBillTo:77
	Else 
		vAddressBillTo:=PVars_AddressFull("Customer")
	End if 
Else 
	QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Customer:2]contactBillTo:92)
	vAddressBillTo:=PVars_AddressFull("Contact")
End if 
//
If ([Customer:2]contactShipTo:93<1)
	vAddressShipTo:=PVars_AddressFull("Customer")
Else 
	QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Customer:2]contactShipTo:93)
	vAddressShipTo:=PVars_AddressFull("Contact")
End if 