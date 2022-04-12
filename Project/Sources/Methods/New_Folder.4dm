//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/08/09, 12:23:55
// ----------------------------------------------------
// Method: New_Folder
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($0)
C_TEXT:C284($1; $document)
$document:=$1
CreateFolder_ReadWrite($document)
$0:=0