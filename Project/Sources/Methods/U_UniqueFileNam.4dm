//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/18/20, 14:09:40
// ----------------------------------------------------
// Method: U_UniqueFileNam
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($0)  //a unique file name based on the orginal name
C_TEXT:C284($1; $Path)  //The path to check for a unique file name
$Path:=$1
C_TEXT:C284($2; $OrigName; $suffix; $WorkingName)
$WorkingName:=$2
C_LONGINT:C283($i; $p)
C_TEXT:C284($cntExtend)
$cntExtend:=""
C_LONGINT:C283($Count)
$Count:=0
$p:=Position:C15("."; $WorkingName)
$suffix:=""
//TRACE
If ($p>1)
	$OrigName:=Substring:C12($WorkingName; 1; $p-1)
	$suffix:=Substring:C12($WorkingName; $p)
Else 
	$OrigName:=$WorkingName
End if 
// ### bj ### 20200118_1407

While (Test path name:C476($Path+$OrigName+$cntExtend+$suffix)=1)
	$Count:=$Count+1
	$cntExtend:="-"+String:C10($Count)
End while 
$0:=$OrigName+$cntExtend+$suffix