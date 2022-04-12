//%attributes = {"publishedWeb":true}
//Procedure: JStart_LoadRpts
C_LONGINT:C283($myOK; $i; $cntFlds; $w)
C_TEXT:C284($fileName)
myDocName:=Storage:C1525.folder.jitF+"jitSetup"+Folder separator:K24:12+"UserReportsRecs"
If (HFS_Exists(myDocName)=1)
	$myOK:=1
Else 
	$myOK:=EI_OpenDoc(->myDocName; ->myDoc; "Load Standard Reports"; vDocType; ->v1)
	If ($myOK=1)
		CLOSE DOCUMENT:C267(myDoc)
	End if 
End if 
If ($myOK=1)
	Records_In(->[UserReport:46]; ->myDocName)
End if 


