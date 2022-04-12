iLo35String2:="Not valid"
If (([Word:99]tableNum:2>0) & ([Word:99]tableNum:2<=Get last table number:C254))
	If (([Word:99]fieldNum:7>0) & ([Word:99]fieldNum:7<=Get last field number:C255([Word:99]tableNum:2)))
		iLo35String2:=Field name:C257([Word:99]tableNum:2; [Word:99]fieldNum:7)
	End if 
End if 