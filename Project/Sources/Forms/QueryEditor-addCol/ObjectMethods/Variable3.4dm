If (myOK=0)  //any change to the pattern
	If ((vText1#"") | (Size of array:C274(aQueryFieldNames)>0))
		If (vText1="")
			Srch_BuildSyntax
		End if 
		ExecuteText(0; vText1)
		myOK:=1
	End if 
End if 
CANCEL:C270