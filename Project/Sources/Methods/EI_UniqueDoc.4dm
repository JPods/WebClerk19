//%attributes = {"publishedWeb":true}
//Procedure: EI_UniqueDoc
//Noah Dykoski  July 23, 1998 / 12:05 PM
C_TIME:C306($0)  //File Reference of newly created file with a unique name
C_TEXT:C284($1; $thePathandDoc; $vtShortName; $docPath)  //Name of file to create 
$thePathandDoc:=$1

If ($thePathandDoc="")
	$0:=Open document:C264(Storage:C1525.folder.jitF+"UNKCallforUniqueDoc"+String:C10(DateTime_Enter)+".txt")
Else 
	If (Test path name:C476($thePathandDoc)<0)
		$0:=Create document:C266($thePathandDoc)
	Else 
		$vtShortName:=HFS_ShortName($thePathandDoc)
		$docPath:=Substring:C12($thePathandDoc; 1; Length:C16($thePathandDoc)-Length:C16($vtShortName))
		$theLen:=TXT_PositionLast($vtShortName; ".")
		C_TEXT:C284($docRoot; $suffix)
		$docRoot:=Substring:C12($vtShortName; 1; $theLen-1)
		$suffix:=Substring:C12($vtShortName; $theLen)
		C_LONGINT:C283($inc)
		$inc:=0
		C_TEXT:C284($workingDocPath)
		C_BOOLEAN:C305($endloop)
		$endloop:=False:C215
		Repeat 
			$inc:=$inc+1
			$workingDocPath:=$docPath+$docRoot+String:C10($inc; "-00")+$suffix
			If (Test path name:C476($workingDocPath)<0)
				$endloop:=True:C214
			End if 
		Until ($endloop)
		$0:=Create document:C266($workingDocPath)
	End if 
End if 
// ### bj ### 20190109_1858
// what is this for????
If (False:C215)
	If (document#$docName)
		CLOSE DOCUMENT:C267($0)
		$0:=Open document:C264("")
	End if 
End if 
