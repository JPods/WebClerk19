//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/09/08, 17:53:40
// ----------------------------------------------------
// Method: Cust2OrdAddress
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $viAction)
If (Count parameters:C259=1)
	$viAction:=$1
Else 
	$viAction:=1
End if 
AddressOrderFill("shiptofromCustomer")
If ($viAction=0)
	
Else 
	[Order:3]company:15:="NoPrimeShip2"
	[Order:3]address1:16:=""
	[Order:3]address2:17:=""
	[Order:3]city:18:=""
	[Order:3]state:19:=""
	[Order:3]zip:20:=""
	[Order:3]country:21:=""
	[Order:3]attention:44:=""
	[Order:3]zone:14:=-1
End if 