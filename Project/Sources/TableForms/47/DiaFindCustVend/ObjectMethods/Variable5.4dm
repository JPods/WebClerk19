If (aText1=0)
	aText1:=Num:C11(Size of array:C274(aText1)>0)
End if 
If (Size of array:C274(aSrlRecNum)>0)
	If (aSrlRecNum{aText1}#Record number:C243([ItemSerial:47]))
		If (Record number:C243([ItemSerial:47])>-1)
			Srl_SaveChanges
		End if 
		GOTO RECORD:C242([ItemSerial:47]; aSrlRecNum{aText1})
		srSrlNum:=[ItemSerial:47]SerialNum:4
		doSearch:=1
	End if 
End if 