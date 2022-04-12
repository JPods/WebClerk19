//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/19/08, 09:24:28
// ----------------------------------------------------
// Method: NTKString_2Hex
// Description
// 
//
// Parameters
// ----------------------------------------------------
// (PM) String_HexToDecimal
// Converts a number from the hexadecimal notation to the decimal notation
// $1 = Hex number
// $2 = Decimal number

C_TEXT:C284($1; $hex)
C_LONGINT:C283($0; $value; $power; $digit; $i)

$hex:=$1
$value:=0
$power:=0

// If the number stats with 0x or x, remove these characters
Case of 
	: ($hex="0x@")
		$hex:=Substring:C12($hex; 3)
	: ($hex="x@")
		$hex:=Substring:C12($hex; 2)
End case 

// Convert from hexadecimal to decimal
For ($i; Length:C16($hex); 1; -1)
	$digit:=Position:C15($hex[[$i]]; "0123456789ABCDEF")-1
	$value:=$value+($digit*(16^$power))
	$power:=$power+1
End for 

$0:=$value
