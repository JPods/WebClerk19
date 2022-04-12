C_TEXT:C284($tempFold; $testName; $testPath; $longName)

$longName:=Select folder:C670("Select jitWeb folder.")
If ($longName#"")
	<>WebFolder:=WebClerkPathToFolder($longName)
	[WebClerk:78]PathTojitWeb:16:=<>WebFolder
End if 