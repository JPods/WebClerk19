//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $k; $w)
C_POINTER:C301($1)
$k:=Size of array:C274($1->)
For ($i; $k; 1; -1)
	$w:=Find in array:C230($1->; $1->{$k})
	If ($w<$k)
		DELETE FROM ARRAY:C228($1->; $k; 1)
	End if 
End for 
SORT ARRAY:C229($1->)