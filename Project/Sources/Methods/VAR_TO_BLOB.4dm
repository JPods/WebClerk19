//%attributes = {"publishedWeb":true}
If (False:C215)
	TCStrong_prf_v142_PictBundle
	//01/31/03.prf
	//new method for PictBundle replacement
End if 

C_POINTER:C301(${1})
C_LONGINT:C283($vlParam)

SET BLOB SIZE:C606($1->; 0)
For ($vlParam; 2; Count parameters:C259)
	VARIABLE TO BLOB:C532(${$vlParam}->; $1->; *)
End for 