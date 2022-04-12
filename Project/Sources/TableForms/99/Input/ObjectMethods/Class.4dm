If (([Word:99]WordOnly:3#"") & ([Word:99]Reference:6#""))
	[Word:99]WordCombined:5:=[Word:99]WordOnly:3+"_"+[Word:99]Reference:6
Else 
	[Word:99]WordCombined:5:=[Word:99]WordOnly:3+[Word:99]Reference:6
End if 
