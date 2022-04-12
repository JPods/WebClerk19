//%attributes = {"publishedWeb":true}
If (False:C215)
	//02/10/03.prf
	//removed plugin FilePack
	TCStrong_prf_v144_FilePack
End if 

C_LONGINT:C283($i; $position)
C_TEXT:C284($0; $1; $LongFileName; $folderSeparator)
$0:=""
$LongFileName:=$1

If (Is macOS:C1572)
	$folderSeparator:=":"
Else 
	$folderSeparator:="\\\\"
End if 
$position:=0
For ($i; 1; Length:C16($LongFileName))
	If ($LongFileName[[$i]]=$folderSeparator)
		$position:=$i
		$i:=Length:C16($LongFileName)  //end loop
	End if 
End for 

$0:=Substring:C12($LongFileName; 1; $position)