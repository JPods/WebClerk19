//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-08-22T00:00:00, 11:49:52
// ----------------------------------------------------
// Method: TallyInventory
// Description
// Modified: 08/22/13
// 
// 
//
// Parameters
// ----------------------------------------------------

// Use this in cronjobs also.
REDUCE SELECTION:C351([DInventory:36]; 0)
C_LONGINT:C283($processNum)
$processNum:=New process:C317("TallyInventoryProcess"; <>tcPrsMemory; String:C10(Count user processes:C343)+"- TallyInventory")