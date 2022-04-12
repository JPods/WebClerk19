C_TEXT:C284($test)
If ((vi1<=Get last table number:C254) & (vi1>0))
	If ((vi2<Get last field number:C255(vi1)) & (vi2>0))
		$test:=Field name:C257(vi1; vi2)
	End if 
End if 
If (v1#$test)
	vi1:=0
	vi2:=0
End if 