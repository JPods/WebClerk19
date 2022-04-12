//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/29/21, 16:03:25
// ----------------------------------------------------
// Method: 0019FixPaths
// Description
// 
// Parameters
// ----------------------------------------------------

var $2; $fieldName_t; $1; $tableName; $3; $find_t; $4; $replace_t : Text
$tableName:=$1
$fieldName_t:=$2
If (Count parameters:C259>2)
	$find_t:=$3
	$replace_t:=$4
Else 
	$find_t:="/customers/"
	$replace_t:="/customer/"
End if 
CONFIRM:C162("Replaced: "+$find_t+" with "+$replace_t+" in "+$tableName+"."+$fieldName_t)
If (OK=1)
	var $rec_o; $sel_o : Object
	$sel_o:=ds:C1482[$tableName].all()
	For each ($rec_o; $sel_o)
		If (Position:C15($find_t; $rec_o[$fieldName_t])>0)
			$rec_o[$fieldName_t]:=Replace string:C233($rec_o[$fieldName_t]; $find_t; $replace_t)
			$rec_o.save()
		End if 
	End for each 
	ALERT:C41("Complete, replaced: "+$find_t+" with "+$replace_t+" in "+$tableName+"."+$fieldName_t)
End if 
