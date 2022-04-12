//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 04/15/21, 15:53:25
// ----------------------------------------------------
// Method: HFS_ParentName
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
	$0:=$obPath.parentFolder
End if 