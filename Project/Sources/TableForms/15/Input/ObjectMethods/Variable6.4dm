UNLOAD RECORD:C212([Default:15])
READ ONLY:C145([Default:15])
FIRST RECORD:C50([Default:15])
QUERY:C277([SyncRelation:103]; [SyncRelation:103]partner1Accountid:36=[Default:15]ccPartner:159; *)  // show all the records related 
QUERY:C277([SyncRelation:103];  & [SyncRelation:103]active:17=True:C214)
C_TEXT:C284($adder)
If (Records in selection:C76([SyncRelation:103])=1)
	$adder:="Current Credit Card Relationship"
	ProcessTableOpen(Table:C252(->[SyncRelation:103]); ""; "Current Credit Card Relationship")
Else 
	ALL RECORDS:C47([SyncRelation:103])
	If (Records in selection:C76([SyncRelation:103])>0)
		ProcessTableOpen(Table:C252(->[SyncRelation:103]); ""; "Choose Card Relationship")
	Else 
		Process_AddRecord("SyncRelation")
	End if 
End if 