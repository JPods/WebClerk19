C_LONGINT:C283(bimpSave; $err)
If ((Size of array:C274(aMatchField)=Size of array:C274(aImpFields)) & ((Size of array:C274(aMatchField)>0) & (Size of array:C274(aImpFields)>0)))
	If ((aMatchField{1}=aImpFields{1}) | (Character code:C91(aImpFields{1})=13))
		ALERT:C41("Clear Header First")
	Else 
		BEEP:C151
		READ WRITE:C146(Table:C252(curTableNum)->)
		//TRACE
		C_LONGINT:C283(doShowImport)
		If (doShowImport=0)
			doShowImport:=curTableNum
			CREATE EMPTY SET:C140(Table:C252(doShowImport)->; "Imported")
		End if 
		
		ImportScriptLoad("ImportScript"; vtallyMastersName)
		
		
		$err:=jimportSaveRec(1)
		//  --  CHOPPED  AL_UpdateArrays(eImportList; -2)
	End if 
Else 
	ALERT:C41("The Import and Matching Fields are not the same size.")
End if 