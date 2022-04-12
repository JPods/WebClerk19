//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/22/11, 01:08:37
// ----------------------------------------------------
// Method: RenameDocument
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (Count parameters:C259=0)
	$folderPath:=""
	$folderPath:=Select folder:C670("Select Folder to Change Extensions")
	
Else 
	$folderPath:=$1
End if 
If ($folderPath#"")
	FOLDER LIST:C473($folderPath; $aDirectories)
	C_LONGINT:C283($i; $k)
	$k:=Size of array:C274($aDirectories)
	For ($i; 1; $k)
		RenameDocument($folderPath+$aDirectories{$i})
	End for 
	DOCUMENT LIST:C474($folderPath; $aDocuments)
	$k:=Size of array:C274($aDocuments)
	For ($i; 1; $k)
		If (Position:C15(".cgi"; $aDocuments{$i})>0)
			$newName:=Replace string:C233($aDocuments{$i}; ".cgi"; ".pdf")
			$srcPathName:=$folderPath+Folder separator:K24:12+$aDocuments{$i}
			$dstPathName:=$folderPath+Folder separator:K24:12+$newName
			MOVE DOCUMENT:C540($srcPathName; $dstPathName)
			//DELETE DOCUMENT($srcPathName)
		End if 
	End for 
End if 