C_LONGINT:C283(bSpacer; $k2)
C_BOOLEAN:C305($booInsert)

//  CHOPPED  AL_GetScroll(eMatchList; $viVertMatch; $viHorzMatch)
$k2:=aMatchType+1
$currentaMatchType:=aMatchType
If (aMatchField=0)
	$booInsert:=False:C215
Else 
	$booInsert:=True:C214
End if 
INSERT IN ARRAY:C227(aCntMatFlds; $k2)
INSERT IN ARRAY:C227(aMatchField; $k2)
INSERT IN ARRAY:C227(aMatchType; $k2)
INSERT IN ARRAY:C227(aMatchNum; $k2)
aCntMatFlds{$k2}:=$k2
aMatchType:=$k2
aMatchField{$k2}:="NOT IMPORTED"
aMatchType{$k2}:="*"
aMatchNum{$k2}:=-2
If ($booInsert)
	For ($i; 1; Size of array:C274(aCntMatFlds))
		aCntMatFlds{$i}:=$i
	End for 
End if 
ARRAY LONGINT:C221($selectedArray; 1)
//  --  CHOPPED  AL_UpdateArrays(eMatchList; Size of array(aCntMatFlds))
$selectedArray{1}:=$k2
// -- AL_SetSelect(eMatchList; $selectedArray)
// -- AL_SetScroll(eMatchList; $currentaMatchType; $viHorzMatch)


If (False:C215)
	
	C_LONGINT:C283(bSpacer; $k2)
	C_BOOLEAN:C305($booInsert)
	$k2:=aMatchField+1
	If (aMatchField=0)
		$booInsert:=False:C215
	Else 
		$booInsert:=True:C214
	End if 
	INSERT IN ARRAY:C227(aCntMatFlds; $k2)
	INSERT IN ARRAY:C227(aMatchField; $k2)
	INSERT IN ARRAY:C227(aMatchType; $k2)
	INSERT IN ARRAY:C227(aMatchNum; $k2)
	aCntMatFlds{$k2}:=$k2
	aMatchType:=$k2
	aMatchField{$k2}:="NOT IMPORTED"
	aMatchType{$k2}:="*"
	aMatchNum{$k2}:=-2
	If ($booInsert)
		For ($i; 1; Size of array:C274(aCntMatFlds))
			aCntMatFlds{$i}:=$i
		End for 
	End if 
	//  --  CHOPPED  AL_UpdateArrays(eMatchList; -2)
	
End if 