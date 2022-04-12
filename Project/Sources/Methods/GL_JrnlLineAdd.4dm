//%attributes = {"publishedWeb":true}
//GLAll;$ptCost;LSDistAmts;NewAmount)
C_POINTER:C301($1; $2; $3)
C_LONGINT:C283($p2; $ac)
$p2:=Find in array:C230($1->; $2->)  //Find in array(aGLAll;$ptCost)
If ($p2=-1)
	$ac:=Size of array:C274($1->)+1
	INSERT IN ARRAY:C227($1->; $ac; 1)  //(aGLAll;$ac;1)
	INSERT IN ARRAY:C227($3->; $ac; 1)  //(LSDistAmts;$ac;1)
	$1->{$ac}:=$2->
	$3->{$ac}:=Round:C94($4; <>tcDecimalTt)
Else 
	$3->{$p2}:=Round:C94($3->{$p2}+$4; <>tcDecimalTt)
End if 