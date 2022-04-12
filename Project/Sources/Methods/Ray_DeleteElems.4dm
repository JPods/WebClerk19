//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $2; $i; $k)
C_POINTER:C301($3; $4; $5; $6; $7; $8; $9; $10; $11; $12; $13; $14; $15; $16; $17; $18; $19; $20; $21; $22; $23; $24; $25; $26; $27; $28; $29; $30; $31; $32; $33)
$k:=Count parameters:C259
For ($i; 3; $k)
	DELETE FROM ARRAY:C228(${$i}->; $1; $2)
End for 