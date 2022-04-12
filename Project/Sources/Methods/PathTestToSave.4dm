//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/02/21, 20:20:00
// ----------------------------------------------------
// Method: PathTestToSave
// Description
// 
// Parameters
// ----------------------------------------------------
// test to see if path to server works
var $0; $1; $target_t : Text
If (Count parameters:C259=1)
	$target_t:=$1
Else 
	$target_t:="jitExports"
End if 
$0:=Storage:C1525.paths.jitF
If (Storage:C1525.paths[$target_t]#Null:C1517)
	If (Test path name:C476(Storage:C1525.paths[$target_t])=0)
		$0:=Storage:C1525.paths[$target_t]
	End if 
End if 