//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $e; $k; $w; $cntDiff; $firstDelete)  //  Ray_ShowSubSet (aRayLines;aServiceRecs;aServiceTableName;other arrays
C_POINTER:C301($1; $2; $3; $4; $5; $6; $7; $8; $9; $10; $11; $12; $13; $14; $15; $16; $17; $18; $19; $20; $21; $22; $23; $24; $25; $26; $27; $28; $29; $30; $31; $32; $33)
$k:=Size of array:C274($1->)
If ($k>0)
	$cntDiff:=Size of array:C274($2->)-$k
	$firstDelete:=$k+1
	$k2:=Count parameters:C259
	For ($i; 1; $k)
		$w:=$1->{$i}
		For ($e; 2; $k2)
			${$e}->{$i}:=${$e}->{$w}
		End for 
	End for 
	If ($cntDiff>0)
		For ($e; 2; $k2)
			DELETE FROM ARRAY:C228(${$e}->; $firstDelete; $cntDiff)
		End for 
		$2->:=Num:C11(Size of array:C274($1->)>0)
	End if 
Else 
	BEEP:C151
	BEEP:C151
End if 