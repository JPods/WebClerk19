//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/03/09, 00:07:58
// ----------------------------------------------------
// Method: Method: ExecuteUserReport
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1)
If ([UserReport:46]Name:2#$1)
	QUERY:C277([UserReport:46]; [UserReport:46]Name:2=$1)
End if 
Case of 
	: (Records in selection:C76([UserReport:46])=1)
		If ([UserReport:46]ScriptExecute:4)
			ExecuteText(0; [UserReport:46]ScriptBegin:5)
		End if 
		UNLOAD RECORD:C212([UserReport:46])
	: (Records in selection:C76([UserReport:46])>1)
		ALERT:C41("You have more than one report with the same name.")
End case 