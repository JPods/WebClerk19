//%attributes = {"publishedWeb":true}
C_LONGINT:C283($w; $1; $2; $3)
C_TEXT:C284($4; $5)
$w:=Size of array:C274(aSyFile)+1
INSERT IN ARRAY:C227(aSyFile; $w)
INSERT IN ARRAY:C227(aSyField; $w)
INSERT IN ARRAY:C227(aSyType; $w)
INSERT IN ARRAY:C227(aSyMatIs; $w)
INSERT IN ARRAY:C227(aSyMatWas; $w)
aSyFile{$w}:=$1  //File([Customer])
aSyField{$w}:=$2  //Field([Customer]AccountCode)
aSyType{$w}:=$3  //Type([Customer]AccountCode)
aSyMatWas{$w}:=$4  //$srStr
aSyMatIs{$w}:=$5  //[Customer]AccountCode
If (Count parameters:C259=6)
	$6->:=$6->+"Original "+$4+"."
End if 