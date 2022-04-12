C_LONGINT:C283($error; $inc; $cnt)
C_OBJECT:C1216($obRec; $obDocSet; $obSel)
ARRAY TEXT:C222($atPaths; 0)


C_LONGINT:C283($error; $inc; $cnt)
C_OBJECT:C1216($obRec)
ARRAY TEXT:C222($atPaths; 0)
C_TEXT:C284($vtOpenThese)

If (Is macOS:C1572)
	$vtOpenThese:="osascript -e 'tell application \"Finder\""+"\r"
	$vtOpenThese:=$vtOpenThese+"set thePictures to  {"
	For each ($obRec; LB_Document_cur)
		$path:=PathToSystem($obRec.path)
		$result:=Test path name:C476($path)
		Case of 
			: ($result=1)
				$vtOpenThese:=$vtOpenThese+"\""+$path+"\","
			: ($result=0)
				BEEP:C151
				ConsoleMessage("ERROR: Path is a folder")
			Else 
				BEEP:C151
				ConsoleMessage("ERROR: "+String:C10($result)+"  FILE NOT FOUND\r"+$path)
		End case 
	End for each 
	$vtOpenThese:=Substring:C12($vtOpenThese; 1; Length:C16($vtOpenThese)-1)+"}"+"\r"
	$vtOpenThese:=$vtOpenThese+"tell application \"Finder\" to open thePictures using application file id \"com.apple.preview\""+"\r"
	$vtOpenThese:=$vtOpenThese+"end tell'"
	LAUNCH EXTERNAL PROCESS:C811($vtOpenThese)
Else 
	For each ($obRec; LB_Document_cur)
		$path:=PathToSystem($obRec.path)
		$result:=Test path name:C476($path)
		Case of 
			: ($result=1)
				APPEND TO ARRAY:C911($atPaths; $path)
				//READ PICTURE FILE($path; vItemPict)
				AE_LaunchDoc($path)
			: ($result=0)
				BEEP:C151
				ConsoleMessage("ERROR: Path is a folder")
			Else 
				BEEP:C151
				ConsoleMessage("ERROR: "+String:C10($result)+"  FILE NOT FOUND\r"+$path)
		End case 
	End for each 
End if 