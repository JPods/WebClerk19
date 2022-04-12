//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/16/18, 18:31:04
// ----------------------------------------------------
// Method: pathToBrowser
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; $1; $thePath)
$thePath:=$1
If (Is macOS:C1572)
	$0:="file://"+Convert path system to POSIX:C1106($thePath; *)
Else 
	If (Substring:C12($thePath; 1; 2)="\\\\")
		$thePath:=Substring:C12($thePath; 3)
	End if 
	$thePath:=Replace string:C233($thePath; "\\"; ":")
	$thePath:=Replace string:C233($thePath; "::"; ":")
	$thePath:=Replace string:C233($thePath; "/"; ":")
	$0:="file://"+$thePath
End if 