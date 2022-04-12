If (False:C215)
	
	If (Size of array:C274(aFCItem)<=<>alpArrayMax)
		//  --  CHOPPED  AL_UpdateArrays(eForeCast; -2)
	Else 
		ALERT:C41("Arrays are too large to display."+"Run Date Item or Export.")
	End if 
	viRecordsInSelection:=Size of array:C274(aFCItem)
End if 