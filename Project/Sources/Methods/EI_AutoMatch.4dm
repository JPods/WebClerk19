//%attributes = {"publishedWeb":true}
C_TEXT:C284($myStr)
C_LONGINT:C283($i; $w; $k)
If (Size of array:C274(aImpFields)>0)
	ARRAY TEXT:C222(aMatchField; 0)
	ARRAY TEXT:C222(aMatchType; 0)
	ARRAY LONGINT:C221(aMatchNum; 0)
	ARRAY LONGINT:C221(aCntMatFlds; 0)
	For ($i; 1; Size of array:C274(aImpFields))
		$k:=Size of array:C274(aMatchField)+1
		INSERT IN ARRAY:C227(aCntMatFlds; $k)
		INSERT IN ARRAY:C227(aMatchField; $k)
		INSERT IN ARRAY:C227(aMatchType; $k)
		INSERT IN ARRAY:C227(aMatchNum; $k)
		$w:=Find in array:C230(theFields; aImpFields{$i})
		If ($w>0)
			aCntMatFlds{$k}:=$k
			aMatchField{$k}:=theFields{$w}
			aMatchType{$k}:=theTypes{$w}
			aMatchNum{$k}:=theFldNum{$w}
		Else 
			aCntMatFlds{$k}:=$k
			aMatchField{$k}:="NOT IMPORTED"
			aMatchType{$k}:="z"
			aMatchNum{$k}:=-2
		End if 
	End for 
Else 
	BEEP:C151
End if 
//  --  CHOPPED  AL_UpdateArrays(eMatchList; -2)