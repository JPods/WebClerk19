C_LONGINT:C283($i; $k)
$k:=Size of array:C274(aRayLines)

For ($i; 1; $k)
	vText1:=iLoText1+aHtPage{aRayLines{$i}}
	AE_LaunchDoc(vText1)
End for 
////  CHOPPED  AL_GetScroll (eHttpEdit;viVert;viHorz)
////  --  CHOPPED  AL_UpdateArrays (eHttpEdit;-2)
//// -- AL_SetSelect (eHttpEdit;aRayLines)
//// -- AL_SetScroll (eHttpEdit;viVert;viHorz)