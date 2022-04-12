//%attributes = {"publishedWeb":true}
If (False:C215)
	//02/10/03.prf
	//removed plugin FilePack
	TCStrong_prf_v144_FilePack
	TCStrong_prf_v144_FilePackReTok
End if 

C_TEXT:C284($1; $srcPathName; $2; $dstPathName)
$srcPathName:=$1
$dstPathName:=$2

$dstPathName:=$dstPathName+HFS_ShortName($srcPathName)
MOVE DOCUMENT:C540($srcPathName; $dstPathName)

$0:=0