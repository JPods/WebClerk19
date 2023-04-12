//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-29T06:00:00Z)
// Method: DropShipFill
// Description 
// Parameters
// ----------------------------------------------------
var $1; $2; $tnFrom; $tnTo : Text
var $from_o; $to_o : Object
$tnFrom:=$1
$tnTo:=$2
If ($1=process_o.dataClassName)
	$to_o:=process_o.cur
	If (process_o.ents[$tnFrom]#Null:C1517)
		$from_o:=process_o.ents[$tnFrom].first()
		Data_AddressCopy($from_o; $to_o)
	End if 
End if 