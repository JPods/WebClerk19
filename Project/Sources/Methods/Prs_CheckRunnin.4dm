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

C_LONGINT:C283($i; $k; $found; $0; $state_i)
C_TEXT:C284($1)
var $processNum : Integer
$0:=0
//$k:=Count tasks
//For ($i; 1; $k)
$processNum:=Process number:C372($1)
If ($processNum>0)
	$state_i:=Process state:C330($processNum)
	If ($state_i<0)
		$0:=0
	Else 
		$0:=$processNum
	End if 
	//return 
End if 
//End for 
