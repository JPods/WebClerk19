//%attributes = {"publishedWeb":true}
C_POINTER:C301($1)
If (Size of array:C274($1->)>1)
	If ($1->>1)
		$1->:=$1->-1
	Else 
		$1->:=Size of array:C274($1->)
	End if 
End if 