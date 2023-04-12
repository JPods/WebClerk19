//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-30T06:00:00Z)
// Method: VendorFromCustomer
// Description 
// Parameters
// ----------------------------------------------------

var $oCust; $oVend; $1 : Object
Case of 
	: (Count parameters:C259=1)
		$oCust:=$1
	: (process_o.cur#Null:C1517)
		If (process_o.dataClassName="Customer")
			$oCust:=process_o.cur
		End if 
End case 
If ($oCust#Null:C1517)
	$oVend:=ds:C1482.Vendor.query("customerIDCustTable = :1"; $oCust.customerID)
	If ($oVend#Null:C1517)
		ConsoleLog("Vendor already exists with customerID: "+$oCust.customerID)
	Else 
		
		$oVend:=ds:C1482.Vendor.new()
		$oVend.vendorID:=$oCust.customerID
		$oVend.terms:=Storage:C1525.default.terms
		//
		$oVend.mfrLocationid:=$oCust.mfrLocationid
		$oVend.company:=$oCust.company
		$oVend.address1:=$oCust.address1
		$oVend.address2:=$oCust.address2
		$oVend.email:=$oCust.email
		$oVend.domain:=$oCust.domain
		$oVend.city:=$oCust.city
		$oVend.state:=$oCust.state
		$oVend.zip:=$oCust.zip
		$oVend.country:=$oCust.country
		$oVend.phone:=$oCust.phone
		$oVend.phoneCell:=$oCust.phoneCell
		$oVend.phonePrefix:=$oCust.phonePrefix
		$oVend.phoneSuffix:=$oCust.phoneSuffix
		$oVend.fax:=$oCust.fax
		//  $oCust.Rep:=""
		
		$oVend.profile1:=$oCust.profile1
		$oVend.profile2:=$oCust.profile2
		$oVend.profile3:=$oCust.profile3
		$oVend.profile4:=$oCust.profile4
		$oVend.comment:="Transfer from Customers "+String:C10(Current date:C33)
		$oVend.attention:=$oCust.nameFirst+(" "*Num:C11($oCust.nameFirst#""))+$oCust.nameLast
		$oVend.dunsNumber:=$oCust.dunsNumber
		$oVend.currency:=$oCust.currency
		$oVend.alertMessage:=$oCust.alertMessage
		$oVend.customerIDCustTable:=$oCust.customerID
		$oVend.save()
		ConsoleLog("Vendor created with customerID: "+$oCust.customerID)
	End if 
End if 
