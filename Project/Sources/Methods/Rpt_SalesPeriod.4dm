//%attributes = {"publishedWeb":true}
//call from quick or super report
C_LONGINT:C283($i; $k; $sales; $costs)
C_POINTER:C301($1; $2; $3; $4; $5; $6; $7; $10; $11; $12; $file)
C_DATE:C307($8; $9)
$file:=Table:C252(Table:C252($3))
//date1; date2 ; ZipLow; ZipHigh
QUERY:C277($file->; $3->=$4->; *)
If (Count parameters:C259=9)
	QUERY:C277($file->;  & $7->>=$8; *)
	QUERY:C277($file->;  & $7-><=$9; *)
End if 
If (Count parameters:C259=12)
	QUERY:C277($file->;  & $10->>=$11->; *)
	QUERY:C277($file->;  & $10-><=$12->; *)
End if 
QUERY:C277($file->)
SELECTION TO ARRAY:C260($5->; aReal1; $6->; aReal2)
UNLOAD RECORD:C212($file->)
$sales:=0
$costs:=0
$k:=Records in selection:C76($file->)
For ($i; 1; $k)
	$sales:=$sales+aReal1{$i}
	$costs:=$costs+aReal2{$i}
End for 
$1->:=$sales
$2->:=$costs
CLEAR VARIABLE:C89(aReal1)
CLEAR VARIABLE:C89(aReal2)