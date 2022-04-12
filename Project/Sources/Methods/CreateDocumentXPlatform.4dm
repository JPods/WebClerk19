//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 01/19/11, 15:39:14
// ----------------------------------------------------
// Method: CreateDocumentXPlatform
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TIME:C306($0)
C_TEXT:C284($1; $suffix; $path)
$theLen:=TXT_PositionLast($1; ".")  //find the extension
If ($theLen>0)  //found an suffix
	$suffix:=Substring:C12($1; $theLen+1)  //get suffix
	$path:=Substring:C12($1; 1; $theLen-1)  //get path
Else 
	$suffix:="txt"  //define as text suffix
	$path:=$1  //get path
End if 
If (Is macOS:C1572)  //see 4D LangRef
	$0:=Create document:C266($path+"."+$suffix)  //manage for macs
Else 
	$0:=Create document:C266($path; $suffix)  //manage for PCs
End if 