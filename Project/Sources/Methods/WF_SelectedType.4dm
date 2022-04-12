//%attributes = {"publishedWeb":true}
//Procedure: WF_SelectedType
C_LONGINT:C283($total; $i; $k; $sizeRay; $2; $3; $4)
C_TEXT:C284($1)
ARRAY LONGINT:C221(aOrdTimeLns; 0)
$k:=Size of array:C274(aTCCause)
$total:=0
For ($i; 1; $k)
	If (aTCCause{$i}=$1)
		$sizeRay:=Size of array:C274(aOrdTimeLns)+1
		INSERT IN ARRAY:C227(aOrdTimeLns; $sizeRay; 1)
		aOrdTimeLns{$sizeRay}:=$i
		$total:=$total+aTCLapsed{$i}
	End if 
End for 
vOrdTime:=Round:C94($total/3600; 2)  //3600    
//  --  CHOPPED  AL_UpdateArrays($2; -2)
// -- AL_SetSelect($2; aOrdTimeLns)
If (Size of array:C274(aOrdTimeLns)>0)
	viVert:=aOrdTimeLns{1}
Else 
	viVert:=1
End if 
// -- AL_SetScroll($2; viVert; viHorz)
//
ARRAY LONGINT:C221(aMtlLns; 0)
$k:=Size of array:C274(aWdReason)
$total:=0
For ($i; 1; $k)
	If (aWdReason{$i}=$1)
		$sizeRay:=Size of array:C274(aMtlLns)+1
		INSERT IN ARRAY:C227(aMtlLns; $sizeRay; 1)
		aMtlLns{$sizeRay}:=$i
		$total:=$total+(aWdQtyUsed{$i}*aWdUnitCost{$i})
	End if 
End for   //
vOrdMtl:=$total
//  --  CHOPPED  AL_UpdateArrays($3; -2)
// -- AL_SetSelect($3; aMtlLns)
If (Size of array:C274(aMtlLns)>0)
	viVert:=aMtlLns{1}
Else 
	viVert:=1
End if 
// -- AL_SetScroll($3; viVert; viHorz)
//
ARRAY LONGINT:C221(aWoStepLns; 0)
$k:=Size of array:C274(aWoCause)
C_REAL:C285($totalReal)
$totalRealRe:=0
For ($i; 1; $k)
	If (aWoCause{$i}=$1)
		$sizeRay:=Size of array:C274(aWoStepLns)+1
		INSERT IN ARRAY:C227(aWoStepLns; $sizeRay; 1)
		aWoStepLns{$sizeRay}:=$i
		$totalReal:=$totalReal+(aWoRate{$i}*aWoDurationPlan{$i})
	End if 
End for 
vOrdWOs:=Round:C94($totalReal; <>tcDecimalUP)
//  --  CHOPPED  AL_UpdateArrays($4; -2)
// -- AL_SetSelect($4; aWoStepLns)
If (Size of array:C274(aWoStepLns)>0)
	viVert:=aWoStepLns{1}
Else 
	viVert:=1
End if 
// -- AL_SetScroll($4; viVert; viHorz)