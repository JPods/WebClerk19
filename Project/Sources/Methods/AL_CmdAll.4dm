//%attributes = {"publishedWeb":true}
//Procedure: AL_CmdAll(diplay array;selection array)
C_LONGINT:C283($i; $k)
C_POINTER:C301($1; $2)
$k:=Size of array:C274($1->)
ARRAY LONGINT:C221($2->; $k)
For ($i; 1; $k)
	$2->{$i}:=$i
End for 