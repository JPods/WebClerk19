//%attributes = {"publishedWeb":true}
//Procedure: PackMakeTyped    October 7, 1993
C_POINTER:C301($1)
C_TEXT:C284($2)
C_LONGINT:C283($theType)
$theType:=Type:C295($1->)
Case of 
	: (($theType=0) | ($theType=2) | ($theType=22))
		$1->:=$2
	: (($theType=1) | ($theType=8) | ($theType=9))
		$1->:=Num:C11($2)
	: ($theType=4)
		$1->:=Date:C102($2)
	: ($theType=11)
		$1->:=Time:C179($2)
	: ($theType=6)  //Boolean
		$1->:=(($2="1") | ($2="t") | ($2="true") | ($2="y"))
End case 