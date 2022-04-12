//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-07-24T00:00:00, 04:08:00
// ----------------------------------------------------
// Method: Ivc  LoadCust
// Description
// Modified: 07/24/14
// Structure: CEv13_131005
// Ivc  LoadCust
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305($forceUpdate; $1)
$forceUpdate:=False:C215
If (Count parameters:C259=1)
	$forceUpdate:=$1
End if 
LoadCustomersInvoices($forceUpdate)
