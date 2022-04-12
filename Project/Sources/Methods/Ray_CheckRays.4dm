//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $k; $w; $t; $y; $z)
C_POINTER:C301($1; $2; $3; $4; $5; $6; $7; $8; $9; $10; $11; $12; $13; $14; $15; $16; $17; $18; $19; $20; $21; $22; $23; $24; $25; $26; $27; $28; $29; $30; $31; $32; $33)
$k:=Count parameters:C259\2
$f:=Size of array:C274($1->)
$s:=Size of array:C274($2->)
$w:=$f-$s
$t:=0
Case of 
	: ($w=0)
	: ($w>0)
		For ($i; 1; $k)
			$t:=$t+2
			INSERT IN ARRAY:C227(${$t}->; 1; $w)
		End for 
	: ($w<0)
		For ($i; 1; $k)
			$t:=$t+2
			DELETE FROM ARRAY:C228(${$t}->; 1; -$w)
		End for 
End case 
$t:=0
$y:=-1
If ($f>0)
	For ($i; 1; $k)
		$y:=$y+2
		$t:=$t+2
		For ($z; 1; $f)
			${$t}->{$z}:=${$y}->{$z}
		End for 
	End for 
End if 