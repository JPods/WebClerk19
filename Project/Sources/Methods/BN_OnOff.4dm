//%attributes = {"publishedWeb":true}
C_POINTER:C301($3; $4; $5; $6; $7; $8; $9; $10; $11; $12; $13; $14; $15; $16; $17; $18; $19; $20)
C_LONGINT:C283($1; $2; $k; $i)
//$longint:=$1//512//Incrementing master value
//$2           //the value to be tested
$k:=Count parameters:C259
If ($1#0)
	For ($i; $k; 3; -1)  //skip the test and base values
		If ($2\$1>0)
			${$i}->:=1
		Else 
			${$i}->:=0
		End if 
		$2:=$2%$1
		$1:=$1/2
	End for 
End if 