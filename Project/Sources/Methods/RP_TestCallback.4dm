//%attributes = {}
C_LONGINT:C283($1; $2; $3; $5; $6)
C_POINTER:C301($4)

C_LONGINT:C283($i)

ARRAY LONGINT:C221($aTableNums; 1)

SELECTION RANGE TO ARRAY:C368($5; $5+$6-1; [SyncRecord:109]tableNum:4; $aTableNums)

For ($i; 1; $6)
	$4->{$i}:=Table name:C256($aTableNums{$i})
End for 
