//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i)
For ($i; 1; 10)
	$ptReal:=Get pointer:C304("vR"+String:C10($i))
	$ptText:=Get pointer:C304("vText"+String:C10($i))
	$ptReal->:=0
	$ptText->:=""
End for 