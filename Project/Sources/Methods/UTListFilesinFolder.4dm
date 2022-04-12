//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method:Method: UTListFilesinFolder
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
//TRACE
C_TEXT:C284($0; $subContents; $theContents)
If (Count parameters:C259=4)
	$tempFold:=$1
	$doSubFolders:=$2
	$level:=$3
	$textPadChar:=$4
Else 
	KeyModifierCurrent
	$tempFold:=Get_FolderName("Select folder to list contents.")
	If ($tempFold#"")
		$level:=0
		$textPadChar:=" "
		If (CmdKey=1)
			$doSubFolders:=False:C215
		Else 
			$doSubFolders:=True:C214
		End if 
	End if 
End if 
If ($tempFold#"")
	$textPadding:=$textPadChar*($level)
	ARRAY TEXT:C222($aContentsArray; 0)
	$err:=HFS_CatToArray($tempFold; "aText1")
	COPY ARRAY:C226(aText1; $aContentsArray)
	$k:=Size of array:C274($aContentsArray)
	C_LONGINT:C283($err; $i; $k)
	C_TEXT:C284($theContents)
	For ($i; 1; $k)
		$theContents:=$theContents+$textPadding+$aContentsArray{$i}+"\r"
		If (Length:C16($aContentsArray{$i})>0)
			If ($aContentsArray{$i}[[Length:C16($aContentsArray{$i})]]=Folder separator:K24:12)
				$subContents:=UTListFilesinFolder($tempFold+$aContentsArray{$i}; $doSubFolders; $level+1; $textPadChar)
				$theContents:=$theContents+$subContents+"\r"
			Else 
				$subContents:=""
				$theContents:=$theContents+$subContents+"\r"
			End if 
		End if 
	End for 
	If (($level=0) & (OptKey=1))
		SET TEXT TO PASTEBOARD:C523($theContents)
	End if 
	$0:=$theContents
End if 
ARRAY TEXT:C222(aText1; 0)

If (False:C215)
	vi2:=Records in selection:C76([TallyResult:73])
	vText:=Get_FolderName("Select folder to list contents.")
	FIRST RECORD:C50([TallyResult:73])
	For (vi1; 1; vi2)
		vText2:=UTListFilesinFolder(vText+[TallyResult:73]itemNum:34+":"; True:C214; 0; " ")
		[TallyResult:73]textBlk1:5:=vText2
		SAVE RECORD:C53([TallyResult:73])
		NEXT RECORD:C51([TallyResult:73])
	End for 
End if 