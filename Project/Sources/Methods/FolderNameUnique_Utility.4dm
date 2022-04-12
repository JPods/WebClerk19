//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-09-21T00:00:00, 20:19:06
// ----------------------------------------------------
// Method: FolderNameUnique_Utility
// Description
// Modified: 09/21/16
// 
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $folderName; $2; $baseText; $0)
C_LONGINT:C283($maxTries; $adder; $countTries)
$maxTries:=99
$0:=""
If (Count parameters:C259=2)
	$folderName:=$1
	$baseText:=$2
	$adder:=0
	Repeat 
		$countTries:=$countTries+1
		If ($adder=0)
			$theFolder:=$folderName+$baseText+"_"+Date_strYrMmDd
		Else 
			$theFolder:=$folderName+$baseText+"_"+Date_strYrMmDd+"_"+String:C10($adder; "00")
		End if 
		$folderNew:=Test path name:C476($theFolder)
		If ($folderNew=0)  // folder exists
			$adder:=$adder+1
		End if 
	Until (($folderNew<0) | ($countTries>$maxTries))
	If ($folderNew<0)
		CreateFolder_ReadWrite($theFolder)
		$0:=$theFolder+Folder separator:K24:12
	End if 
End if 