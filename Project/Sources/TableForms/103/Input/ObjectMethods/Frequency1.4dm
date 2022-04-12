// ### bj ### 20190127_1125

If (Form event code:C388=On Load:K2:1)
	If ([SyncRelation:103]PartnerNumber:14=0)
		[SyncRelation:103]PartnerNumber:14:=1
		[SyncRelation:103]Partner1Name:31:=<>TCCOMPANY
		[SyncRelation:103]Partner1URL:2:=<>TCDOMAIN
		// [SyncRelation]Partner1email:=
	End if 
Else 
	If ([SyncRelation:103]PartnerNumber:14=0)
		[SyncRelation:103]PartnerNumber:14:=1
		ALERT:C41("You are either Partner 1 or 2.")
		[SyncRelation:103]Partner1Name:31:=<>TCCOMPANY
		[SyncRelation:103]Partner1URL:2:=<>TCDOMAIN
	End if 
	If ([SyncRelation:103]PartnerNumber:14>2)
		ALERT:C41("You are either Partner 1 or 2.")
		[SyncRelation:103]PartnerNumber:14:=2
		[SyncRelation:103]Partner2Name:32:=<>TCCOMPANY
		[SyncRelation:103]Partner2URL:33:=<>TCDOMAIN
	End if 
End if 