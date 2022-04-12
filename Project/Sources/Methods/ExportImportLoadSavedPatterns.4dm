//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-30T00:00:00, 15:14:58
// ----------------------------------------------------
// Method: ExportImportLoadSavedPatterns
// Description
// Modified: 11/30/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

ARRAY TEXT:C222($aImpPat; 0)
SELECTION TO ARRAY:C260([TallyMaster:60]name:8; $aImpPat; [TallyMaster:60]; theFldNum)
REDUCE SELECTION:C351([TallyMaster:60]; 0)
C_LONGINT:C283($k)
$k:=Size of array:C274($aImpPat)
ARRAY TEXT:C222(theFields; $k)
//  ARRAY LONGINT(THEFLDNUM;$k)  fixed in the selection to array
ARRAY TEXT:C222(THETYPES; $k)
ARRAY TEXT:C222(THEUNIQUES; $k)

C_LONGINT:C283($c; $k)
$k:=Size of array:C274(theFldNum)
For ($i; 1; $k)
	theFields{$i}:=Substring:C12($aImpPat{$i}; 1; 31)
	theTypes{$i}:="z"
	theUniques{$i}:=""
	//THEFLDNUM
End for 
//  --  CHOPPED  AL_UpdateArrays(eExportFlds; -2)
// -- AL_SetSort(eExportFlds; 1)