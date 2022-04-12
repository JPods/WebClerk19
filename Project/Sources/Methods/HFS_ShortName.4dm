//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/09/19, 19:09:26
// ----------------------------------------------------
// Method: HFS_ShortName
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; $1)
$0:=""
C_OBJECT:C1216($obPath)
If ($1#"")
	$obPath:=Path to object:C1547($1)
	$0:=$obPath.name+$obPath.extension
	//$obPath.parentFolder="/first/"
	//$obPath.name="second"
	//$obPath.extension=".bundle"
	//$obPath.isFolder=true
End if 

