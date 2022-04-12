C_LONGINT:C283(pUse; $i; $k)
$k:=Size of array:C274(aRayLines)
For ($i; 1; $k)
	aPOLnCmplt{aRayLines{$i}}:="x"*(Num:C11(pUse=1))
	//If ($i<$k)  do skip this in case the order is mis matched to the line selected
	PoLnExtend(aRayLines{$i})
	//End if 
End for 
vLineMod:=True:C214