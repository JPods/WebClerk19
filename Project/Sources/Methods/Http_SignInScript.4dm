//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/04/08, 12:19:10
// ----------------------------------------------------
// Method: Http_SignInScript
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $signInScript)
If ([QQQRemoteUser:57]scriptAtSignIn:18#"")
	READ ONLY:C145([TallyMaster:60])
	QUERY:C277([TallyMaster:60]; [TallyMaster:60]Name:8=[QQQRemoteUser:57]scriptAtSignIn:18; *)
	QUERY:C277([TallyMaster:60];  & [TallyMaster:60]Publish:25>0; *)
	QUERY:C277([TallyMaster:60];  & [TallyMaster:60]Publish:25<=[QQQRemoteUser:57]securityLevel:4)
	//If (False)
	//If (vWccSecurity>0)
	//QUERY([TallyMaster]; & [TallyMaster]FieldNum=vWccSecurity;*)
	//Else 
	//QUERY([TallyMaster]; & [TallyMaster]FieldNum=viEndUserSecurityLevel;*)
	//End if 
End if 
//QUERY([TallyMaster]; & [TallyMaster]Purpose="WebSignin")

If (Records in selection:C76([TallyMaster:60])=1)  // ### jwm ### 20180702_1118
	vtSearch:=[TallyMaster:60]Script:9
	ExecuteText(0; [TallyMaster:60]Script:9)
End if 
UNLOAD RECORD:C212([TallyMaster:60])
READ WRITE:C146([TallyMaster:60])
//End if 