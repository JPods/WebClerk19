//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/04/09, 16:34:38
// ----------------------------------------------------
// Method: B2B_Exchange
// Description
// 
//
// Parameters
// ----------------------------------------------------


KeyModifierCurrent
If (capkey=1)
	
End if 


C_LONGINT:C283(HTTP_TestMode; HTTP_TimeOut; HTTP_Port)
C_TEXT:C284(HTTP_Protocol; HTTP_Method; HTTP_Path; HTTP_Host; HTTP_APIKey)
C_LONGINT:C283(HTTP_TimeOut)
C_BLOB:C604(HTTP_BlobSendData; HTTP_BlobReceive)
C_BOOLEAN:C305($doTest)
$doTest:=False:C215
If ($doTest)
	HTTP_TestMode:=2  //set in test mode
	HTTP_TimeOut:=10  //seconds
	HTTP_Protocol:="http"  //process as SSL
	HTTP_Method:="Get"  //method of sending
	HTTP_Path:="index.html"  //Server command
	HTTP_Host:="www.webclerk.com"  //Server manchine
	HTTP_Port:=80  //the Port
	
	SET BLOB SIZE:C606(HTTP_BlobSendData; 0)
	//HTTP_BlobSendData//data to send
	//HTTP_BlobReceive//data received back
End if 

//HTTP_TestMode:=1 set in test mode
//HTTP_TimeOut:=10//seconds
//HTTP_Protocol:="https"//process as SSL
//HTTP_Method:="Post"  //method of sending
//HTTP_Path:=<>tcCCVerURL//Server command
//HTTP_Host:=<>tcCCVerHost//Server manchine
//HTTP_Port:=<>tcCCVerPort//the Port
//HTTP_BlobSendData  //data to send
//HTTP_BlobReceive   //data received back
// HTTP_APIKey   // Key to access account
// vWCPayload
C_TEXT:C284($requestText)

//
C_TEXT:C284($headers; $options)
C_LONGINT:C283($0; $error; $socket; $timeoutAt; $bytesSend; $position)
C_LONGINT:C283(HTTP_TestMode)
$error:=-1
// Clear the response blob
SET BLOB SIZE:C606(HTTP_BlobReceive; 0)
C_BLOB:C604($headerBlob)  //blog with header

// If we have a GET request append the data as request parameters
If ((HTTP_Method="GET") & (BLOB size:C605(HTTP_BlobSendData)>0))
	HTTP_Path:=HTTP_Path+"?"+BLOB to text:C555(HTTP_BlobSendData; UTF8 text without length:K22:17)
End if 

// Build the HTTP headers
//Storage.char.crlf:=Char(Carriage return)+Char(Line feed)
$headers:=HTTP_Method+" "+HTTP_Path+" HTTP/1.1"+Storage:C1525.char.crlf
$headers:=$headers+"User-Agent: WebClerk-CommerceExpert HTTP Client"+Storage:C1525.char.crlf
$headers:=$headers+"Host: "+HTTP_Host+Storage:C1525.char.crlf
$headers:=$headers+"Accept: */*"+Storage:C1525.char.crlf
$headers:=$headers+"Connection: close"+Storage:C1525.char.crlf

// For a POST request we need to add a content-length header
If (HTTP_Method="POST")
	$headers:=$headers+"Content-Length: "+String:C10(BLOB size:C605(HTTP_BlobSendData))+Storage:C1525.char.crlf
	$headers:=$headers+"Content-Type: application/x-www-form-urlencoded"+Storage:C1525.char.crlf
End if 

// Important: the headers must end with a blank line
$headers:=$headers+Storage:C1525.char.crlf
// Convert the headers to a blob
TEXT TO BLOB:C554($headers; $headerBlob; UTF8 text without length:K22:17)

// For a POST request we append the data to the headers
If (HTTP_Method="POST")
	COPY BLOB:C558(HTTP_BlobSendData; $headerBlob; 0; BLOB size:C605($headerBlob); BLOB size:C605(HTTP_BlobSendData))
	//COPY BLOB (srcBLOB; dstBLOB; srcOffset; dstOffset; len)
End if 

$options:="connect-timeout="+String:C10(HTTP_TimeOut)

If (HTTP_Protocol="https")
	$options:=$options+" ssl=true"
End if 

If (HTTP_TestMode>0)
	CREATE RECORD:C68([EventLog:75])
	
	[EventLog:75]dtEvent:1:=DateTime_Enter
	If ([EventLog:75]dtEvent:1<=<>lELogLastDT)  //don't create one with the same DTEvent
		[EventLog:75]dtEvent:1:=<>lELogLastDT+1  //this happens after last
	End if 
	[EventLog:75]groupid:3:="B2B_Exchange"
	$response:=BLOB to text:C555(HTTP_BlobSendData; UTF8 text without length:K22:17)
	EventLogsMessage("Host: "+HTTP_Host+"\r"+"Protocol: "+HTTP_Protocol+"\r"+"Port: "+String:C10(HTTP_Port)+"\r"+"Method: "+HTTP_Method+"\r"+"Path: "+HTTP_Path+"\r"+"Options: "+$options+"\r"+"BlobSize: "+String:C10(BLOB size:C605(HTTP_BlobSendData))+"\r"+"// Begin //"+"\r"+$requestText+"\r"+"// End //")
	[EventLog:75]addressIPRemote:18:=HTTP_Host
End if 

// Set the timeout and open a connection
$socket:=TCP Open(HTTP_Host; HTTP_Port; $options)

If ($socket#0)
	C_BLOB:C604($incomingBlob)
	SET BLOB SIZE:C606($incomingBlob; 0)
	// Send the request
	$bytesSend:=TCP Send Blob($socket; $headerBlob)
	$timeoutAt:=Milliseconds:C459+(HTTP_TimeOut*1000)
	
	// Get the response (wait until the connection is closed)
	While ((TCP Get State($socket)#TCP Connection Closed) & (Milliseconds:C459<$timeoutAt))
		If (TCP Receive Blob($socket; $incomingBlob)>0)
			COPY BLOB:C558($incomingBlob; HTTP_BlobReceive; 0; BLOB size:C605(HTTP_BlobReceive); BLOB size:C605($incomingBlob))
		Else 
			DELAY PROCESS:C323(Current process:C322; 1)
		End if 
	End while 
	// Close the connection
	TCP Close($socket)
	$error:=BLOB size:C605(HTTP_BlobReceive)
	
End if 
$0:=$error
