QUERY:C277([TallyResult:73]; [TallyResult:73]profile2:18=Substring:C12([PurchaseJournal:51]source:2; 1; 12))
If (Records in selection:C76([TallyResult:73])>0)
	DB_ShowCurrentSelection(->[TallyResult:73]; ""; 1; "")
Else 
	BEEP:C151
	BEEP:C151
End if 