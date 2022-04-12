//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/26/06, 05:01:06
// ----------------------------------------------------
// Method: PathLaunchFolder
// Description
// 
//
// Parameters
// ----------------------------------------------------

//PathToUniversal
//PathtoSystem

//   // ### bj ### 20210612_1859
// Break this into launch and make procedures
ON ERR CALL:C155("jOECNoAction")
C_BOOLEAN:C305($fail)
$fail:=True:C214
C_TEXT:C284($1; $folder; vFolderPath; $thePath)
If (Count parameters:C259>0)
	$folder:=$1
	$folder:=PathToSystem($folder)
	$thePath:=$folder
	If (Test path name:C476($thePath)=0)
		$fail:=False:C215
	Else 
		CREATE FOLDER:C475($thePath; *)
		If (Test path name:C476($thePath)=0)
			$fail:=False:C215
		Else 
			If (Substring:C12($thePath; 1; 2)="\\\\")
				$thePath:=Substring:C12($thePath; 3)
			End if 
			$thePath:=Replace string:C233($thePath; "\\"; ":")  //  (ServerName\ShareName\PathToFile)
			$thePath:=Replace string:C233($thePath; "::"; ":")  // clear single letter drive :
			ARRAY TEXT:C222($atPath; 0)
			TextToArray($thePath; ->$atPath; ":"; False:C215)  // split the path into folders
			ARRAY TEXT:C222($aVolumes; 0)
			VOLUME LIST:C471($aVolumes)
			If (Size of array:C274($atPath)>0)
				If (Find in array:C230($aVolumes; $atPath{1})>0)
					C_LONGINT:C283($result)
					If ($folder#"BadPath:@")
						If (Test path name:C476($folder)#0)
							If (error#-37)
								CREATE FOLDER:C475($folder; *)
							End if 
						End if 
						$fail:=False:C215
					End if 
				End if 
			End if 
		End if 
	End if 
End if 

Case of 
	: ($fail)
		
	: (Is macOS:C1572)
		$externalPath:="osascript -e 'tell application "+Txt_Quoted("Finder")+"\r"+" open folder "+Txt_Quoted($folder)+"\r"+"activate"+"\r"+" end tell'"
		LAUNCH EXTERNAL PROCESS:C811($externalPath)
	Else 
		$folder:="cmd.exe /C start "+$folder
		LAUNCH EXTERNAL PROCESS:C811($folder)
End case 
ON ERR CALL:C155("")

// works
// vText1:="osascript -e 'tell application "+Txt_Quoted("Finder")+"\r"+" open folder "+Txt_Quoted("ACTshare")+"\r"+"activate"+"\r"+" end tell'"
// LAUNCH EXTERNAL PROCESS(vText1)

// works
// vText1:="osascript -e 'tell application "+Txt_Quoted("Finder")+"\r"+" open folder "+Txt_Quoted("ACTshare:CommerceExpert:Customers:1003712")+"\r"+"activate"+"\r"+" end tell'"
// LAUNCH EXTERNAL PROCESS(vText1)

// fails
//vText1:="osascript -e 'tell application "+Txt_Quoted("Finder")+"\r"+" open folder "+Txt_Quoted("ACTshare/CommerceExpert/Customers/1003712")+"\r"+"activate"+"\r"+" end tell'"
//LAUNCH EXTERNAL PROCESS(vText1)