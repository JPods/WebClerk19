//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-07-30T00:00:00, 21:09:40
// ----------------------------------------------------
// Method: UUIDFieldNum
// Description
// Modified: 07/30/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1)
C_LONGINT:C283($fldNum; $0)
$fldNum:=STR_GetFieldNumber(Table name:C256($1); "id")
$0:=$fldNum