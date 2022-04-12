//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/08/11, 12:29:35
// ----------------------------------------------------
// Method: WccTableName
// Description
// 
//
// STR_GetFieldNumber
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($0)
If (($1>0) & ($1<=Get last table number:C254))
	$0:=Table name:C256($1)
End if 