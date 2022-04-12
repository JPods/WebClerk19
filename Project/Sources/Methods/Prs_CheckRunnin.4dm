//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-10T00:00:00, 09:39:41
// ----------------------------------------------------
// Method: Prs_CheckRunnin
// Description
// Modified: 01/10/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($i; $k; $found; $0)
C_TEXT:C284($1)
$0:=0
var $processNum : Integer
$processNum:=Process number:C372($1)
If ($processNum>0)
	$found:=Find in array:C230(<>aPrsNum; $processNum)  // the found number is used in the next procedure to select process
	If ($found>0)
		$0:=$found
	Else 
		$0:=0
	End if 
End if 
// Prs_ListActive