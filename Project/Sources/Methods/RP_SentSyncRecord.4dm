//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-10-15T00:00:00, 17:32:53
// ----------------------------------------------------
// Method: RP_SentSyncRecord
// Description
// Modified: 10/15/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

// ### bj ### 20181029_2250
// FIXTHIS as soon as practical
// placeholder for messaging sandbox

<>vConnectionStatus:=""
C_BLOB:C604(HTTP_IncomingBlob)
SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
SET BLOB SIZE:C606(HTTP_Data; 0)
C_TEXT:C284(HTTP_Cancel; $httpHeader)
C_LONGINT:C283(vWindowCurrent)
C_LONGINT:C283(thermoProcess)
ThermoLaunchProcess
$path:=HTTP_Path  //store original path to execute, restore in line 47
//HTTP_Path:="/heart_beat"
//$error:=NTK_Request ("GET";->HTTP_IncomingBlob)//Sends Blob: HTTP_Data 
//HTTP_Path:=$path
eventID_Cookie:=""  //initial contact, clear existing cookie
SET BLOB SIZE:C606(HTTP_Data; 0)
$sizeResponse:=WC_Request("GET"; HTTP_URL+"/heart_beat"; "")  //Sends empth 

SET BLOB SIZE:C606(HTTP_Data; 0)
If ($sizeResponse>0)
	If ([SyncRelation:103]idNum:1#vUniqueID)
		QUERY:C277([SyncRelation:103]; [SyncRelation:103]idNum:1=vUniqueID)
	End if 
	CREATE RECORD:C68([ETLJob:104])
	
	[ETLJob:104]dtCreated:5:=DateTime_Enter
	//[ETLJob]idCustomer:=[SyncRelation]idNum
	[ETLJob:104]addressSending:7:=[SyncRelation:103]partner1URL:2
	[ETLJob:104]status:4:="Processing"
	[ETLJob:104]description:2:=eventID_Cookie
	//[SyncExchange]CountSyncBlobs:=$k
	SAVE RECORD:C53([ETLJob:104])
	<>vConnectionStatus:="Have heart_beat"
	//VARIABLE TO VARIABLE(<>ProcThermoProcess;vNewThermometerTitle;<>vConnectionStatus)
	
	//  Http_SrchUserOnly  search user
	//  WC_ServerRP is the receiver
	
	
	POST OUTSIDE CALL:C329(<>ProcThermoProcess)
	HTTP_Path:="/search_user?username="+vUsername+"&password="+vPassword+"&jitPageOne=noticeOnly&emailsender="+[SyncRelation:103]partner1Email:18+"&SecurityLevel=5&syncExchangeRemote="+String:C10([ETLJob:104]idNum:1)+"&syncRelationID="+String:C10([SyncRelation:103]idNum:1)+"&syncRelation="+[SyncRelation:103]name:8
	
	// "jitPageOne=noticeOnly" is required so the returning message sends "Password=Approved"
	
	SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
	C_LONGINT:C283($lenReply)
	$lenReply:=WC_Request("GET")  //Sends Blob: HTTP_Data 
	HTTP_Path:=$path  //restore original path to execute, line 29
	If ($lenReply>0)
		
		$httpHeader:=BLOB to text:C555(HTTP_IncomingBlob; UTF8 text without length:K22:17)
		SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
		C_LONGINT:C283($p)
		$p:=Position:C15("Reply?"; $httpHeader)
		vWCPayload:=Substring:C12($httpHeader; $p+6)
		WC_ParseRequestParameter
		
		[ETLJob:104]ideRemote:11:=Num:C11(WCapi_GetParameter("syncExchangeRemote"; ""))
		[ETLJob:104]syncRelationIDRemote:12:=Num:C11(WCapi_GetParameter("syncRelationID"; ""))
		
		SAVE RECORD:C53([ETLJob:104])
		HTTP_Cancel:=""
		If (Position:C15("Password=Approved"; $httpHeader)<1)
			ALERT:C41("Signin Failed")
		Else 
			//SET PROCESS VARIABLE(<>ProcThermoProcess;Variable1;<>vConnectionStatus)
			//POST OUTSIDE CALL(<>ProcThermoProcess)
			//VARIABLE TO VARIABLE(<>ProcThermoProcess;Variable1;<>vConnectionStatus)
			//POST OUTSIDE CALL(<>ProcThermoProcess)
			C_TEXT:C284(vNewThermometerTitle; <>vConnectionStatus)
			//SET PROCESS VARIABLE(thermoProcess;vNewThermometerTitle;<>vConnectionStatus)
			POST OUTSIDE CALL:C329(thermoProcess)
			//jMessageWindow (<>vConnectionStatus;2)
			dtSession:=DateTime_Enter
			
			
			
			// RP_PushRecords
			// ### bj ### 20181029_2250
			// FIXTHIS as soon as practical
			// placeholder for messaging sandbox
			
			
			C_LONGINT:C283($sizeResponse)
			SET BLOB SIZE:C606(HTTP_Data; 0)
			$sizeResponse:=WC_Request("GET"; HTTP_URL+"/heart_beat"; "")  //Sends empth 
			
			HTTP_Path:="RP_StatusExchange?syncExchangeRemote="+String:C10([ETLJob:104]ideRemote:11)+"&action=completeexchange"
			
			If ($error>0)
				$httpHeader:=BLOB to text:C555(HTTP_IncomingBlob; UTF8 text without length:K22:17)
				$p:=Position:C15("message=ReceiveComplete"; $httpHeader)
				If ($p>0)
					[ETLJob:104]status:4:="SendCompleted"
				Else 
					[ETLJob:104]status:4:="NotClosed"
				End if 
			Else 
				[ETLJob:104]status:4:="Terminated"
			End if 
			[ETLJob:104]duration:14:=DateTime_Enter-dtSession
			SAVE RECORD:C53([ETLJob:104])
			//
			
			// QUERY([SyncRecord];[SyncRecord]DTCreated=dtSession)
			//QUERY([SyncRecord];[SyncRecord]SynExchangeIDLocal=[SyncExchange]UniqueID)
			DB_ShowCurrentSelection(->[SyncRecord:109])
			ALERT:C41("Posting complete.")
			DB_ShowCurrentSelection(->[ETLJob:104])
		End if 
		
		
		C_LONGINT:C283($i; $k)
		$k:=Get last table number:C254
		For ($i; 1; $k)
			If (Records in selection:C76(Table:C252($i)->)>0)
				If ($i#(Table:C252(->[SyncRelation:103])))
					UNLOAD RECORD:C212(Table:C252($i)->)
				End if 
			End if 
		End for 
		
		QUERY:C277([SyncRelation:103]; [SyncRelation:103]active:17=True:C214)
		FIRST RECORD:C50([SyncRelation:103])
		//  CHOPPED  AL_UpdateFields(eSyncSelection; 2)
		
	Else 
		//ALERT("Error in communicating, CapKey to copy to clipboard")
		//KeyModifierCurrent 
		If ((CapKey=1) | (OptKey=1))
			SET TEXT TO PASTEBOARD:C523($httpHeader)
		End if 
	End if 
End if 