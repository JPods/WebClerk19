//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-11-26T00:00:00, 18:46:56
// ----------------------------------------------------
// Method: WebClientTest
// Description
// Modified: 11/26/16
// 
// 
//
// Parameters
// ----------------------------------------------------

// (OM) HTTPClient_SendButton

If ((Records in selection:C76([SyncRelation:103])=1) | ((PTCURTABLE=(->[SyncRelation:103])) & (vHere>1)))
	HTTPFullSend:=""
	HTTPSendText:=""
	HTTP_ContentType:=""
	HTTPTestMode:=1
	HTTP_TestMode:=1
	HTTPClient_GetRequest:=1
	HTTPClient_PostRequest:=0
	HTTPClient_Response:=""
	If ([SyncRelation:103]TestMode:37)
		HTTPClient_URL:=[SyncRelation:103]Partner2URL:33
	Else 
		HTTPClient_URL:=[SyncRelation:103]Partner1URL:2
	End if 
	HTTPSendText:=[SyncRelation:103]Template:39
	HTTP_ContentType:=[SyncRelation:103]ContentType:44
	
	If ([SyncRelation:103]RequestMethod:38="Post@")
		HTTPClient_PostRequest:=1
		HTTPClient_GetRequest:=0
	Else 
		HTTPClient_PostRequest:=0
		HTTPClient_GetRequest:=1
	End if 
End if 

C_LONGINT:C283($index; $error)
C_BLOB:C604(HTTP_IncomingBlob)

// Initiate a new request
//ntk_NewRequest(HTTPClient_URL)  Extracted components below

// (PM) HTTP_NewRequest
// Initializes a new HTTP request
// $1 = URL

NTK_DeleteRequest  //clear existing values

C_TEXT:C284($1; HTTP_URL; HTTP_Protocol; HTTP_Host; HTTP_Path)
C_LONGINT:C283(HTTP_Port; HTTP_TimeOut)
C_BLOB:C604(HTTP_Data)

// Set the default properties (url and empty data/blob)
NTK_SetURL(HTTPClient_URL)
SET BLOB SIZE:C606(HTTP_Data; 0)
HTTP_TimeOut:=10  //seconds


If ([SyncRelation:103]ScriptData:28#"")  // get any associated records
	ExecuteText(0; [SyncRelation:103]ScriptData:28)
End if 

HTTPSendText:=TagsToText(HTTPSendText)  // replace tags

If (HTTPSendText#"")
	SET BLOB SIZE:C606(HTTP_Data; 0)
	TEXT TO BLOB:C554(HTTPSendText; HTTP_Data; UTF8 text without length:K22:17; *)
Else 
	// Add the request parameters
	For ($index; 1; Size of array:C274(HTTPClient_ParamName))
		NTK_AddRequestParameter(HTTPClient_ParamName{$index}; HTTPClient_ParamValue{$index})
	End for 
End if 

If (False:C215)
	If ([SyncRelation:103]Template:39#"")
		HTTPSendText:=[SyncRelation:103]Template:39
	End if 
End if 



// Send the request
Case of 
	: (HTTPClient_GetRequest=1)
		$error:=WC_Request("GET")
	: (HTTPClient_PostRequest=1)
		$error:=WC_Request("POST")
End case 

// Clean up
//NTK_DeleteRequest 

HTTPClient_Response:=BLOB to text:C555(HTTP_IncomingBlob; UTF8 text without length:K22:17)

If (False:C215)
	SET TEXT TO PASTEBOARD:C523(HTTPClient_Response)
End if 
If (HTTPClient_Response="")
	HTTPClient_Response:="No Return"
End if 
C_TEXT:C284($crlf; XML_Response)
$crlf:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
C_LONGINT:C283($p)
$p:=Position:C15($crlf+$crlf; HTTPClient_Response)
If ($p>0)
	XML_Response:=Substring:C12(HTTPClient_Response; $p+4)
End if 


If ([SyncRelation:103]ScriptAfter:11#"")
	ExecuteText(0; [SyncRelation:103]ScriptAfter:11)
End if 


SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)  // clear blob
