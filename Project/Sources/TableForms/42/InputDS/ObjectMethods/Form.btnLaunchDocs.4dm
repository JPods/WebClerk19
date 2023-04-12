C_LONGINT:C283($error; $inc; $cnt)
C_OBJECT:C1216($obRec; $obDocSet; $obSel)
ARRAY TEXT:C222($atPaths; 0)


C_LONGINT:C283($error; $inc; $cnt)
C_OBJECT:C1216($obRec)
ARRAY TEXT:C222($atPaths; 0)
C_TEXT:C284($vtOpenThese)

If (Is macOS:C1572)
	$vtOpenThese:="osascript -e 'tell application \"Finder\""+<>vCR
	$vtOpenThese:=$vtOpenThese+"set thePictures to  {"
	For each ($obRec; Form:C1466.LBDocument_sel)
		$path:=PathToSystem($obRec.path)
		$result:=Test path name:C476($path)
		Case of 
			: ($result=1)
				$vtOpenThese:=$vtOpenThese+"\""+$path+"\","
			: ($result=0)
				BEEP:C151
				ConsoleLog("ERROR: Path is a folder")
			Else 
				BEEP:C151
				ConsoleLog("ERROR: "+String:C10($result)+"  FILE NOT FOUND\r"+$path)
		End case 
	End for each 
	$vtOpenThese:=Substring:C12($vtOpenThese; 1; Length:C16($vtOpenThese)-1)+"}"+<>vCR
	$vtOpenThese:=$vtOpenThese+"tell application \"Finder\" to open thePictures using application file id \"com.apple.preview\""+<>vCR
	$vtOpenThese:=$vtOpenThese+"end tell'"
	LAUNCH EXTERNAL PROCESS:C811($vtOpenThese)
Else 
	For each ($obRec; Form:C1466.LBDocument_cur)
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
End if 