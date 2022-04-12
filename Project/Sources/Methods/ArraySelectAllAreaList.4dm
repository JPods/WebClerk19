//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: Method: ArraySelectAllAreaList
	//Date: 03/11/03
	//Who: Bill
	//Description: Fill out an array selection with all
End if 
C_POINTER:C301($1; $2)
C_LONGINT:C283($i; $k)
$k:=Size of array:C274($2->)
ARRAY LONGINT:C221($1->; $k)
For ($i; 1; $k)
	$1->{$i}:=$i
End for 