//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/16/10, 11:09:45
// ----------------------------------------------------
// Method: Folder_Delete
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1; $folderPath)
If (Count parameters:C259=1)
	$folderPath:=$1
Else 
	$folderPath:=Select folder:C670("Select folder")
End if 
C_LONGINT:C283($foundFolder)
$foundFolder:=Test path name:C476($folderPath)
If ($foundFolder=0)  //a folder was found
	ARRAY TEXT:C222($aDocList; 0)
	ARRAY TEXT:C222($aFolderList; 0)
	DOCUMENT LIST:C474($folderPath; $aDocList)
	FOLDER LIST:C473($folderPath; $aFolderList)
	C_LONGINT:C283($cntDocs; $incDocs)
	$cntDocs:=Size of array:C274($aDocList)
	For ($incDocs; 1; $cntDocs)
		If ($folderPath[[Length:C16($folderPath)]]#Folder separator:K24:12)
			$folderPath:=$folderPath+Folder separator:K24:12
		End if 
		DELETE DOCUMENT:C159($folderPath+$aDocList{$incDocs})
	End for 
	$cntDocs:=Size of array:C274($aFolderList)
	For ($incDocs; 1; $cntDocs)
		If ($folderPath[[Length:C16($folderPath)]]#Folder separator:K24:12)
			$folderPath:=$folderPath+Folder separator:K24:12
		End if 
		Folder_Delete($folderPath+$aFolderList{$incDocs})
	End for 
	DELETE FOLDER:C693($folderPath)
End if 