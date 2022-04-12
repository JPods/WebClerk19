//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 06/19/19, 16:38:24
// ----------------------------------------------------
// Method: Email_MakeSearchable
// Description
// Make emails searchable 
//
// Parameters
// ----------------------------------------------------


KeyModifierCurrent
CONFIRM:C162("Set all Email addresses to searchable?")
C_BOOLEAN:C305($doSearchable)
$doSearchable:=True:C214
If (OK=1)
	ALL RECORDS:C47([QQQCustomer:2])
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76([QQQCustomer:2])
	FIRST RECORD:C50([QQQCustomer:2])
	For ($i; 1; $k)
		If ($doSearchable)
			[QQQCustomer:2]email:81:=[QQQCustomer:2]email:81
		Else 
			[QQQCustomer:2]email:81:=[QQQCustomer:2]email:81
		End if 
		SAVE RECORD:C53([QQQCustomer:2])
		NEXT RECORD:C51([QQQCustomer:2])
	End for 
	//
	ALL RECORDS:C47([Lead:48])
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76([Lead:48])
	FIRST RECORD:C50([Lead:48])
	For ($i; 1; $k)
		If ($doSearchable)
			[Lead:48]Email:33:=[Lead:48]Email:33
		Else 
			[Lead:48]Email:33:=[Lead:48]Email:33
		End if 
		SAVE RECORD:C53([Lead:48])
		NEXT RECORD:C51([Lead:48])
	End for 
	//
	ALL RECORDS:C47([QQQVendor:38])
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76([QQQVendor:38])
	FIRST RECORD:C50([QQQVendor:38])
	For ($i; 1; $k)
		If ($doSearchable)
			[QQQVendor:38]Email:59:=[QQQVendor:38]Email:59
		Else 
			[QQQVendor:38]Email:59:=[QQQVendor:38]Email:59
		End if 
		SAVE RECORD:C53([QQQVendor:38])
		NEXT RECORD:C51([QQQVendor:38])
	End for 
	//
	ALL RECORDS:C47([QQQContact:13])
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76([QQQContact:13])
	FIRST RECORD:C50([QQQContact:13])
	For ($i; 1; $k)
		If ($doSearchable)
			[QQQContact:13]Email:35:=[QQQContact:13]Email:35
		Else 
			[QQQContact:13]Email:35:=[QQQContact:13]Email:35
		End if 
		SAVE RECORD:C53([QQQContact:13])
		NEXT RECORD:C51([QQQContact:13])
	End for 
	//
	ALL RECORDS:C47([Rep:8])
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76([Rep:8])
	FIRST RECORD:C50([Rep:8])
	For ($i; 1; $k)
		If ($doSearchable)
			[Rep:8]Email:22:=[Rep:8]Email:22
		Else 
			[Rep:8]Email:22:=[Rep:8]Email:22
		End if 
		SAVE RECORD:C53([Rep:8])
		NEXT RECORD:C51([Rep:8])
	End for 
	//
	ALL RECORDS:C47([CommunicationDevice:63])
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76([CommunicationDevice:63])
	FIRST RECORD:C50([CommunicationDevice:63])
	For ($i; 1; $k)
		If ($doSearchable)
			[CommunicationDevice:63]EmailAddress:5:=v
		Else 
			[CommunicationDevice:63]EmailAddress:5:=[CommunicationDevice:63]EmailAddress:5
		End if 
		SAVE RECORD:C53([CommunicationDevice:63])
		NEXT RECORD:C51([CommunicationDevice:63])
	End for 
	//
	//
	ALL RECORDS:C47([Invoice:26])
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76([Invoice:26])
	FIRST RECORD:C50([Invoice:26])
	For ($i; 1; $k)
		If ($doSearchable)
			[Invoice:26]email:76:=[Invoice:26]email:76
		Else 
			[Invoice:26]email:76:=[Invoice:26]email:76
		End if 
		SAVE RECORD:C53([Invoice:26])
		NEXT RECORD:C51([Invoice:26])
	End for 
	//
	//
	ALL RECORDS:C47([Order:3])
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76([Order:3])
	FIRST RECORD:C50([Order:3])
	For ($i; 1; $k)
		If ($doSearchable)
			[Order:3]email:82:=[Order:3]email:82
		Else 
			[Order:3]email:82:=[Order:3]email:82
		End if 
		SAVE RECORD:C53([Order:3])
		NEXT RECORD:C51([Order:3])
	End for 
	//
	//
	ALL RECORDS:C47([Proposal:42])
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76([Proposal:42])
	FIRST RECORD:C50([Proposal:42])
	For ($i; 1; $k)
		If ($doSearchable)
			[Proposal:42]email:68:=[Proposal:42]email:68
		Else 
			[Proposal:42]email:68:=[Proposal:42]email:68
		End if 
		SAVE RECORD:C53([Proposal:42])
		NEXT RECORD:C51([Proposal:42])
	End for 
	//  
	//
	ALL RECORDS:C47([PO:39])
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76([PO:39])
	FIRST RECORD:C50([PO:39])
	For ($i; 1; $k)
		If ($doSearchable)
			[PO:39]email:64:=[PO:39]email:64
		Else 
			[PO:39]email:64:=[PO:39]email:64
		End if 
		SAVE RECORD:C53([PO:39])
		NEXT RECORD:C51([PO:39])
	End for 
	//
	//
	ALL RECORDS:C47([QQQRemoteUser:57])
	READ WRITE:C146([QQQRemoteUser:57])
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76([QQQRemoteUser:57])
	FIRST RECORD:C50([QQQRemoteUser:57])
	For ($i; 1; $k)
		If ($doSearchable)
			[QQQRemoteUser:57]email:14:=[QQQRemoteUser:57]userName:2
			[QQQRemoteUser:57]email:14:=[QQQRemoteUser:57]email:14
		Else 
			[QQQRemoteUser:57]userName:2:=[QQQRemoteUser:57]userName:2
			[QQQRemoteUser:57]email:14:=[QQQRemoteUser:57]email:14
		End if 
		SAVE RECORD:C53([QQQRemoteUser:57])
		NEXT RECORD:C51([QQQRemoteUser:57])
	End for 
	
	
	
	ALL RECORDS:C47([QQQRemoteUser:57])
	READ WRITE:C146([QQQRemoteUser:57])
	C_LONGINT:C283($i; $k)
	vi2:=Records in selection:C76([QQQRemoteUser:57])
	FIRST RECORD:C50([QQQRemoteUser:57])
	For (vi1; 1; vi2)
		[QQQRemoteUser:57]userName:2:=[QQQRemoteUser:57]userName:2
		[QQQRemoteUser:57]email:14:=[QQQRemoteUser:57]email:14
		SAVE RECORD:C53([QQQRemoteUser:57])
		NEXT RECORD:C51([QQQRemoteUser:57])
	End for 
	//
	//ALL RECORDS([Rep])
	//C_LONGINT($i;$k)
	//$k:=Records in selection([Rep])
	//FIRST RECORD([Rep])
	//For ($i;1;$k)
	//If ($doSearchable)
	//[Rep]Email:=EMail_In ([Rep]Email)
	//Else 
	//[Rep]Email:=EMail_Out ([Rep]Email)
	//End if 
	//NEXT RECORD([Rep])
	//SAVE RECORD([Rep])
	//End for 
	//  
End if 