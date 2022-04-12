//%attributes = {"publishedWeb":true}
C_LONGINT:C283($k; $findRay)
C_REAL:C285($1)
C_TEXT:C284($2)
If ($1#0)
	$findRay:=Find in array:C230(aGLAll; $2)
	If ($findRay=-1)
		$k:=Size of array:C274(aGLAll)+1
		INSERT IN ARRAY:C227(LSDistAmts; $k)
		INSERT IN ARRAY:C227(aGLAll; $k)
		LSDistAmts{$k}:=Round:C94($1; <>tcDecimalTt)
		aGLAll{$k}:=$2
	Else 
		LSDistAmts{$findRay}:=Round:C94(LSDistAmts{$findRay}+$1; <>tcDecimalTt)
	End if 
End if 