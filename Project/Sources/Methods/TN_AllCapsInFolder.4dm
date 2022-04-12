//%attributes = {"publishedWeb":true}
If (False:C215)
	// Method: TN_AllCapsInFolder
	//Date: 07/01/02
	//Who: Bill
	//Description: Fix paths to Case sensitive OS's
End if 

$fileFold:=Get_FolderName("Select folder for all capital letters.")
C_LONGINT:C283($i; $k)
C_TEXT:C284($fileFold)
If ($fileFold#"")
	$error:=HFS_CatToArray($fileFold; "aText1")
	$k:=Size of array:C274(aText1)
	TRACE:C157
	For ($i; 1; $k)
		$err:=HFS_Rename($fileFold+aText1{$i}; Uppercase:C13(aText1{$i}))
	End for 
End if 