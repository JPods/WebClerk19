C_LONGINT:C283($i; $k)
KeyModifierCurrent
If (cmdKey=1)
	$k:=1
	ARRAY LONGINT:C221(aRayLines; 1)
Else 
	$k:=Size of array:C274(aRayLines)
End if 
//TRACE
For ($i; 1; $k)
	aHtBkGraf{aRayLines{$i}}:=iLoText2  //[ImagePath]Title
	aHtBkColor{aRayLines{$i}}:=iLoText8  //[ImagePath]Description
	aHtLink{aRayLines{$i}}:=iLoText10  //[ImagePath]KeywordText
	//aHtvLink{aRayLines{$i}}:=iLoText2//$aStrRecs{$fia}
	//aHtaLink{aRayLines{$i}}:=iLoText2//[ImagePath]PathHiRes
	aHtText{aRayLines{$i}}:=iLoText3  //[ImagePath]ImageName
	aHtBody{aRayLines{$i}}:=iLoText4  //[ImagePath]Event
	aHtReason{aRayLines{$i}}:=iLoText5  //String([ImagePath]Publish)
End for 
//  CHOPPED  AL_GetScroll(eHttpEdit; viVert; viHorz)
//  --  CHOPPED  AL_UpdateArrays(eHttpEdit; -2)
// -- AL_SetSelect(eHttpEdit; aRayLines)
// -- AL_SetScroll(eHttpEdit; viVert; viHorz)