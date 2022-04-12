//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/15/09, 12:06:37
// ----------------------------------------------------
// Method: CC_ReturnXedOutCardNum
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; $orgCardNum; $displayCardNum; $1)
If (Count parameters:C259=1)
	C_TEXT:C284($1)
	$orgCardNum:=$1
Else 
	$orgCardNum:="4444555566667777"  //testing
End if 
Case of 
	: ($orgCardNum="")  // Modified by: williamjames (111216 checked for <= length protection)
		
	: (<>tcCCStoragePolicy=1)  //save just the last 4
		$displayCardNum:=$orgCardNum[[1]]+"xxxxxxxxxxx"+Substring:C12($orgCardNum; (Length:C16($orgCardNum)-4)+1)
		//SET BLOB SIZE([Customer]CreditCardBlob;0)
	: (<>tcCCStoragePolicy=2)
		$displayCardNum:=$orgCardNum[[1]]+"XXXXXXXXXXX"+Substring:C12($orgCardNum; (Length:C16($orgCardNum)-4)+1)
	: (<>tcCCStoragePolicy=3)
		$displayCardNum:=$orgCardNum
End case 
$0:=$displayCardNum