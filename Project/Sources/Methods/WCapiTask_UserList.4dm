//%attributes = {}
C_TEXT:C284($tableName; $vtRole; $vtFieldList; $vtPurpose)
C_OBJECT:C1216($obSel)
$obSel:=ds:C1482.Employee.query("active = true")
$tableName:="Employee"
$vtRole:="Sales"
$vtPurpose:="list"
$vtFieldList:=API_GetFieldList($tableName; $vtRole; $vtPurpose)
vResponse:=API_EntityToText($obSel; $vtFieldList)
voState.result:=$tableName+" records in selection: "+String:C10($voSelection.length)