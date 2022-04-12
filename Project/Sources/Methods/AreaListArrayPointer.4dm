//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/18/09, 09:56:00
// ----------------------------------------------------
// Method: AreaListArrayPointer
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1; $2; $3; $4; $5; $6; $7; $8; $9; $10; $11; $12; $13; $14; $15)
C_LONGINT:C283($incPara; $countPara; $sizePtRay)
$countPara:=Count parameters:C259
For ($incPara; 1; $countPara)
	$sizePtRay:=Size of array:C274(aAreaListArraysPointer)+1
	INSERT IN ARRAY:C227(aAreaListArraysPointer; $sizePtRay; 1)
	aAreaListArraysPointer{$sizePtRay}:=${$incPara}
	INSERT IN ARRAY:C227(aAreaListArraysSort; $sizePtRay; 1)
	aAreaListArraysSort{$sizePtRay}:=0
End for 

