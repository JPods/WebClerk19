myOK:=0
If (aText4>0)
	If (aText4<=Size of array:C274(aText4))
		myOK:=3
		CANCEL:C270
	End if 
End if 
If (myOK=0)
	ALERT:C41("Select Set to use.")
End if 