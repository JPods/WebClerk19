C_TEXT:C284($tempFold; $testName; $testPath; $longName)

$longName:=Select folder:C670("Select jitWeb folder.")
If ($longName#"")
	<>tcServerFarm:=WebClerkPathToFolder($longName)
	[WebClerk:78]PathToRemote:17:=<>tcServerFarm
End if 