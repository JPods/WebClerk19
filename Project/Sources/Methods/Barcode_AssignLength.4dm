//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James  from Jim Medlen's 
// Date and time: 2013-12-17T00:00:00, 22:26:31
// ----------------------------------------------------
// Method: Barcode_AssignLength
// Description
// Modified: 12/17/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($iLoText8)
C_LONGINT:C283($1; $auto; $iLoLongInt8)
$auto:=$1

$iLoLongInt8:=Num:C11([Item:4]barCode:34)
$iLoText8:=String:C10($iLoLongInt8)
Case of 
	: (([Item:4]barCode:34="") & ($auto=1))
		[Item:4]barCode:34:=String:C10(CounterNew(->[DialingInfo:81]))  // just to get a number
	: ($auto=2)
		[Item:4]barCode:34:=String:C10(CounterNew(->[DialingInfo:81]))  // just to get a number
		// care must be taken on sum barcords to set the length
	: ($auto=3)
		Execute_TallyMaster("BarcodeAssign"; "Admin"; 1)
	: (Length:C16($iLoText8)=13)  //  &($auto=5))
		[Item:4]barCode:34:=$iLoText8
		// [Item]Profile6:="waspBarCode"
	Else 
End case 


