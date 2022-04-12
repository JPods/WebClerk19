//%attributes = {"publishedWeb":true}
If (False:C215)
	//02/10/03.prf
	//removed plugin FilePack
	TCStrong_prf_v144_FilePack
End if 

C_TEXT:C284($0; $1; $text)
$text:=$1


$0:=Select folder:C670($text)
