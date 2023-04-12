//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/25/19, 17:05:27
// ----------------------------------------------------
// Method: RP_SaveRecordtoSyncRecord
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_POINTER:C301($1)
If (Storage:C1525.k.doArchive)
	If ($1#(->[SyncRecord:109]))
		C_LONGINT:C283($w; $tableNum)
		C_TEXT:C284($tableName)
		C_OBJECT:C1216($obBuild)
		$tableNum:=Table:C252($1)
		$tableName:=Table name:C256($1)
		
		CREATE RECORD:C68([SyncRecord:109])
		[SyncRecord:109]actionReceive:47:="None"
		[SyncRecord:109]date:26:=Current date:C33
		[SyncRecord:109]dtCreated:15:=DateTime_DTTo
		[SyncRecord:109]purpose:40:="InternalBackup"
		[SyncRecord:109]tableNum:4:=$tableNum
		[SyncRecord:109]tableName:44:=$tableName
		If ($tableName="Customer")
			jsonRecordToObject(->$obBuild; $tableName; "all fields")
		End if 
		Case of 
			: (True:C214)  // skip all other records at this time
			: ($tableName="Order")
				jsonRecordToObject(->$obBuild; "Order"; "all fields")
				jsonSelectionToObject(->$obBuild; "OrderLine"; "all fields")
				
			: ($tableName="Invoice")
				jsonRecordToObject(->$obBuild; "Invoice"; "all fields")
				jsonSelectionToObject(->$obBuild; "InvoiceLine"; "all fields")
				
			: ($tableName="Proposal")
				jsonRecordToObject(->$obBuild; "Proposal"; "all fields")
				jsonSelectionToObject(->$obBuild; "ProposalLine"; "all fields")
			: ($tableName="PO")
				jsonRecordToObject(->$obBuild; "PO"; "all fields")
				jsonSelectionToObject(->$obBuild; "POLine"; "all fields")
			Else 
				jsonRecordToObject(->$obBuild; $tableName; "all fields")
		End case 
		C_POINTER:C301($1)
		[SyncRecord:109]obGeneral:16:=$obBuild
		[SyncRecord:109]size:38:=Length:C16(JSON Stringify:C1217($obBuild))
		SAVE RECORD:C53([SyncRecord:109])
		UNLOAD RECORD:C212([SyncRecord:109])
	End if 
End if 