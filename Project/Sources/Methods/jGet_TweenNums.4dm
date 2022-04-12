//%attributes = {"publishedWeb":true}
C_LONGINT:C283($fieldType; $i)
C_TEXT:C284($0)
C_POINTER:C301($1; $2; $3; $6)
C_REAL:C285($4; $5)
$0:=""
QUERY:C277(Table:C252(Table:C252($2))->; $2->=$1->; *)
QUERY:C277(Table:C252(Table:C252($2))->;  & $3->>=$4; *)
QUERY:C277(Table:C252(Table:C252($2))->;  & $3-><=$5)
ORDER BY:C49(Table:C252(Table:C252($2))->; $3->)
FIRST RECORD:C50(Table:C252(Table:C252($2))->)
$FieldType:=Type:C295($6->)
Case of 
	: (($fieldType=0) | ($FieldType=2) | ($FieldType=24))  //String fiellld type
		For ($i; 1; Records in selection:C76(Table:C252(Table:C252($2))->))
			$0:=$0+$6->+"\r"  //String($3)+"     "+$6+vCR
			NEXT RECORD:C51(Table:C252(Table:C252($2))->)
		End for 
	: (($FieldType=1) | ($FieldType=4) | ($FieldType=6) | ($FieldType=8) | ($FieldType=9) | ($FieldType=11))
		For ($i; 1; Records in selection:C76(Table:C252(Table:C252($2))->))
			$0:=$0+String:C10($6->)+"\r"  //String($3)+"     "+String($6)+vCR
			NEXT RECORD:C51(Table:C252(Table:C252($2))->)
		End for 
End case 