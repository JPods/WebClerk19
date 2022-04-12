//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/12/21, 21:48:10
// ----------------------------------------------------
// Method: WCapiTask_GetKanban
// Description
// REF: https://bitbucket.org/TheDiligentDev/vue-kanban-board/src/master/
// REF: Example coding:  https://www.youtube.com/watch?v=E8f5JR-K5DI
// REF: https://ej2.syncfusion.com/vue/documentation/kanban/cards/
//let kanbanData = [
//     {
//         'Id': 1,
//         'Status': 'Open',
//         'Summary': 'Analyze the new requirements gathered from the customer.',
//         'Type': 'Story',
//         'Priority': 'Low',
//         'Tags': 'Analyze,Customer',
//         'Estimate': 3.5,
//         'PerCent': 20,
//         'Assignee': 'Nancy Davloio',
//         'RankId': 1,
//         'Link':""
//     },
//     {
//         'Id': 2,
//         'Status': 'InProgress',
//         'Summary': 'Improve application performance',
//         'Type': 'Improvement',
//         'Priority': 'Normal',
//         'Tags': 'Improvement',
//         'Estimate': 6,
//         'PerCent': 40,
//         'Assignee': 'Andrew Fuller',
//         'RankId': 1,
//         'Link':""
//     },
// Parameters
// ----------------------------------------------------
If (False:C215)
	ALL RECORDS:C47([Task:140])
	DELETE SELECTION:C66([Task:140])
End if 
C_OBJECT:C1216($obRec; $obSel; $obTab; $obTables)
C_COLLECTION:C1488($cTables)
C_TEXT:C284($vtObjective)
$vtObjective:=WCapi_GetParameter("idObjective")
If ($vtObjective="")
	$obSel:=ds:C1482.Task.query("Why = :1"; "Primary")
Else 
	$obSel:=ds:C1482.Task.query("idObjective = :1"; $vtObjective)
End if 

///zzzz add all employees
If ($obSel=Null:C1517)
	vResponse:="[]"
Else 
	$vtRole:="Sales"
	$vtPurpose:="list"
	$vtFieldList:=API_GetFieldList("Task"; $vtRole; $vtPurpose)
	If (Length:C16($vtFieldList)<30)
		$vtFieldList:="action,actionBy,actionDate,actionTime,comment,difficulty,dtComplete,dtInitiate,dtPlanned,hours,id,idNum,idObjective,lat,lng,obDetail,obExternal,obGeneral,obRelate,obSync,priority,quality,state,status,why"
	End if 
	vResponse:=API_EntityToText($obSel; $vtFieldList)
	voState.result:=$vtTableLine+" records in selection: "+String:C10($obSel.length)
End if 