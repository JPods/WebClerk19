//%attributes = {"publishedWeb":true}
C_LONGINT:C283($fieldType; $i)
C_TEXT:C284($0)
C_POINTER:C301($1)
$0:=""
FIRST RECORD:C50(Table:C252(Table:C252($1))->)
$FieldType:=Type:C295($1->)
Case of 
	: (($fieldType=0) | ($FieldType=2) | ($FieldType=24))  //String fiellld type
		For ($i; 1; Records in selection:C76(Table:C252(Table:C252($1))->))
			$0:=$0+$1->+"\r"
			NEXT RECORD:C51(Table:C252(Table:C252($1))->)
		End for 
	: (($FieldType=1) | ($FieldType=4) | ($FieldType=6) | ($FieldType=8) | ($FieldType=9) | ($FieldType=11))
		For ($i; 1; Records in selection:C76(Table:C252(Table:C252($1))->))
			$0:=$0+String:C10($1->)+"\r"
			NEXT RECORD:C51(Table:C252(Table:C252($1))->)
		End for 
End case 