//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/15/10, 13:14:37
// ----------------------------------------------------
// Method: jAddRelated
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($ptCurTable)
$ptCurTable:=ptCurTable
myOK:=5003  //force a selection behavior
File_Select("Select the Table.")
<>ptCurTable:=$ptCurTable
ptCurTable:=$ptCurTable
If (myOK=5003)
	Process_AddRecord(Table name:C256($ptCurTable))
End if 