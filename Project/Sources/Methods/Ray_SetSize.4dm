//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $i; $k; $cntDiff; $w)
C_POINTER:C301($2; $3; $4; $5; $6; $7; $8; $9; $10; $11; $12; $13; $14; $15; $16; $17; $18; $19; $20; $21; $22; $23; $24; $25; $26; $27; $28; $29; $30; $31; $32; $33)
$k:=Count parameters:C259
For ($i; 2; $k)
	Case of 
		: (Type:C295(${$i}->)=14)
			ARRAY REAL:C219(${$i}->; $1)
		: (Type:C295(${$i}->)=15)
			ARRAY LONGINT:C221(${$i}->; $1)
		: (Type:C295(${$i}->)=16)
			ARRAY LONGINT:C221(${$i}->; $1)
		: (Type:C295(${$i}->)=17)
			ARRAY DATE:C224(${$i}->; $1)
		: (Type:C295(${$i}->)=18)
			ARRAY TEXT:C222(${$i}->; $1)
		: (Type:C295(${$i}->)=19)
			ARRAY PICTURE:C279(${$i}->; $1)
		: (Type:C295(${$i}->)=20)
			ARRAY POINTER:C280(${$i}->; $1)
		: (Type:C295(${$i}->)=21)
			$w:=Size of array:C274(${$i}->)
			$cntDiff:=$1-$w
			Case of 
				: ($cntDiff>0)
					$key:=$cntDiff+$w
					INSERT IN ARRAY:C227(${$i}->; $w; $cntDiff)
				: ($cntDiff<0)
					$w:=$w+$cntDiff
					DELETE FROM ARRAY:C228(${$i}->; $w; -$cntDiff)
			End case 
		: (Type:C295(${$i}->)=22)
			ARRAY BOOLEAN:C223(${$i}->; $1)
	End case 
End for 