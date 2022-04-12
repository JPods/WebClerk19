
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-04-13T00:00:00, 21:13:09
// ----------------------------------------------------
// Method: [Counter].Input1.Variable31
// Description
// Modified: 04/13/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($ptField; $ptTable)
C_TEXT:C284($tableName)
C_LONGINT:C283($tableNum; $fieldNum; $theType)
$tableNum:=[QQQCounter:41]TableNum:4
$ptTable:=Table:C252($tableNum)
$fieldNum:=STR_GetUniqueFieldNum(Table name:C256([QQQCounter:41]TableNum:4))
$ptField:=Field:C253([QQQCounter:41]TableNum:4; $fieldNum)


SET DATABASE PARAMETER:C642($ptTable->; Table sequence number:K37:31; iLoLongInt5)
CREATE RECORD:C68($ptTable->)
iLoText:="Current UniqueID Number is "+String:C10($ptField->)+<>VCR+<>VCR+iLoText
DELETE RECORD:C58($ptTable->)