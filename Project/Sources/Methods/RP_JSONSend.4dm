//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/13/18, 23:21:46
// ----------------------------------------------------
// Method: RP_JSONSend
// Description
// 
//
// Parameters
// ----------------------------------------------------

// MUST be defined:
//     vtRPUUIDKey to identify the Relationship Record to use
//     vtRPCommand to identify the task to be accomplished
// ### bj ### 20190127_1316 examples
// vtRPUUIDKey:="5DCB6F6CD86A4103A2BD1D2E93F8EC60"
// vtRPCommand:="POstoVendor"
// vtRPVendorID:="AZ"

// SyncRelation has fields for 
// IDofPartner  to communicate with a vendor
// IDatPartner  to communicate with a Customer


C_OBJECT:C1216($obComplete)
<>vConnectionStatus:=""
C_BLOB:C604(HTTP_IncomingBlob)
SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
SET BLOB SIZE:C606(HTTP_Data; 0)
C_TEXT:C284(HTTP_Cancel; $httpHeader)
C_LONGINT:C283(vWindowCurrent; $sizeResponse)

WC_InitRequest
WC_ServerInit

C_TEXT:C284(vtRPjson)  // use a proess variable incase it is useful elsewhere and for debugging
vtRPjson:=""

If (Record number:C243([SyncRelation:103])<0)  // must have a [SyncRelation] ;[SyncRelation]Name="testRP_32")  // get the relationship exchange pair
	QUERY:C277([SyncRelation:103]; [SyncRelation:103]id:30=vtRPUUIDKey)
Else 
	vtRPUUIDKey:=[SyncRelation:103]id:30
End if 

