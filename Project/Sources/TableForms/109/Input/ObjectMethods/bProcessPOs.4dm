
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 03/30/20, 23:01:05
// ----------------------------------------------------
// Method: [SyncRecord].Input.bProcessPOs
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### bj ### 20200330_2310
// TempButtons
$doProcess:=False:C215
CONFIRM:C162("Process ObReceived to make SO from POs")
If (OK=1)
	If ([SyncRecord:109]StatusReceive:19="Processed")
		CONFIRM:C162("[SyncRecord]StatusReceive notes this has already been processed. Do it again?")
		If (OK=1)
			$doProcess:=True:C214
		End if 
	Else 
		$doProcess:=True:C214
	End if 
End if 
If ($doProcess)
	vtRPCommand:="POsCreateSO"
	RP_CreateSOfromPO(->[SyncRecord:109]ObReceived:46)
	[SyncRecord:109]StatusReceive:19:="Processed: "+vtRPCommand
	[SyncRecord:109]ActionReceive:47:="Complete"
	SAVE RECORD:C53([SyncRecord:109])
	UNLOAD RECORD:C212([Item:4])
	UNLOAD RECORD:C212([Order:3])
	UNLOAD RECORD:C212([Invoice:26])
	UNLOAD RECORD:C212([OrderLine:49])
	UNLOAD RECORD:C212([QQQCustomer:2])
	UNLOAD RECORD:C212([QQQContact:13])
End if 