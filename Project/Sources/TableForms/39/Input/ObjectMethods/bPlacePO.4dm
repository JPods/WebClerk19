
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/13/20, 19:18:54
// ----------------------------------------------------
// Method: [PO].Input.bPlacePO
// Description
// 
//
// Parameters
// ----------------------------------------------------


// ### bj ### 20200330_1212
vMod:=True:C214
booAccept:=True:C214
acceptPO
vtRPVendorID:=[PO:39]vendorId:1
QUERY:C277([SyncRelation:103]; [SyncRelation:103]Partner2AccountID:47=[PO:39]vendorId:1; *)
QUERY:C277([SyncRelation:103];  | ; [SyncRelation:103]Partner1AccountID:36=[PO:39]vendorId:1; *)
QUERY:C277([SyncRelation:103];  & ; [SyncRelation:103]Active:17=True:C214)

If (Records in selection:C76([PO:39])>1)
	REDUCE SELECTION:C351([PO:39]; 1)
End if 

Case of 
	: (Records in selection:C76([SyncRelation:103])=0)
		If (bEDI_Pass)
			ALERT:C41("There is no defined SyncRelation record.")
		Else 
			ConsoleMessage("There is no defined SyncRelation record for RP_POtoVendorSO: "+vtRPVendorID)
		End if 
	: (Records in selection:C76([SyncRelation:103])>1)
		If (bEDI_Pass)
			ALERT:C41("There are multiple defined SyncRelation records.")
		Else 
			ConsoleMessage("There are multiple defined SyncRelation records RP_POtoVendorSO: "+vtRPVendorID)
		End if 
	Else 
		C_LONGINT:C283($viRecordNum)
		$viRecordNum:=Record number:C243([PO:39])
		vtRPUUIDKey:=[SyncRelation:103]id:30
		vtRPCommand:="POstoVendor"
		RP_JSONSend
		//  RP_DataTasks
		GOTO RECORD:C242([PO:39]; $viRecordNum)
		QUERY:C277([QQQVendor:38]; [QQQVendor:38]VendorID:1=[PO:39]vendorId:1)
		// get related records or cancel
		
End case 



