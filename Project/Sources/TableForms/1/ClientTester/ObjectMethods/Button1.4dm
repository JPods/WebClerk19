
WebClientTest



If (False:C215)
	
	
	// (OM) HTTPClient_SendButton
	
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
	
	If ([SyncRelation:103]ScriptData:28#"")  // get any associated records
		ExecuteText(0; [SyncRelation:103]ScriptData:28)
	End if 
	
	HTTPSendText:=TagsToText(HTTPSendText)  // replace tags
	
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
	If (HTTPClient_Response="")
		HTTPClient_Response:="No Return"
	End if 
	
	
	If ([SyncRelation:103]ScriptAfter:11#"")
		ExecuteText(0; [SyncRelation:103]ScriptAfter:11)
	End if 
	
	
	SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)  // clear blob
End if 