//%attributes = {}
// ----------------------------------------------------
// Method: UTIL_HEXTODEC
// Example: $var_longint:=UTIL_HEXTODEC($var_hex_text)
// Description: Converts a hexidecimal string ("4D") to a longint (77)
// Parameters: 
//    $0 := Long Int
//    $1 := Text
// ----------------------------------------------------

C_LONGINT:C283($0; $location; $length; $total; $a; $thisValue)
C_TEXT:C284($1; $hex)
If (Count parameters:C259=1)
	$hex:=$1
	$length:=Length:C16($hex)
	$total:=0
	For ($a; 1; $length)
		Case of 
			: ($hex[[$a]]="A")
				$thisValue:=10
			: ($hex[[$a]]="B")
				$thisValue:=11
			: ($hex[[$a]]="C")
				$thisValue:=12
			: ($hex[[$a]]="D")
				$thisValue:=13
			: ($hex[[$a]]="E")
				$thisValue:=14
			: ($hex[[$a]]="F")
				$thisValue:=15
			Else 
				$thisValue:=Num:C11($hex[[$a]])
		End case 
		$location:=$length-$a
		$total:=$total+($thisValue*(16^$location))
	End for 
End if 
$0:=$total