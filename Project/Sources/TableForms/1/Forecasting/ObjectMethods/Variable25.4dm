C_LONGINT:C283($i; $k; $last)
If (Size of array:C274(aFCBomCnt)>0)
	KeyModifierCurrent
	If (optkey=1)
		aFCRunQty{1}:=aFCBomCnt{1}
	End if 
	$k:=Size of array:C274(aFCBomCnt)
	$last:=0
	For ($i; 2; $k)
		$last:=$last+1
		aFCRunQty{$i}:=aFCBomCnt{$i}+aFCRunQty{$last}
	End for 
	If (Size of array:C274(aFCItem)<=<>alpArrayMax)
		//  --  CHOPPED  AL_UpdateArrays(eForeCast; -2)
	Else 
		doSearch:=0
		ALERT:C41("Arrays are too large to display."+"Run Date Item or Export.")
	End if 
	viRecordsInSelection:=Size of array:C274(aFCItem)
End if 