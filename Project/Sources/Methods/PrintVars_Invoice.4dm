//%attributes = {}

// Modified by: Bill James (2022-01-29T06:00:00Z)
// Method: PrintVars_Invoice
// Description 
// Parameters
// ----------------------------------------------------


var $1; $o : Object
If (Count parameters:C259=1)
	$o:=$1
Else 
	$o:=process_o.cur
End if 
If ($o.obGeneral.printVars#Null:C1517)
	MainAddress:=$o.obGeneral.printVars.mainAddress
	CustAddress:=$o.obGeneral.printVars.customerAddress
	ShipAddress:=$o.obGeneral.printVars.shipAddress
	LtrSignedBy:=$o.obGeneral.printVars.ltrSignedBy
	pvPhone:=$o.obGeneral.printVars.phone
	pvPhoneCell:=$o.obGeneral.printVars.phoneCell
	pvFAX:=$o.obGeneral.printVars.fax
	Dear_Contact:=$o.obGeneral.printVars.dearContact
	LtrAttn:=$o.obGeneral.printVars.attention
Else 
	MainAddress:="no obGeneral.printVars"
	CustAddress:="no obGeneral.printVars"
	ShipAddress:="no obGeneral.printVars"
	LtrSignedBy:="no obGeneral.printVars"
	pvPhone:="no obGeneral.printVars"
	pvPhoneCell:="no obGeneral.printVars"
	pvFAX:="no obGeneral.printVars"
	Dear_Contact:="no obGeneral.printVars"
	LtrAttn:="no obGeneral.printVars"
End if 