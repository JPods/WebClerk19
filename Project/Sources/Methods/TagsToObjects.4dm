//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-12-18T00:00:00, 09:40:42
// ----------------------------------------------------
// Method: TagsToObjects
// Description
// Modified: 12/18/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($0; $strField; $myText; $myObjectFolder)
C_TEXT:C284($1)
If (Count parameters:C259=1)
	$myObject:=$1  // would be better to use PageGetObject (path/name of object)
Else 
	$myObject:=vWebTagField
End if 
C_TEXT:C284($myObject; $myText)
$myObject:=Replace string:C233($myObject; "/"; Folder separator:K24:12)
$myObjectFolder:=Storage:C1525.wc.webFolder+"jitObjects"+Folder separator:K24:12


// the jitObject must be listed with its path sub jitObjects folder. Nested objects are allowed
$myObjectWithPath:=$myObjectFolder+$myObject
// ### jwm ### 20150917_1102 test object path conversion
// Build full path name to match absolute path stored in array <>aWebObjectName
// jitObject is local posix/unix path inside jitObject folder 
// example: _jit_-3_/Customers/OrderMenu.txtjj
// NOTE: object names can NOT contain underscores use CamelCase names

//TRACE
// ### jwm ### 20150917_1102 end object path conversion

$field:=Find in array:C230(<>aWebObjectName; $myObjectWithPath)
If ($field>0)
	$0:=TagsToText(<>aWebObjectValue{$field})
Else 
	$0:=""
End if 