//%attributes = {}
// ### jwm ### 20181217_1023 test this
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 08/20/18, 18:47:36
// ----------------------------------------------------
// Method: FolderMove
// Description
// gkgkgk
// gmgmgm
// ### jwm ### 20180911_1932   added
// Parameters
// ----------------------------------------------------
If (False:C215)
	$old_jitF:=HFS_ParentName(Application file:C491)
	
	If (False:C215)
		C_TEXT:C284($thePath)  // options
		$thePath:=System folder:C487(User preferences_all:K41:3)+"CommerceExpert"+Folder separator:K24:12
		$thePath:=System folder:C487(User preferences_user:K41:4)+"CommerceExpert"+Folder separator:K24:12
		$thePath:=System folder:C487(Startup Win_all:K41:5)+"CommerceExpert"+Folder separator:K24:12
		$thePath:=System folder:C487(Startup Win_user:K41:6)+"CommerceExpert"+Folder separator:K24:12
	End if 
	
	
	ARRAY TEXT:C222($arrayFolders; 0)
	APPEND TO ARRAY:C911($arrayFolders; "jitCerts")
	APPEND TO ARRAY:C911($arrayFolders; "jitHelp")
	APPEND TO ARRAY:C911($arrayFolders; "jitShip")
	APPEND TO ARRAY:C911($arrayFolders; "jitLetters")
	APPEND TO ARRAY:C911($arrayFolders; "jitReports")
	APPEND TO ARRAY:C911($arrayFolders; "jitDebug")
	APPEND TO ARRAY:C911($arrayFolders; "jitFAXs")
	APPEND TO ARRAY:C911($arrayFolders; "jitSearches")
	APPEND TO ARRAY:C911($arrayFolders; "jitLabels")
	APPEND TO ARRAY:C911($arrayFolders; "jitAudits")
	APPEND TO ARRAY:C911($arrayFolders; "jitDocs")
	APPEND TO ARRAY:C911($arrayFolders; "jitExports")
	APPEND TO ARRAY:C911($arrayFolders; "Customer")
	APPEND TO ARRAY:C911($arrayFolders; "Item")
	APPEND TO ARRAY:C911($arrayFolders; "Documents")
	APPEND TO ARRAY:C911($arrayFolders; "jitPrefs")
	
	
	C_LONGINT:C283($testOld; $testNew)
	C_TEXT:C284($oldPath; $newPath)
	
	
	$testNew:=Test path name:C476(Storage:C1525.folder.jitF)
	If ($testNew#0)
		
		CREATE FOLDER:C475(Storage:C1525.folder.jitF; *)
		C_LONGINT:C283($incRay; $cntRay)
		$cntRay:=Size of array:C274($arrayFolders)
		For ($incRay; 1; $cntRay)
			$oldPath:=$old_jitF+$arrayFolders{$incRay}+Folder separator:K24:12
			$testOld:=Test path name:C476($oldPath)
			If ($testOld=0)  // folder exists
				$newPath:=Storage:C1525.folder.jitF+$arrayFolders{$incRay}+Folder separator:K24:12
				$testNew:=Test path name:C476($newPath)
				//CREATE FOLDER($newPath)
				//End if 
				// ### bj ### 20190721_2321
				// this should be rare, but if it happens an alert is important to clean out old stuff
				COPY DOCUMENT:C541($oldPath; Storage:C1525.folder.jitF; *)
				ALERT:C41("Copied: "+Storage:C1525.folder.jitF)
				ConsoleLog("Copied: "+$oldPath)
				ConsoleLog("Copied to: "+Storage:C1525.folder.jitF)
				// PAUSE PROCESS(Current process;20)
				// DELETE FOLDER($oldPath;Delete with contents)
			End if 
		End for 
	End if 
End if 