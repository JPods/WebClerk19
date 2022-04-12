//%attributes = {"publishedWeb":true}
If (False:C215)
	TCStrong_prf_v142_PictBundle
	//01/31/03.prf
	//new method for PictBundle replacement  
End if 

C_POINTER:C301(${1})
C_LONGINT:C283($vlParam; $vlOffset)

$vlOffset:=0
For ($vlParam; 2; Count parameters:C259)
	BLOB TO VARIABLE:C533($1->; ${$vlParam}->; $vlOffset)
End for 