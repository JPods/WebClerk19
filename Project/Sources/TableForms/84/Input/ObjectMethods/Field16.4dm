$found:=Find in array:C230(theFldNum; [Map:84]FieldNum:16)
If ($found>0)
	[Map:84]FieldName:17:=theFields{$found}
Else 
	If (Size of array:C274(theFields)>0)
		[Map:84]FieldNum:16:=1
		[Map:84]FieldName:17:=theFields{1}
	Else 
		[Map:84]FieldName:17:="Error"
	End if 
End if 