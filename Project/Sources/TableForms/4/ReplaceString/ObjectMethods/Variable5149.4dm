If (False:C215)
	//Method:
	Version_0501
	//Date: 01/05/05
	//Who: Bill
	//Description: 
End if 

Case of 
	: (aTmp20Str2=1)  //"query"
		If (Size of array:C274(aFieldLns)>1)
			ARRAY LONGINT:C221(aFieldLns; 1)
		End if 
	: (aTmp20Str2=2)  //"Pallet"
		If (Size of array:C274(aFieldLns)>1)
			ARRAY LONGINT:C221(aFieldLns; 1)
		End if 
	: (aTmp20Str2=3)  //"Apply to Selection"
End case 