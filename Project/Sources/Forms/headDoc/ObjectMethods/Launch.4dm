C_LONGINT:C283($error; $inc; $cnt)
C_OBJECT:C1216($obRec)
ARRAY TEXT:C222($atPaths; 0)
For each ($obRec; obDocSel)
	$path:=PathToSystem($obRec.path)
	$result:=Test path name:C476($path)
	Case of 
		: ($result=1)
			APPEND TO ARRAY:C911($atPaths; $path)
			//READ PICTURE FILE($path; vItemPict)
			AE_LaunchDoc($path)
		: ($result=0)
			BEEP:C151
			ConsoleLog("ERROR: Path is a folder")
		Else 
			BEEP:C151
			ConsoleLog("ERROR: "+String:C10($result)+"  FILE NOT FOUND\r"+$path)
	End case 
End for each 
