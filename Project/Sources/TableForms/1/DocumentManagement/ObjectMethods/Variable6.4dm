// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-11-14T00:00:00, 20:03:37
// ----------------------------------------------------
// Method: [Control].DocumentManagement.Variable6
// Description
// Modified: 11/14/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


$folderName:=""
CONFIRM:C162("Set folder as prefix to documents in subfolders??")
If (OK=1)
	KeyModifierCurrent
	If (OptKey=1)
		$folderName:=Get_FolderName("Select folder with picture folders.")
	Else 
		If (Length:C16(iLoText1)>0)
			If (iLoText1[[Length:C16(iLoText1)]]#Folder separator:K24:12)
				iLoText1:=iLoText1+Folder separator:K24:12
			End if 
		End if 
		$folderName:=iLoText1
	End if 
End if 
If ($folderName#"")
	$error:=HFS_CatToArray($folderName; "aText2")
	$cntFolders:=Size of array:C274(aText2)
	$strSizeArray:=String:C10($cntFolders)
	For ($incFolders; 1; $cntFolders)
		MESSAGE:C88(String:C10($incFolders)+" of "+$strSizeArray)
		If (Position:C15(Folder separator:K24:12; aText2{$incFolders})>0)
			UtilFilePrefix($folderName+aText2{$incFolders})
		End if 
	End for 
End if 

REDRAW WINDOW:C456