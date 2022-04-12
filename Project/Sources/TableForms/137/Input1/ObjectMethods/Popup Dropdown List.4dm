


Case of 
	: (ddPathToOriginal=1)
		
		If (Is macOS:C1572)
			OPEN URL:C673([Message:137]pathToOriginal:13; "BBedit")
		Else 
			OPEN URL:C673([Message:137]pathToOriginal:13; "TextEdit")
		End if 
		
	: (ddPathToOriginal=2)
		
		OPEN URL:C673([Message:137]pathToOriginal:13; "Outlook")
		
End case 