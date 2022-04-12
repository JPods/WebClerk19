//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/20/21, 19:10:50
// ----------------------------------------------------
// Method: Prs_UserSetToNewProcess
// Description
// 
//
// Parameters
// ----------------------------------------------------


$processName:=Table name:C256(ptCurTable)+" - UserSet "+String:C10(Count tasks:C335)
COPY SET:C600("userset"; "<>curSelSet")
<>ptCurTable:=ptCurTable
C_LONGINT:C283($childProcess)
UNLOAD RECORD:C212(ptCurTable->)
$childProcess:=New process:C317("Prs_UserSetNewWindow"; <>tcPrsMemory; $processName; Current process:C322)
APPEND TO ARRAY:C911(aChildProcesses; $childProcess)
vLastProcessLaunched:=$childProcess
