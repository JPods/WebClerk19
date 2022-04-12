// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-12-16T00:00:00, 23:28:35
// ----------------------------------------------------
// Method: [Control].importGeneral.Variable22
// Description
// Modified: 12/16/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


If ((Size of array:C274(aMatchField)=Size of array:C274(aImpFields)) & (Size of array:C274(aMatchField)>0))
	KeyModifierCurrent
	
	CONFIRM:C162("This change CANNOT be undone.  Are you very sure you want this change.")
	If (OK=1)
		If (OptKey=1)
			CONFIRM:C162("Import repeating fields from FileMaker?")
			If (OK=1)
				READ WRITE:C146(Table:C252(curTableNum)->)
				import_FileMkRe(Char:C90(9); Char:C90(29); Char:C90(13); Table:C252(curTableNum))
			End if 
		Else 
			
			C_LONGINT:C283(doShowImport)
			If (doShowImport=0)
				doShowImport:=curTableNum
				CREATE EMPTY SET:C140(Table:C252(doShowImport)->; "Imported")
			End if 
			C_TEXT:C284(scriptBegin; scriptRecord; scriptEnd)
			scriptBegin:=""  // execute at filling arrays, before saving.
			scriptRecord:=""  // execute after filling the record from array before saving.
			scriptEnd:=""  // execute after all records are completed
			
			ImportScriptLoad("ImportScript"; vtallyMastersName)
			
			OK:=1
			If (aMatchField{1}=aImpFields{1})
				If (cmdKey=1)
					OK:=1
				Else 
					CONFIRM:C162("Clear header?")
				End if 
			Else 
				OK:=jimportSaveRec(2)
			End if 
			If (OK=1)
				vCount:=0
				OK:=jimport_FillRay
				READ WRITE:C146(Table:C252(curTableNum)->)
				jimpMultipleRec
				
				If (scriptEnd#"")
					ExecuteText(0; scriptEnd)
				End if 
				//  --  CHOPPED  AL_UpdateArrays(eImportList; -2)
				
			End if 
		End if 
	Else 
		ALERT:C41("There are not an equal number of Import and Matching Fields.")
	End if 
End if 
// Modified by: Bill James (2015-02-16T00:00:00 close the Themo Window)
If (<>ProcThermoProcess>0)
	SET PROCESS VARIABLE:C370(<>ProcThermoProcess; vNewThermometer; -2)
	//setting vNewThermometer to -2 in the Thermo window cancel the window and closes the process
	POST OUTSIDE CALL:C329(<>ProcThermoProcess)
End if 