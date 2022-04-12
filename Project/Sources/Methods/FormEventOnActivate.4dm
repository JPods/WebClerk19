//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/09/06, 22:43:07
// ----------------------------------------------------
// Method: FormEventOnActivate
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (entryEntity#Null:C1517)
	TallyMasterPopuuScriptsGeneral(ptCurTable; "olo"; ""; "aLooLoScripts")
	TallyMasterPopuuScriptsGeneral(ptCurTable; "olo"; ""; "aLooLoQueries")
	TallyMasterPopuuScriptsGeneral(ptCurTable; "olo"; ""; "aLooLoOrderBy")
End if 
var $oRec : Object
// CLASSIC from Output to Input
$oRec:=ds:C1482[process_o.tableName].query("id = :1"; (STR_Get_idPointer(process_o.tableName)->)).first()
process_o.cur:=$oRec
process_o.old:=Null:C1517  // do not fill old because should never save from CLASSIC
process_o.id:=$oRec.id
