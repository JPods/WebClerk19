//%attributes = {"publishedWeb":true}
If (False:C215)
	//02/10/03.prf
	//removed plugin FilePack
	TCStrong_prf_v144_FilePack
End if 

C_TEXT:C284($1; $document)
$document:=$1
$result:=Test path name:C476($document)
$0:=0
If ($result=1)
	DELETE DOCUMENT:C159($document)
	$0:=Num:C11(OK=0)
End if 