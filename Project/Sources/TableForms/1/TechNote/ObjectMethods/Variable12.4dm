//TN_SrRec ([TechNote]Name;Self;True)
If (srTNName#"")
	QUERY:C277([TechNote:58]; [TechNote:58]Name:2=srTNName+"@")
	If (Records in selection:C76([TechNote:58])>0)
		doSearch:=3
	Else 
		BEEP:C151
		BEEP:C151
	End if 
End if 