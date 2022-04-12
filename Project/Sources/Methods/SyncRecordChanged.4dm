//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/24/06, 08:55:06
// ----------------------------------------------------
// Method: SyncRecordChanged
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_LONGINT:C283($theRecordNum; $0)
newRecordSync:=False:C215
$theRecordNum:=Record number:C243($1->)
$0:=$theRecordNum
