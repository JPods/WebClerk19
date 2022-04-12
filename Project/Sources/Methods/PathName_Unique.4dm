//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/21/20, 18:16:13
// ----------------------------------------------------
// Method: PathName_Unique
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0)  //a unique file name based on the orginal name
C_TEXT:C284($1; $Path)  //The path to check for a unique file name
C_LONGINT:C283($Count)
$Path:=$1
C_TEXT:C284($2; $OrigName; $suffix; $WorkingName)
$OrigName:=$2
If (Count parameters:C259>2)
	$suffix:=$3
Else 
	$suffix:=".txt"
End if 

If (Position:C15("."; $suffix)#1)
	$suffix:="."+$suffix
End if 

If (Test path name:C476($Path)#0)
	CREATE FOLDER:C475($Path; *)
End if 
If (error#0)
	$0:="Folder Error"
Else 
	C_LONGINT:C283($i; $p)
	C_TEXT:C284($cntExtend)
	// ### bj ### 20200118_1407
	$cntExtend:=""
	While (Test path name:C476($Path+$OrigName+$cntExtend+$suffix)=1)
		$Count:=$Count+1
		$cntExtend:="-"+String:C10($Count; "00")
	End while 
	$0:=$OrigName+$cntExtend+$suffix
End if 