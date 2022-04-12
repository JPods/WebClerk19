
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/13/20, 23:29:33
// ----------------------------------------------------
// Method: [SyncRecord].Input.bProcessItems
// Description
// 
//
// Parameters
// ----------------------------------------------------



// TempButtons
// TempButtons
$doProcess:=False:C215
CONFIRM:C162("Update a catalog")
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
	vtRPCommand:="PR-UpdateCatalog"
	RP_ItemsReceive(->[SyncRecord:109]ObReceived:46)
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