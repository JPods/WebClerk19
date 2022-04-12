//%attributes = {"publishedWeb":true}
If (False:C215)
	//02/10/03.prf
	//removed plugin FilePack
	TCStrong_prf_v144_FilePack
End if 

C_LONGINT:C283($0)
C_TEXT:C284($1; $pathname)
$pathname:=$1

C_POINTER:C301($2; $arrayPtr)
$arrayPtr:=$2

DOCUMENT LIST:C474($pathname; $arrayPtr->)

$0:=0