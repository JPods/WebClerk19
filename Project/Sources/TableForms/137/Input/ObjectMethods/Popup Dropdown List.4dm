

C_LONGINT:C283($viResult)
C_TEXT:C284($vtResult)



Case of   // filter by form event
	: (Form event code:C388=On Data Change:K2:15)
		
		$viResult:=Test path name:C476([Message:137]pathToOriginal:13)
		$vtResult:=String:C10($viResult)
		
		Case of   // check result of test path name
				
			: ($viResult=1)  // document
				
				Case of   // drop down choice
					: (ddPathToOriginal=1)  // open as Text
						
						If (Is macOS:C1572)
							OPEN URL:C673([Message:137]pathToOriginal:13; "BBEdit"; *)
						Else 
							OPEN URL:C673([Message:137]pathToOriginal:13; "TextEdit"; *)
						End if 
						
					: (ddPathToOriginal=2)  // Open as Email
						
						OPEN URL:C673([Message:137]pathToOriginal:13; "Outlook"; *)
						
				End case 
				
			: ($viResult=0)  // folder
				ALERT:C41("Error :"+$vtResult+" Path is a folder")
				
			: ($viResult=-43)  // Not Found
				ALERT:C41("Error: "+$vtResult+" File Not Found")
				
			Else   // unknown
				
				ALERT:C41("Error: "+$vtResult+" Unknown Error")
				
		End case 
End case 
