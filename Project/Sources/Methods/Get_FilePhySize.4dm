//%attributes = {"publishedWeb":true}
If (False:C215)
	//02/10/03.prf
	//removed plugin FilePack
	TCStrong_prf_v144_FilePack
End if 

C_LONGINT:C283($0)
C_TEXT:C284($1; $document)
$document:=$1
$0:=Get document size:C479($document)+Get document size:C479($document; *)