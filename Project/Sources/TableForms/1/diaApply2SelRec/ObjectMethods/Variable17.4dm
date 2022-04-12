C_LONGINT:C283($num; $i)
If (Size of array:C274(aImportLine)>0)
	If ((aImportLine#0) & (aImportLine<=Size of array:C274(aCntImpFlds)))
		$num:=aImportLine
		DELETE FROM ARRAY:C228(aCntImpFlds; $num; 1)
		DELETE FROM ARRAY:C228(aImpFields; $num; 1)
		DELETE FROM ARRAY:C228(aBullets; $num; 1)
		cntFields:=Size of array:C274(aImpFields)
		For ($i; 1; Size of array:C274(aCntImpFlds))
			aCntImpFlds{$i}:=$i
		End for 
		HIGHLIGHT TEXT:C210(vStr255; 1; 255)
	Else 
		ALERT:C41("Click on the line you wish to remove.")
	End if 
Else 
	BEEP:C151
	BEEP:C151
End if 
//  --  CHOPPED  AL_UpdateArrays(eImportList; -2)