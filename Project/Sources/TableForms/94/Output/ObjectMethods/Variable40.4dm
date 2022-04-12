If (iLoLongInt1>0)
	CONFIRM:C162("Access Fields, Table "+<>aTableNames{<>aTableNames}+" at Level "+String:C10(iLoLongInt1))
	If (OK=1)
		UtilParseAllow(iLoLongInt1)
	End if 
End if 