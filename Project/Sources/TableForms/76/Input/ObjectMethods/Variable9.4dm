// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 02/21/11, 14:30:01
// ----------------------------------------------------
// Method: Object Method: [EDISetID].iEDISetIDs_9.b3
// Description
// Modified: 02/21/11
// 
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($theText)

$theText:=Get_FolderName("Source/Destination Folder"; "")  //###_jwm_### 20110221
If ($theText#"")
	[EDISetID:76]SrcDestFolder:8:=$theText
End if 