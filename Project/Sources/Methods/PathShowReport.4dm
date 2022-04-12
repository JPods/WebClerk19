//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/17/19, 01:18:09
// ----------------------------------------------------
// Method: PathShowReport
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($theFolder)
If ([UserReport:46]template:7#"")
	$theFolder:=HFS_ParentName([SyncRecord:109]pathToDocument:18)
End if 
If (Test path name:C476($theFolder)#0)
	$theFolder:=Storage:C1525.folder.jitQRsF
End if 
PathLaunchFolder($theFolder)