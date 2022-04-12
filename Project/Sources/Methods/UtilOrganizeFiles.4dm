//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: UtilFilePrefix
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_TEXT:C284($1; $fileReName; $folderName; $preFix)
C_LONGINT:C283($incArray; $cntArray; $error; $maxLenFile)
$folderName:=""
If (Count parameters:C259=0)
	$folderName:=Get_FolderName("Select folder picture rename.")
Else 
	$folderName:=$1
End if 
If ($folderName#"")
	$preFix:=Substring:C12(HFS_ShortName($folderName); 1; 5)  //max length of prefix
	$preFix:=Replace string:C233(Replace string:C233($preFix; ":"; ""); "\\"; "")
	$error:=HFS_CatToArray($folderName; "aText1")
	$cntArray:=Size of array:C274(aText1)
	For ($incArray; 1; $cntArray)
		$fileName:=$folderName+aText1{$incArray}
		$maxLenFile:=Length:C16(aText1{$incArray})
		If ($maxLenFile>32)
			$fileReName:=Substring:C12(aText1{$incArray}; ($maxLenFile-25))
		Else 
			$fileReName:=aText1{$incArray}
		End if 
		$fileReName:=$preFix+$fileReName
		$error:=HFS_Rename($fileName; $fileReName)
	End for 
End if 
