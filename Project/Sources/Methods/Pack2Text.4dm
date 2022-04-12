//%attributes = {"publishedWeb":true}
//Procedure: Pack2Text   October 7, 1993
C_LONGINT:C283($i; $2; $e; $3)
C_POINTER:C301($1; ptField)
C_TEXT:C284($0)
$0:=""
$f:=Get last field number:C255($1)
FIRST RECORD:C50($1->)  //do this off of your arrays
For ($i; 1; $2)
	$e:=0
	Repeat 
		$e:=$e+1
		ptField:=Field:C253(Table:C252($1); $e)
		$0:=$0+PackMakeText(ptField)
		$0:=$0+Char:C90($3)
	Until ($e=$f)
	NEXT RECORD:C51($1->)
End for 