//%attributes = {"publishedWeb":true}
If (False:C215)
	//02/10/03.prf
	//removed plugin FilePack
	TCStrong_prf_v144_FilePack
End if 
C_TEXT:C284($1; $theFolder)
C_LONGINT:C283($err)
If (Count parameters:C259=0)
	$theFolder:=Storage:C1525.folder.jitExportsF
Else 
	$theFolder:=$1
End if 
C_OBJECT:C1216($obPath)
//  v17
// $obPath:=path to object($theFolder)