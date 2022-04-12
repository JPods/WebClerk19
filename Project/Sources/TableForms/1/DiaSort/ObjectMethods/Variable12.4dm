C_LONGINT:C283(bDeleteFrom; $num)
If ((Size of array:C274(aMatchType)>0) & (aMatchField>0))
	If (aMatchType>0)
		$num:=aMatchField
	Else 
		$num:=Size of array:C274(aMatchType)
	End if 
	DELETE FROM ARRAY:C228(aMatchField; $num; 1)
	DELETE FROM ARRAY:C228(aMatchType; $num; 1)
	DELETE FROM ARRAY:C228(aMatchNum; $num; 1)
	aMatchType:=0
	Case of 
		: ($Num>Size of array:C274(aMatchField))
			aMatchField:=Size of array:C274(aMatchField)
			aMatchType:=Size of array:C274(aMatchField)
			aMatchNum:=Size of array:C274(aMatchField)
		: (($Num=1) & (Size of array:C274(aMatchField)>0))
			aMatchField:=1
			aMatchType:=1
			aMatchNum:=1
		Else 
			aMatchField:=$num-1
			aMatchType:=$num-1
			aMatchNum:=$num-1
	End case 
	
	
	
Else 
	BEEP:C151
	BEEP:C151
End if 