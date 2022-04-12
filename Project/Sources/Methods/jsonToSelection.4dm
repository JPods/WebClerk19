//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/18/19, 22:18:33
// ----------------------------------------------------
// Method: jsonToSelection
// Description
// 
//
// Parameters
// ----------------------------------------------------
// start by harvesting each array element
// then execute jsonToRecord for each record

C_OBJECT:C1216($obData)
$obData:=[SyncRecord:109]obGeneral:16

ARRAY OBJECT:C1221($aobBody; 0)
C_OBJECT:C1216($obHead)
C_OBJECT:C1216($obSync)
// jsonParsingToFlat
OB GET ARRAY:C1229($obData; "body"; $aobBody)
$obHead:=OB Get:C1224($obData; "head")
$obSync:=OB Get:C1224($obData; "SyncRecord")
RP_IncomingSyncRecord(->$obSync)


// keep the SyncRecord active during the entire unpacking process
// record progress and issues in PackingNotes




ARRAY OBJECT:C1221($aobBody; 0)
OB GET ARRAY:C1229($obData; "body"; $aobBody)
ARRAY TEXT:C222($atNames; 0)
ARRAY LONGINT:C221($aiTypes; 0)
OB GET PROPERTY NAMES:C1232($objPattern; $atNames; $aiTypes)

C_LONGINT:C283($fia)
$fia:=Find in array:C230($aobBody; "Contact")