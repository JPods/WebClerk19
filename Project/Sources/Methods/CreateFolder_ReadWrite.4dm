//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/08/09, 13:42:54
// ----------------------------------------------------
// Method: CreateFolder_ReadWrite
// Description
// 
//		LAUNCH EXTERNAL PROCESS("chmod -R a+rwx "+Storage.folder.jitLabelsF)
//  LAUNCH EXTERNAL PROCESS("chmod -R 777 .")
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $thePath)
$thePath:=PathToSystem($1)
CREATE FOLDER:C475($thePath; *)


