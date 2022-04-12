//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-11-24T00:00:00, 09:42:12
// ----------------------------------------------------
// Method: CC_ReturnCardType
// Description
// Modified: 11/24/16
// 
// 
//  Ref: CC_VerifyPayType
// Parameters
// ----------------------------------------------------


// ----------------------------------------------------
C_TEXT:C284($1; $0; $creditCardNum)  // 
$creditCardNum:=$1
Case of 
	: ($creditCardNum="")  // Modified by: williamjames (111216 checked for <= length protection)
		$0:="Unknown"
	: ($creditCardNum[[1]]="3")
		$0:="Amex"
	: ($creditCardNum[[1]]="4")
		$0:="Visa"
	: ($creditCardNum[[1]]="5")
		$0:="MC"
	: ($creditCardNum[[1]]="6")
		$0:="Discover"
	Else 
		$0:="Unrecognized"
End case 

