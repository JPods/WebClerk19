//%attributes = {}
C_POINTER:C301($1; $ptTable)
C_TEXT:C284($2; $nameOfSelection)
C_LONGINT:C283($3; $startPoint; $4; $recordsWanted)
$ptTable:=$1
$nameOfSelection:=$2
$startPoint:=$3
$recordsWanted:=$4

$t:=RECORDS IN NAMED SELECTION(->[QQQCustomer:2]; "SomeNamedSelection")

If ($t>0)  // how many records)
	
	
End if 

