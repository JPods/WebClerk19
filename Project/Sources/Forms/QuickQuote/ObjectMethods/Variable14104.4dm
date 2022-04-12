
If (vImagePath#"")
	$vtPath:=PathToSystem(vImagePath)
	$viResult:=Test path name:C476($vtPath)
	Case of 
		: ($viResult=1)
			//READ PICTURE FILE($vtPath;$thePict)
			OPEN URL:C673($vtPath)
		: ($viResult=0)
			ConsoleMessage("ERROR: Path is a folder")
		Else 
			ConsoleMessage("ERROR: "+String:C10($viResult)+"  FILE NOT FOUND\r"+$vtPath)
	End case 
End if 