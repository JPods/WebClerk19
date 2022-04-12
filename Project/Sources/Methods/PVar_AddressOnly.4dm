//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-27T06:00:00Z)
// Method: PVar_AddressOnly
// Description 
// Parameters
// ----------------------------------------------------
var $1 : Object
var $0 : Text

$0:=jConcat($data_o.address1; "\r")+jConcat($data_o.address2; "\r")+jConcat($data_o.city; ", ")+jConcat($data_o.state; " ")+jConcat($data_o.zip; "\r")+$data_o.country