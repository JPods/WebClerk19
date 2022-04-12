//%attributes = {"publishedWeb":true}
C_TEXT:C284($0)
C_POINTER:C301($1)
C_LONGINT:C283($i)
$i:=Type:C295($1->)
Case of 
	: (($i=0) | ($i=2))
		$0:=$1->
	: (($i=1) | ($i=4) | ($i=8) | ($i=9) | ($i=11))
		$0:=String:C10($1->)
	: ($i=6)
		$0:=String:C10(Num:C11($1->))
End case 