If (Record number:C243([SyncRelation:103])>-1)
	//setup the relationship variables
	RP_LoadVariablesRelationship
	
	C_LONGINT:C283($viMilliSecs)
	$viMilliSecs:=Milliseconds:C459
	$path:=HTTP_Path  //store original path to execute, restore in line 47
	//HTTP_Path:="/heart_beat"
	//$error:=WC_Request ("GET";->HTTP_IncomingBlob)//Sends Blob: HTTP_Data 
	//HTTP_Path:=$path
	eventID_Cookie:=""  //initial contact, clear existing cookie
	C_LONGINT:C283($sizeResponse)
	SET BLOB SIZE:C606(HTTP_Data; 0)
	
	C_OBJECT:C1216(obDataSync; $objSyncRecord; $obData)
	
	// ### bj ### 20181121_0220
	// adde the ability to simple send the users own json
	C_TEXT:C284($vtDataToSend)  // creates data to send
	// if a SyncRecord is not there, it is sending and automatically created
	// double check
	// CREATE RECORD([SyncRecord])
	//  [SyncRecord]Direction:="Sending"  // needed for RP_DataTasks
	
	If (vDataToSend="")
		RP_DataTasks(->obDataSync)
		// vtRPjson also has the data for debugging
		// obtRPObject
	Else 
		C_OBJECT:C1216($obData)
		$obData:=JSON Parse:C1218(vDataToSend)
		OB SET:C1220(obDataSync; "body"; $obData)
		
		C_OBJECT:C1216($obHeader)
		jsonCreateHeader(->$obHeader; [SyncRelation:103]name:8; [SyncRelation:103]description:43)
		RP_SyncRecordSending(Length:C16(JSON Stringify:C1217(obDataSync)))  // ;$script)  //just builds the Sync Record
		
		OB SET:C1220(obDataSync; "head"; $obHeader)
		jsonRecordToObject(->obDataSync; "SyncRecord")  //  send all the fields, sort out later if this is too much
		
	End if 
	[SyncRecord:109]obReceived:46:=obDataSync
	vWCPayload:=JSON Stringify:C1217(obDataSync)
	
	ON ERR CALL:C155("jOECNoAction")
	
	
	
	If ([SyncRelation:103]encrypt:25)
		TEXT TO BLOB:C554(vWCPayload; HTTP_Data; Mac text without length:K22:10)
		ENCRYPT BLOB:C689(HTTP_Data; [SyncRelation:103]privateKey:45)  // encrypt
		$vtToSent:=BLOB to text:C555(HTTP_Data; Mac text without length:K22:10)
		If (False:C215)
			TEXT TO BLOB:C554(vWCPayload; HTTP_Data; UTF8 text without length:K22:17)
			ENCRYPT BLOB:C689(HTTP_Data; [SyncRelation:103]privateKey:45)  // encrypt
			$vtToSent:=BLOB to text:C555(HTTP_Data; Mac text without length:K22:10)
			
			TEXT TO BLOB:C554(vWCPayload; HTTP_Data; Mac text without length:K22:10)
			ENCRYPT BLOB:C689(HTTP_Data; [SyncRelation:103]privateKey:45)  // encrypt
			$vtToSent:=BLOB to text:C555(HTTP_Data; UTF8 text without length:K22:17)
			
			TEXT TO BLOB:C554(vWCPayload; HTTP_Data; UTF8 text without length:K22:17)
			ENCRYPT BLOB:C689(HTTP_Data; [SyncRelation:103]privateKey:45)  // encrypt
			$vtToSent:=BLOB to text:C555(HTTP_Data; UTF8 text without length:K22:17)
		End if 
		
	Else 
		TEXT TO BLOB:C554(vWCPayload; HTTP_Data; UTF8 text without length:K22:17)
	End if 
	
	// HTTP_Path:=HTTP_Path  // maybe a path in a post cannot have parameters 
	// HTTP_Data blob of data to send
	
	C_BLOB:C604($responseBlob)
	SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)  // prepare for response
	// HTTP_Data must be populated
	$error:=WC_Request("POST")
	// Sends and receives a response; add header; save blob on path
	//  header elements can be added in matchedpairformat, "name,value;name2,value3;{...})
	
	C_TEXT:C284($vtResponse)
	
	C_TEXT:C284($syncStatus)
	C_TEXT:C284($vtDateTime)
	// zzzqqq jDateTimeStamp(->$vtDateTime)
	$syncStatus:=$vtDateTime+",Begin Local = "+[SyncRecord:109]statusSend:17+", Remote = "+[SyncRecord:109]statusReceive:19
	[SyncRecord:109]comment:25:=$syncStatus+"\r"+[SyncRecord:109]comment:25
	[SyncRecord:109]statusSend:17:="Failed"
	[SyncRecord:109]statusReceive:19:=""
	[SyncRecord:109]duration:35:=Milliseconds:C459-$viMilliSecs
	
	
	C_OBJECT:C1216($objIncoming)
	Case of 
		: (vResponse="Fail@")
			//
		: (vWCPayload="")
			vResponse:="Timed out or failed to communicate, duration: "+String:C10([SyncRecord:109]duration:35)
		Else 
			If (vWCPayload[[1]]#"{")
				If (Length:C16(vWCPayload)>8000)
					[SyncRecord:109]packingNotes:14:="Clipped to 8000: "+Substring:C12(vWCPayload; 1; 8000)
				Else 
					[SyncRecord:109]packingNotes:14:=vWCPayload
				End if 
			Else 
				$objIncoming:=JSON Parse:C1218(vWCPayload)  //
				[SyncRecord:109]packingNotes:14:=OB Get:C1224($objIncoming; "PackingNotes")
				[SyncRecord:109]statusSend:17:=OB Get:C1224($objIncoming; "StatusSend")
				[SyncRecord:109]statusReceive:19:=OB Get:C1224($objIncoming; "StatusReceive")
				[SyncRecord:109]ideRemote:27:=OB Get:C1224($objIncoming; "idNum")
				//[SyncRecord]rs1:=OB Get($objIncoming; "id")
				//If (([SyncRecord]rs1#"") & ([SyncRecord]UniqueIDRemote>0))
				//[SyncRecord]StatusSend:="Sent"
				//[SyncRecord]DTCompleted:=DateTime_Enter
				//[SyncRecord]DTAction:=[SyncRecord]DTCompleted
				//End if 
				[SyncRecord:109]actionReceive:47:=OB Get:C1224($objIncoming; "ActionReceive")
				[SyncRecord:109]approvedByReceive:9:=OB Get:C1224($objIncoming; "ApprovedByReceive")
				[SyncRecord:109]resolvedBy:33:=OB Get:C1224($objIncoming; "ResolvedBy")
				[SyncRecord:109]siteIDRemote:20:=OB Get:C1224($objIncoming; "siteIDLocal")
				[SyncRecord:109]dtAction:2:=OB Get:C1224($objIncoming; "DTAction")
				[SyncRecord:109]dtComplete:8:=OB Get:C1224($objIncoming; "DTCompleted")
				vResponse:=$vtDateTime+",End Local = "+[SyncRecord:109]statusSend:17+", Remote = "+[SyncRecord:109]statusReceive:19
			End if 
	End case 
	[SyncRecord:109]comment:25:=vResponse+"\r"+[SyncRecord:109]comment:25
	SAVE RECORD:C53([SyncRecord:109])
	
	
	If ([SyncRelation:103]scriptAfter:11#"")
		ExecuteText(0; [SyncRelation:103]scriptAfter:11)
	End if 
	
End if 
ON ERR CALL:C155("")

ReduceSelectAll  // cleanup
vtRPjson:=""
SET BLOB SIZE:C606(Http_Data; 0)
SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
vWCPayload:=""

If (False:C215)  // tinkering
	
	
	If (False:C215)  // tried and failed to send an encrypted 
		// would like to encrypt the blob to be sent, 
		// chech the UUDI match on the other side
		// then decrypt the blob sent
		
		If ([SyncRelation:103]name:8#"testRP_32")
			QUERY:C277([SyncRelation:103]; [SyncRelation:103]name:8="testRP_32")  // get the relationship exchange pair
		End if 
		
		C_TEXT:C284($vtest)
		$vtest:=BLOB to text:C555(HTTP_Data; UTF8 text without length:K22:17)
		C_TEXT:C284($vUnpack)
		BLOB TO VARIABLE:C533(HTTP_Data; $vUnpack)
		ENCRYPT BLOB:C689(HTTP_Data; [SyncRelation:103]privateKey:45)  // encrypt
		
		// do date, could not find a way to retrieve this as text and send as text
		
		C_BLOB:C604($blobToDecrypt)
		COPY BLOB:C558(HTTP_Data; $blobToDecrypt; 0; 0; BLOB size:C605(HTTP_Data))
		DECRYPT BLOB:C690($blobToDecrypt; [SyncRelation:103]publicKey:46)  // encrypt
		C_TEXT:C284($vtTest)
		$vtTest:=BLOB to text:C555($blobToDecrypt; UTF8 text without length:K22:17)
	End if 
	
End if 