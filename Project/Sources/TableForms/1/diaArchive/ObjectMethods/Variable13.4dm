BEEP:C151
If (Not:C34((b20=0) & (b21=0) & (b22=0) & (b23=0)))
	CONFIRM:C162("You are about to PERMANENTLY archive and REMOVE "+String:C10(Records in selection:C76(Table:C252(curTableNum)->))+" records from File "+Table name:C256(curTableNum)+"!")
	If (OK=1)
		CONFIRM:C162("Are you truely SERIOUS, this is your last WARNING?!?!?")
		If (OK=1)
			MESSAGES OFF:C175  //don't display the 4D progress thermometers      
			StructureFields(curTableNum)
			ptFile:=Table:C252(curTableNum)
			DEFAULT TABLE:C46(ptFile->)
			ARRAY TEXT:C222(aMatchField; 0)
			ARRAY TEXT:C222(aMatchType; 0)
			ARRAY LONGINT:C221(aMatchNum; 0)
			jArchExportRay
			jArchExportAll
			If (OK=1)
				If (curTableNum=Table:C252(->[PO:39]))
					READ WRITE:C146([QQQPOLine:40])
					FIRST RECORD:C50([PO:39])
					For ($i; 1; Records in selection:C76([PO:39]))
						QUERY:C277([QQQPOLine:40]; [QQQPOLine:40]poNum:1=[PO:39]poNum:5)
						DELETE SELECTION:C66([QQQPOLine:40])
						NEXT RECORD:C51([PO:39])
					End for 
					READ ONLY:C145([QQQPOLine:40])
				End if 
				DELETE SELECTION:C66(Table:C252(curTableNum)->)  //delete all the current records    
			End if 
		End if 
	End if 
Else 
	ALERT:C41("Select the File to Archive.")
End if 