//%attributes = {"publishedWeb":true}
//Method: QueryTextCombines// (->field;value;testCnt;wildcard)
C_POINTER:C301($1)
C_TEXT:C284($2)
C_LONGINT:C283($3; $4; $0)
C_TEXT:C284($wildCard)
$wildCard:="@"*$4
If ($2#"")
	If ($3=0)
		QUERY:C277(Table:C252(Field:C253($1))->; $1->=$2+$wildCard; *)
		$0:=1
	Else 
		QUERY:C277(Table:C252(Field:C253($1))->;  & $1->=$2+$wildCard; *)
	End if 
End if 