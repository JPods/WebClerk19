//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/06/11, 13:41:00
// ----------------------------------------------------
// Method: List_FillOpts
// Description
// 
//
// Parameters
// ----------------------------------------------------

//TRACE
MESSAGES OFF:C175
C_LONGINT:C283($k; $1; $2)
If (Count parameters:C259>2)
	C_TEXT:C284($3; $typeSaleSel)
	$typeSaleSel:=$3
Else 
	$typeSaleSel:=""
End if 
List_RaySize(0)
If ($1>0)
	ARRAY BOOLEAN:C223(aTmpBoo1; $k)
	ARRAY BOOLEAN:C223(aTmpBoo2; $k)
	$k:=$1
	REDUCE SELECTION:C351([Item:4]; $k)
	If (($2>1) & ($2<6))  //use with item searching    
		List_ItemChoice($k; $2; $typeSaleSel)
	Else   //use with adjustments
		List_Adjustment  //($k)
	End if 
End if 
MESSAGES ON:C181
aLsSrRec:=Num:C11(Size of array:C274(aLsSrRec)>0)
vi1:=0
vr1:=0
vr2:=0
vr3:=0
vr4:=0
v1:=""
v2:=""
v3:=""
ARRAY BOOLEAN:C223(aTmpBoo1; 0)
ARRAY BOOLEAN:C223(aTmpBoo2; 0)
//srItem:="" // ### AZM ### DON'T CLEAR OUT QUICK QUOTE SEARCH INPUT AFTER SEARCH
//srKeyword:="" // ### AZM ### DON'T CLEAR OUT QUICK QUOTE SEARCH INPUT AFTER SEARCH