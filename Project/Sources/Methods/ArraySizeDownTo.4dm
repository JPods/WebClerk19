//%attributes = {"publishedWeb":true}
If (False:C215)
	version_67_200506
	//ArraySizeDownTo
End if 
C_POINTER:C301($1)
C_LONGINT:C283($2)
C_LONGINT:C283($k; $i; $w)
If (Count parameters:C259=2)
	$w:=$2+1
	$k:=Size of array:C274($1->)
	If ($k>3)
		For ($i; $k; $w; -1)
			DELETE FROM ARRAY:C228($1->; $i; 1)
		End for 
	End if 
End if 