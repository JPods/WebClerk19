//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/17/21, 00:59:38
// ----------------------------------------------------
// Method: LogAbandonedNumber
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $viTableNum; $2; $viValue)
C_OBJECT:C1216($voRec)
$voRec:=ds:C1482.Log.new()
$voRec.dateCreated:=Current date:C33
$voRec.fieldValue1:=String:C10($2)
$voRec.tableName1:=Table name:C256($1)
$voRec.user:=Current user:C182
$result_o:=$voRec.save()
ConsoleLog($voRec.tableName1+": "+$voRec.fieldValue1+" abandoned, LogReport: "+String:C10($voRec.uniqueId))