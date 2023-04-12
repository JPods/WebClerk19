//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/05/18, 11:00:47
// ----------------------------------------------------
// Method: RP_JSONReceive
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($socket; $1)
C_OBJECT:C1216($objDataResponse)
C_LONGINT:C283($duration; $sizeIncoming)
C_BLOB:C604($outGoingBlob; $incomingBlob)
C_TEXT:C284($thePage)
C_TEXT:C284($vtjson)
// voState.socket:=$1
// should already be set

C_TEXT:C284($vtUUIDKey)

$sizeIncoming:=Length:C16(vWCPayload)
$duration:=Milliseconds:C459
$vtUUIDKey:=Substring:C12(voState.url; 8)
If (Length:C16($vtUUIDKey)>0)
	If ($vtUUIDKey[[1]]="/")
		$vtUUIDKey:=Substring:C12($vtUUIDKey; 2)
	End if 
End if 

If ($vtUUIDKey="")
	vResponse:="Error: id missing"
Else 
	QUERY:C277([SyncRelation:103]; [SyncRelation:103]id:30=$vtUUIDKey)
	Case of 
		: (Records in selection:C76([SyncRelation:103])#1)
			vResponse:="Error: id not found"
		: ((TCP Is Secure Connection(voState.socket)#1) & (Storage:C1525.wc.bforceSSL))
			vResponse:="Error: SSL connection required"
		: ($sizeIncoming=0)
			vResponse:="Error: No data received"
		: ((HTTP_Host#[SyncRelation:103]hostRemote:50) & ([SyncRelation:103]hostMatchRequired:51))
			vResponse:="Rejected: "+HTTP_Host+" does not match required host."
		Else 
			
			C_LONGINT:C283($vimillieseconds)
			$vimillieseconds:=Milliseconds:C459
			$vtjson:=vWCPayload  // use $vtjson to keep vWCPayload as is for reveiw
			
			C_TEXT:C284($jtDecrypted)
			If ([SyncRelation:103]encrypt:25)
				jsonEncryptDecrypt("encrypt"; ->vWCPayload)
			Else 
				$vtjson:=vWCPayload
			End if 
			
			ON ERR CALL:C155("OEC_Web")
			C_OBJECT:C1216($obPayload)
			
			error:=0
			
			$obPayload:=JSON Parse:C1218(vWCPayload)
			
			If (error#0)
				vResponse:="Data payload not formated as an object"
			Else 
				C_OBJECT:C1216($obSyncRecord)
				$obSyncRecord:=OB Get:C1224($obPayload; "SyncRecord")
				If (error#0)
					vResponse:="SyncRecord not an object of the payload."
				Else 
					vResponse:="Processing..."
					RP_SycnRecordReceived(->$obSyncRecord)  // save the changed record with the local uniqueID
					
					// If (voState.url="/RP_jsonData@")
					// vResponse:=RP_ReceivedData   // use variable vWCPayload  in Sync Script
					// Else 
					[SyncRecord:109]body:34:=vWCPayload
					[SyncRecord:109]obReceived:46:=JSON Parse:C1218(vWCPayload)
					vResponse:="Data stored in [SyncRecord]Body."
					//  End if 
					// ### bj ### 20190210_1237
					// store in the text field incase the partner sends poorly formated data
					// perhaps wrap in an on err call and manage this automatically
					// [SyncRecord]ObReceived:=json parse(vWCPayload)
					
					
					[SyncRecord:109]duration:35:=Milliseconds:C459-$vimillieseconds
					// ### bj ### 20190126_0301
					// can be overwritten in the RP_SycnRecordReceived
					[SyncRecord:109]idSyncRelation:49:=[SyncRelation:103]id:30
					
					[SyncRecord:109]request:22:=voState.url
					SAVE RECORD:C53([SyncRecord:109])
					
					
					If ([SyncRelation:103]scriptSyncRecord:48#"")
						vResponse:=""
						ExecuteText(0; [SyncRelation:103]scriptSyncRecord:48)
						// fill out vResponse
					Else 
						C_OBJECT:C1216($objDataResponse)
						OB SET:C1220($objDataResponse; "Response"; vResponse)
						OB SET:C1220($objDataResponse; "idNum"; [SyncRecord:109]idNum:1)
						OB SET:C1220($objDataResponse; "StatusSend"; [SyncRecord:109]statusSend:17)
						OB SET:C1220($objDataResponse; "StatusReceive"; [SyncRecord:109]statusReceive:19)
						OB SET:C1220($objDataResponse; "id"; [SyncRecord:109]id:43)
						OB SET:C1220($objDataResponse; "ActionReceive"; [SyncRecord:109]actionReceive:47)
						OB SET:C1220($objDataResponse; "ApprovedByReceive"; [SyncRecord:109]approvedByReceive:9)
						OB SET:C1220($objDataResponse; "ResolvedBy"; [SyncRecord:109]resolvedBy:33)
						OB SET:C1220($objDataResponse; "siteIDLocal"; [SyncRecord:109]siteIDLocal:13)
						OB SET:C1220($objDataResponse; "DTAction"; [SyncRecord:109]dtAction:2)
						OB SET:C1220($objDataResponse; "DTCompleted"; [SyncRecord:109]dtComplete:8)
						vResponse:=JSON Stringify:C1217($objDataResponse)
					End if 
				End if 
			End if 
	End case 
End if 

If (<>viDebugMode>410)
	ConsoleLog("RecordPassing")
	ConsoleLog(vResponse)
End if 
C_LONGINT:C283($viBytesSent)


// Second parameter can be set to the desired type verses a document path from which the extension is stripped and type matched
$viBytesSent:=WC_SendServerResponse(vResponse; "application/json")  // ### AZM ### 20180914 USE NEW SINGLE OUTPUT METHOD

If ([SyncRelation:103]scriptAfter:11#"")
	vResponse:=""
	ExecuteText(0; [SyncRelation:103]scriptAfter:11)
End if 

ON ERR CALL:C155("")



