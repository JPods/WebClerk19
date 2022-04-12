Case of 
	: (Form event code:C388=On Load:K2:1)
		bMakeUnique:=0
		curTableNum:=Table:C252(ptCurTable)
		//End if 
		StructureFields(curTableNum)
	: (After:C31)
		Temp_RayInit
	: (Outside call:C328)
		Prs_OutsideCall
	Else 
		If (doSearch=1)
			CONFIRM:C162("This change CANNOT be undone.  Are you very sure you want this change.")
			If (OK=1)
				READ WRITE:C146(Table:C252(curTableNum)->)
				jappMultipleRec
				ReadOnlyFiles
			End if 
		End if 
End case 