If ([RemoteUser:57]scriptAtSignIn:18#"")
	QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8=[RemoteUser:57]scriptAtSignIn:18; *)
	QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="WebSignin")
Else 
	QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="WebSignin")
End if 
If (Records in selection:C76([TallyMaster:60])>0)
	DB_ShowCurrentSelection(->[TallyMaster:60]; ""; 1; "")  //tablePt, script, flowBranch, Title
Else 
	Process_AddRecord("TallyMaster")
End if 
