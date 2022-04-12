//%attributes = {"publishedWeb":true}
//Procedure: PackMakeText   October 7, 1993
C_POINTER:C301($1)
C_TEXT:C284($0)
$0:=""
Case of 
	: ((Type:C295($1->)=0) | (Type:C295($1->)=2))  //String; Text
		$0:=$1->
	: ((Type:C295($1->)=1) | (Type:C295($1->)=8) | (Type:C295($1->)=9))  //Real; Integer; Longint
		$0:=String:C10($1->)
	: (Type:C295($1->)=4)  //Date
		$0:=String:C10($1->)
	: (Type:C295($1->)=11)  //Time
		$0:=String:C10($1->)
	: (Type:C295($1->)=6)  //Boolean
		$0:=String:C10(Num:C11($1->))
End case 