//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-05-26T00:00:00, 08:48:04
// ----------------------------------------------------
// Method: OutputFormAllRecords
// Description
// Modified: 05/26/13
// 
// 
//
// Parameters
// ----------------------------------------------------
KeyModifierCurrent
If (OptKey=1)
	process_o.ents:=ds:C1482[process.tableName].all()
End if 
Form:C1466.ents:=process_o.ents
booSorted:=False:C215
MenuTitle
