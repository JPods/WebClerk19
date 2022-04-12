//%attributes = {"publishedWeb":true}
C_POINTER:C301($ptFile; $1; $2; $3; $4; $5; $6)
vi7:=0
vi8:=0
$ptFile:=Table:C252(Table:C252($1))
PUSH RECORD:C176($ptFile->)
QUERY:C277($ptFile->; $1->=$2->; *)
vi6:=Field:C253($1)
If (Count parameters:C259>2)
	QUERY:C277($ptFile->;  & $3->=$4->; *)
	vi7:=Field:C253($3)
	If (Count parameters:C259>4)
		QUERY:C277($ptFile->;  & $5->=$6->; *)
		vi8:=Field:C253($5)
	End if 
End if 
QUERY:C277($ptFile->)
$0:=SyncDupActions(Records in selection:C76($ptFile->); False:C215)
POP RECORD:C177($ptFile->)