C_TEXT:C284($tempFold; $testName; $testPath; $longName)
KeyModifierCurrent

If (OptKey=0)
	C_TEXT:C284($tempFold; $testName; $testPath; $longName)
	$longName:=Select folder:C670("Select jitWeb folder.")
	If ($longName#"")
		<>jitHelpLocal:=$longName
	End if 
Else 
	PathLaunchFolder(<>jitHelpLocal)
End if 
