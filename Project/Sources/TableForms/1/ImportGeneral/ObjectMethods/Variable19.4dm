C_LONGINT:C283(bImport; $myOK)
BEEP:C151
ON ERR CALL:C155("jOECNoAction")
CLOSE DOCUMENT:C267(myDoc)
ON ERR CALL:C155("")
myDocName:=""
//TRACE
$myOK:=EI_OpenDoc(->myDocName; ->myDoc; "Open File to Import"; ""; Storage:C1525.folder.jitExportsF)  //;jitQRsF
If ($myOK=1)
	vCount:=0
	
	C_LONGINT:C283(doShowImport)
	If (doShowImport>0)
		CLEAR SET:C117("Imported")
		doShowImport:=0
	End if 
	
	
	jimpGenImpArray
	vDiaCom:=myDocName
	
	//  --  CHOPPED  AL_UpdateArrays(eImportList; -2)
	
End if 

