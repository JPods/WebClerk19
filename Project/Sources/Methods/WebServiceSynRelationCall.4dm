//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-09-16T00:00:00, 14:23:38
// ----------------------------------------------------
// Method: WebServiceSynRelationCall
// Description
// Modified: 09/16/16
// 
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $tallyName; $2)

// Process Variables can flow from outside or be assigned in the scripts
// HTTPClient_Response falls out the bottom
$textToSend:=""
Case of 
	: (Count parameters:C259=0)
		$tallyName:="test"
		// HTTPSendText:=""  allow value to pass in
	: (Count parameters:C259=1)
		$tallyName:=$1
		// HTTPSendText:=""  allow value to pass in
	Else 
		$tallyName:=$1
		HTTPSendText:=$2
End case 

QUERY:C277([SyncRelation:103]; [SyncRelation:103]Name:8=$tallyName)
If (Records in selection:C76([SyncRelation:103])=1)
	NTK_DeleteRequest  // clear existing values
	SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
	SET BLOB SIZE:C606(HTTP_Data; 0)  // initialize blob
	
	If ([SyncRelation:103]TallyMastersScript:10#"")
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]Name:8=[SyncRelation:103]TallyMastersScript:10; *)
	End if 
	If ([SyncRelation:103]ScriptBefore:7#"")
		ExecuteText(0; [SyncRelation:103]ScriptBefore:7)
	End if 
	
	// leave HTTPSendText alone if it already has a value
	If ((HTTPSendText="") & ([SyncRelation:103]Template:39#""))  // fixed outside the procedure
		HTTPSendText:=TagsToText([SyncRelation:103]Template:39)  // changed from Script
	End if 
	
	TEXT TO BLOB:C554(HTTPSendText; HTTP_Data; Mac text without length:K22:10; *)  // convert text to blob for sending
	
	//Set the default properties (url and empty data/blob )
	//Parse HTTPClient_URL into HTTP_URL,HTTP_Protocol,HTTP_Host,HTTP_Path,HTTP_Port
	
	If ([SyncRelation:103]TestMode:37)
		HTTPClient_URL:=[SyncRelation:103]Partner2URL:33
		// HTTPClient_URL:="https://wwwcie.ups.com/ups.app/xml/TimeInTransit"  //set URL Test Environment
		NTK_SetURL(HTTPClient_URL)  // get the protocol
		// HTTP_Protocol
		// HTTP_Host
		// HTTP_Path
		If ([SyncRelation:103]PortTest:34#0)
			HTTP_Port:=[SyncRelation:103]PortTest:34  // override
		End if 
	Else 
		HTTPClient_URL:=[SyncRelation:103]Partner1URL:2
		// HTTPClient_URL:="https://onlinetools.ups.com/ups.app/xml/TimeInTransit"  //set URL Production Environment
		NTK_SetURL(HTTPClient_URL)  // get the protocol
		// HTTP_Protocol
		// HTTP_Host
		// HTTP_Path
		If ([SyncRelation:103]PortProduction:9#0)
			HTTP_Port:=[SyncRelation:103]PortProduction:9  // override
		End if 
	End if 
	HTTP_TimeOut:=[SyncRelation:103]TimeOut:16
	HTTP_TimeOut:=20  //seconds
	
	
	If ([SyncRelation:103]RequestMethod:38="Get")
		$error:=WC_Request("Get")  //Sends Blob: HTTP_Data Passes "Get" or "Post"
	Else 
		$error:=WC_Request("Post")  //Sends Blob: HTTP_Data Passes "Get" or "Post"
	End if 
	HTTPClient_Response:=BLOB to text:C555(HTTP_IncomingBlob; Mac text without length:K22:10)
	
	If ([SyncRelation:103]ScriptData:28#"")
		ExecuteText(0; [SyncRelation:103]ScriptData:28)
	End if 
	
	If ([SyncRelation:103]ScriptAfter:11#"")
		ExecuteText(0; [SyncRelation:103]ScriptAfter:11)
	End if 
End if 