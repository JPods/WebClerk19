jaFilesManage(True:C214; 2)
//  --  CHOPPED  AL_UpdateArrays(eExportFlds; -2)
// -- AL_SetSort(eExportFlds; 1)
//

//  --  CHOPPED  AL_UpdateArrays(eMatchList; -2)

C_LONGINT:C283(doShowImport)
If (doShowImport>0)
	If (doShowImport#curTableNum)
		CLEAR SET:C117("Imported")
		doShowImport:=0
	End if 
End if 