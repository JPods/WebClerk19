//%attributes = {"publishedWeb":true}
C_LONGINT:C283($w; $insertRay)
$w:=Find in array:C230(theUniques; "u")
If ($w#-1)
	$insertRay:=Size of array:C274(aMatchField)+1
	INSERT IN ARRAY:C227(aCntMatFlds; $insertRay)
	INSERT IN ARRAY:C227(aMatchField; $insertRay)
	INSERT IN ARRAY:C227(aMatchType; $insertRay)
	INSERT IN ARRAY:C227(aMatchNum; $insertRay)
	aCntMatFlds{$insertRay}:=$insertRay
	aMatchField{$insertRay}:=theFields{$w}
	aMatchType{$insertRay}:=theTypes{$w}
	aMatchNum{$insertRay}:=$w
	vSearchBy:=theFields{$w}
	bMakeUnique:=0
Else 
	vSearchBy:=""
End if 
vSearchBy2:=""
