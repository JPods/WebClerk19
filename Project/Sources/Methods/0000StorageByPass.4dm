//%attributes = {}
//  QQQQQQ

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/04/21, 02:22:23
// ----------------------------------------------------
// Method: 0000StorageByPass
// Description
// 
// Parameters
// ----------------------------------------------------


var $byPass_o : Object
$byPass_o:=New shared object:C1526("bypass"; "no"; "byID"; "Not old")

Use (Storage:C1525)
	Storage:C1525.hacks:=New shared object:C1526
	Use (Storage:C1525.hacks)
		Storage:C1525.hacks:=$byPass_o
	End use 
End use 
var $str_t : Text

$str_t:=Storage:C1525.hacks.bypass
If (False:C215)
	Use (Storage:C1525)
		Storage:C1525.hacks:=New shared object:C1526
		Use (Storage:C1525.hacks)
			Storage:C1525.hacks.byID:="1"
		End use 
	End use 
	ALERT:C41(Storage:C1525.hacks.byID)
End if 