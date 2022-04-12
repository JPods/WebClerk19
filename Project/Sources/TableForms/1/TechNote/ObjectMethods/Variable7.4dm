If (<>aTableNames>0)
	// C_LONGINT($w)
	//vi1:=<>aTableNums{<>aTableNames}
	//TN_SrRec ([TechNote]FileID;vi1;True)
	QUERY:C277([TechNote:58]; [TechNote:58]tableNum:12=<>aTableNums{<>aTableNames})
	If (Records in selection:C76([TechNote:58])>0)
		doSearch:=3
	Else 
		BEEP:C151
		BEEP:C151
	End if 
End if 