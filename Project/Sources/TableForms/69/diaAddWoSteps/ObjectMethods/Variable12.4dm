v1:=""
If ((vi1<=Get last table number:C254) & (vi1>0))
	If ((vi2<Get last field number:C255(vi1)) & (vi2>0))
		v1:=Field name:C257(vi1; vi2)
	End if 
End if 