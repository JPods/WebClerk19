
If (False:C215)  // ### JWM ### 20171013_1629 DONT DO THIS HERE
	If ([WebClerk:78]PathTojitWeb:16#"")
		If ([WebClerk:78]PathTojitWeb:16[[Length:C16([WebClerk:78]PathTojitWeb:16)]]#<>FOLDERSEPARATOR)
			[WebClerk:78]PathTojitWeb:16:=[WebClerk:78]PathTojitWeb:16+<>FOLDERSEPARATOR
			<>WebFolder:=[WebClerk:78]PathTojitWeb:16
		End if 
	End if 
End if 
