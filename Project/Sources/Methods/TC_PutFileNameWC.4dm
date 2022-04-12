//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/20/09, 13:59:46
// ----------------------------------------------------
// Method: TC_PutFileNameWC
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $2; $3; $0; $dialogTitle; $docmentName; $defaultFolder; $docName; $pathName)
C_LONGINT:C283($error)
$dialogTitle:="Save File As"
$docmentName:="NameOfDocument.txt"
$defaultFolder:=Storage:C1525.folder.jitExportsF
If (Count parameters:C259>0)
	$dialogTitle:=$1
	If (Count parameters:C259>1)
		$docmentName:=$2
		If (Count parameters:C259>2)
			$defaultFolder:=$3
			
		End if 
	End if 
End if 
//$error:=TC PutFileDlog ($docmentName;$dialogTitle;$defaultFolder;$pathName)
// Modified by: williamjames (8/11/12)
//I do not like that we cannot state the file name we want this named.



$docRef:=Create document:C266("")
If (OK=1)
	$pathName:=document
	CLOSE DOCUMENT:C267($docRef)
	$0:=$pathName
Else 
	$0:=""
End if 