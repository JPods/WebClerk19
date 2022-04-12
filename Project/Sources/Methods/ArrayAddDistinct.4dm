//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/21/18, 15:40:33
// ----------------------------------------------------
// Method: ArrayAddDistinct
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($1; $2)
C_LONGINT:C283($found; $incRay; $cntRay)

$cntRay:=Size of array:C274($2->)
For ($incRay; $cntRay; 1; -1)  // loop to delete elements without adding to what must be searched
	$found:=Find in array:C230($1->; $2->{$incRay})
	If ($found>0)
		DELETE FROM ARRAY:C228($2->; $incRay; 1)
	End if 
End for 
$cntRay:=Size of array:C274($2->)
For ($incRay; 1; $cntRay)  // loop to delete elements without adding to what must be searched
	APPEND TO ARRAY:C911($1->; $2->{$incRay})
End for 