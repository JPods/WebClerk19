// ----------------------------------------------------

// User name (OS): Jim Medlen

// Date and time: 02/21/11, 13:55:40

// ----------------------------------------------------

// Method: Object Method: [EDISetID].iEDISetIDs_9.b4

// Description

// Modified: 02/21/11

// 

// 

//

// Parameters

// ----------------------------------------------------



C_TEXT:C284($theText)

$theText:=Get_FolderName("Folder for Completed Document"; "")  //###_jwm_### 20110221

If ($theText#"")
	
	[EDISetID:76]CompletedFolder:9:=$theText
	
End if 

