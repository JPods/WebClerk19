//TN_SrRec ([TechNote]Subject;Self;True)
If (srTNSubject#"")
	QUERY:C277([TechNote:58]; [TechNote:58]Subject:6="@"+srTNSubject+"@")
	If (Records in selection:C76([TechNote:58])>0)
		doSearch:=3
	Else 
		BEEP:C151
		BEEP:C151
	End if 
End if 