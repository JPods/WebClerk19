//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/25/13, 02:19:28
// ----------------------------------------------------
// Method: Prs_UserSetNewWindow
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $processParent)
C_TEXT:C284($2; $title)
C_TEXT:C284($3; $script1; $4; $script2; $5; $script3; $6; $script4; $7; $script5)
DELAY PROCESS:C323(Current process:C322; 15)
DELAY PROCESS:C323(Current process:C322; <>delayProcessUnload)  // 

C_LONGINT:C283($viProcess)
$viProcess:=Current process:C322
SET MENU BAR:C67(6; $viProcess; *)
Process_InitLocal

ptCurTable:=<>ptCurTable
USE SET:C118("<>curSelSet")
CLEAR SET:C117("<>curSelSet")

UNLOAD RECORD:C212(ptCurTable->)
$isunlocked:=Prs_unlockedRecords(ptCurTable)

Prs_DisplaySelected