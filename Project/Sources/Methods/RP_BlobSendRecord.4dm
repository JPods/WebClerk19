//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/04/06, 20:35:18
// ----------------------------------------------------
// Method: RP_BlobSendRecord
// Description
// 
//
// Parameters
// ----------------------------------------------------
//  // ### bj ### 20210202_2231
//  rewrite this
//record must loaded
C_BLOB:C604($blob)
C_TEXT:C284($blobText)
C_LONGINT:C283($error; $0)
//C_TEXT($incomingText;$1)
C_LONGINT:C283($stream)
C_TEXT:C284($commentText; $1)
If (Count parameters:C259>0)
	$commentText:=$1
End if 

C_BLOB:C604(HTTP_IncomingBlob)
//NTK_SetURL ($url)//this is controlled by the setting.  Do not use this in special 

//variables that must be set for WC_Request to work
//$1 : is the request method GET or POST
//$2 : is the returning blob
//HTTP_TimeOut : seconds 
//HTTP_Protocol to use "https"or "http"
//HTTP_Path//  voState.request.URL.href
//HTTP_Host    //machine to send to
//HTTP_Port    //port
//HTTP_Data    //blob of data to send

CREATE RECORD:C68([ETLJob:104])  // long the transaction  Consolidate into SyncRecord
[ETLJob:104]dtCreated:5:=DateTime_Enter
//[ETLJob]idCustomer:=[SyncRelation]idNum
[ETLJob:104]addressSending:7:=[SyncRelation:103]partner1URL:2
[ETLJob:104]status:4:="Processing"
[ETLJob:104]description:2:=eventID_Cookie
[ETLJob:104]comment:15:=$commentText
//[SyncExchange]CountSyncBlobs:=$k
SAVE RECORD:C53([ETLJob:104])
<>vConnectionStatus:="Have heart_beat"



$error:=WC_Request("POST")  //Sends Blob: HTTP_Data 
//deal with the error here
$0:=$error
If ($error<=0)
	<>vConnectionStatus:="Timed Out: "+String:C10([SyncRecord:109]tableNum:4)+": "+[SyncRecord:109]fieldValue:6
	[SyncRecord:109]statusSend:17:="Timed Out"
	SAVE RECORD:C53([SyncRecord:109])
	UNLOAD RECORD:C212([SyncRecord:109])
	POST OUTSIDE CALL:C329(thermoProcess)
Else 
	<>vConnectionStatus:="Sending: "+String:C10([SyncRecord:109]tableNum:4)+": "+[SyncRecord:109]fieldValue:6
	POST OUTSIDE CALL:C329(<>ProcThermoProcess)
	C_TEXT:C284($httpHeader)
	$httpHeader:=BLOB to text:C555(HTTP_IncomingBlob; UTF8 text without length:K22:17)
	WC_ParseHTTPHeaders($httpHeader)
	
	// Check if we have content for the request (in case it is a POST or PUT request)
	$contentLength:=Num:C11(PageGetHeader("Content-Length"))
	
	WC_ParseRequestParameter  //vText11:=$httpHeader//force NTK to match current data handling.
	[SyncRecord:109]cookie:39:=eventID_Cookie
	
	[SyncRecord:109]ideRemote:27:=Num:C11(WCapi_GetParameter("SyncRecordIDRemote"; ""))
	[SyncRecord:109]statusReceive:19:=WCapi_GetParameter("StatusRemote"; "")
	If ([SyncRecord:109]statusReceive:19="Received")  // if it times out or does not get acknowledged.
		[ETLJob:104]countAccepted:8:=[ETLJob:104]countAccepted:8+1
	Else 
		[ETLJob:104]countRejected:9:=[ETLJob:104]countRejected:9+1
	End if 
	[SyncRecord:109]statusSend:17:="Acknowledged"
	[SyncRecord:109]dtComplete:8:=Num:C11(WCapi_GetParameter("DTCompleted"; ""))
	If ([SyncRecord:109]tableNum:4=Table:C252(->[Order:3]))
		QUERY:C277([Order:3]; [Order:3]idNum:2=Num:C11([SyncRecord:109]fieldValue:6))
		[Order:3]remoteRecordID:132:=[SyncRecord:109]statusReceive:19
		SAVE RECORD:C53([Order:3])
		REDUCE SELECTION:C351([Order:3]; 0)
	End if 
	//[SyncRecord]StatusRemote:=WCapi_GetParameter(->vText11;"StatusLocal";"")
	//SET PROCESS VARIABLE(thermoProcess;vNewThermometerTitle;"Status Remote: "+[SyncRecord]StatusRemote)
	<>vConnectionStatus:="Status Remote: "+[SyncRecord:109]statusReceive:19+": "+String:C10([SyncRecord:109]tableNum:4)+": "+[SyncRecord:109]fieldValue:6
	POST OUTSIDE CALL:C329(<>ProcThermoProcess)
	[SyncRecord:109]duration:35:=Round:C94((Milliseconds:C459-[SyncRecord:109]duration:35)/1000; 0)
	SAVE RECORD:C53([SyncRecord:109])
	UNLOAD RECORD:C212([SyncRecord:109])
	
	//[ETLJob]config:=[ETLJob]config+1
End if 

SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)