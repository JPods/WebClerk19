//%attributes = {"publishedWeb":true}
C_LONGINT:C283($fieldType; $i)
C_TEXT:C284($0)
$0:=""
QUERY:C277(Table:C252(Table:C252($2))->; $2->=$1->)
//RELATE MANY($1)
FIRST RECORD:C50(Table:C252(Table:C252($2))->)
If (Count parameters:C259>2)
	ORDER BY:C49(Table:C252(Table:C252($3))->; $3->)
End if 
C_POINTER:C301($thePointer)
If (Count parameters:C259>3)
	$FieldType:=Type:C295($4->)
	$thePointer:=$4
Else 
	$FieldType:=Type:C295($2->)
	$thePointer:=$2
End if 
Case of 
	: (($fieldType=0) | ($FieldType=2) | ($FieldType=24))  //String fiellld type
		For ($i; 1; Records in selection:C76(Table:C252(Table:C252($2))->))
			$0:=$0+$thePointer->+"\r"
			NEXT RECORD:C51(Table:C252(Table:C252($2))->)
		End for 
	: (($FieldType=1) | ($FieldType=4) | ($FieldType=6) | ($FieldType=8) | ($FieldType=9) | ($FieldType=11))
		For ($i; 1; Records in selection:C76(Table:C252(Table:C252($2))->))
			$0:=$0+String:C10($thePointer->)+"\r"
			NEXT RECORD:C51(Table:C252(Table:C252($2))->)
		End for 
End case 