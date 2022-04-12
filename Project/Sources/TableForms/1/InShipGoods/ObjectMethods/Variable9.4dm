C_LONGINT:C283(pUse; $i; $k; $theLine)
$k:=Size of array:C274(aPoLnSelct)
For ($i; 1; $k)
	aPOLnCmplt{aPoLnSelct{$i}}:="x"*(Num:C11(pUse=1))
	//If ($i<$k)  do skip this in case the order is mis matched to the line selected
	PoLnExtend(aPoLnSelct{$i})
	//End if 
End for 
vLineMod:=True:C214
vMod:=True:C214