//%attributes = {"publishedWeb":true}
C_POINTER:C301($1; $2; $3; $4)
C_LONGINT:C283($5; $6)
If ($3->{$5}#"sk")
	QUERY:C277(Table:C252(Table:C252($1))->; $1->>$6; *)
	If (Count parameters:C259>6)
		If ($8->#"")
			QUERY:C277(Table:C252(Table:C252($1))->;  & $7->=$8->; *)
		End if 
	End if 
	QUERY:C277(Table:C252(Table:C252($1))->)
	$2->:=Records in selection:C76(Table:C252(Table:C252($1))->)
Else 
	$2->:=0
End if 
SEND VARIABLE:C80($2->)
$4->{$5}:=$2->