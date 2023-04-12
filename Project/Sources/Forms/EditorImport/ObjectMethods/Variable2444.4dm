If (b52=1)
	CONFIRM:C162("Log deviations of import?")
	If (OK=1)
		$docName:="zzzImportDeviation.txt"
		$docName:=TC_PutFileNameWC("Name tracking document"; $docName)
		
		//TRACE
		If ($docName#"")
			itemMakeDoc:=Create document:C266($docName)
			If (OK=1)
				SEND PACKET:C103(itemMakeDoc; "Import log: "+Table name:C256(curTableNum)+": "+String:C10(Current date:C33)+"/"+String:C10(Current time:C178)+"\r")
			End if 
		End if 
	End if 
Else 
	If (itemMakeDoc>?00:00:00?)
		CLOSE DOCUMENT:C267(itemMakeDoc)
	End if 
End if 