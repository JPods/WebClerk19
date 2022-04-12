//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-06T00:00:00, 01:42:39
// ----------------------------------------------------
// Method: Prs_SycSend
// Description
// Modified: 11/06/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

<>synProcesses:=<>synProcesses+1  // add to the governor count as process begins
C_LONGINT:C283($1; $2; $3)
READ ONLY:C145([SyncRelation:103])
READ ONLY:C145([SyncExchange:104])
GOTO RECORD:C242([SyncRelation:103]; $1)
GOTO RECORD:C242([SyncExchange:104]; $2)
GOTO RECORD:C242([SyncRecord:109]; $3)

RP_LoadVariablesRelationship  // setup the communications
eventID_Cookie:=[SyncExchange:104]cookie:2

HTTP_Path:=HTTP_Path+"&Cookie="+eventID_Cookie

$error:=RP_BlobSendRecord  // ($comment)

<>synProcesses:=<>synProcesses-1  // reduce the governor count as process finishes


