//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/16/21, 22:13:11
// ----------------------------------------------------
// Method: Convert_TextToValue
// Converts the given value to a new value type.
//
// $0 - VARIANT - The converted value
// $1 - VARIANT - The value to convert
// $2 - LONGINT - The new value type

C_VARIANT:C1683($0; $vConvertedValue)
C_VARIANT:C1683($1; $vValue)
C_LONGINT:C283($2; $lNewValueType)
$vValue:=$1
$lNewValueType:=$2

C_OBJECT:C1216($oConvert)
$oConvert:=New object:C1471("value"; $vValue)

// v2362b #119815: Date works differently than other data types
Case of 
	: ($lNewValueType=Is date:K8:7)
		$vConvertedValue:=OB Get:C1224($oConvert; "value"; Is text:K8:3)
		$vConvertedValue:=Date:C102($vConvertedValue)
	: ($lNewValueType=Is time:K8:8)
		$vConvertedValue:=OB Get:C1224($oConvert; "value"; Is text:K8:3)
		$vConvertedValue:=Time:C179($vConvertedValue)
	Else 
		$vConvertedValue:=OB Get:C1224($oConvert; "value"; $lNewValueType)
End case 

$0:=$vConvertedValue