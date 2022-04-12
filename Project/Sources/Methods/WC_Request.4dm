//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/04/09, 16:33:38
// ----------------------------------------------------
// Method: WC_Request
// Description
// Performs the actual HTTP request
// $1 = Request method (GET or POST)
// $2 = Pointer to blob with response
// $0 = Error code
// ----------------------------------------------------
//BEFORE CALLING THIS PROCEDURE
//variables that must be set for WC_Request to work
//$1 : is the request method GET or POST
//$2 : is the returning blob
//HTTP_TimeOut : seconds 
//HTTP_Protocol to use "https"or "http"
//HTTP_Path//  voState.request.URL.pathName
//HTTP_Host    //machine to send to
//HTTP_Port    //port
//HTTP_Data    //blob of data to send


//<>viDebugMode>410    //sends feed back to Console

//HTTP_IncomingBlob is the response back from the remote server
// ----------------------------------------------------
C_LONGINT:C283($bytesRead; $position; $contentLength; $timeoutAt; $port; $timeoutHit; <>vHitTimeOut; $err)
C_BOOLEAN:C305($continue)
C_TEXT:C284($buffer; $httpHeader)
C_BLOB:C604($blobReadIn)
C_LONGINT:C283($theDelay)

WCapi_voStateSetup
C_TEXT:C284($1; $requestMethod; $headers; $path; $crlf; $options; eventID_Cookie)
C_TEXT:C284($2; $path)
C_TEXT:C284($3; $headerAdds)
C_TEXT:C284($4; $dataToSend)
C_LONGINT:C283($0; $responseSize; $timeoutAt; $bytesSend; $position; $cntAdders; $incAdders)
C_BLOB:C604(HTTP_SendingBlob; HTTP_Data)
C_LONGINT:C283(HTTP_TestMode; $myOK)
WCapi_voStateSetup
$myOK:=1
$requestMethod:=$1
$responseSize:=-1
// (count parameters=2)  see below

// Clear the response blob
SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
$headerAdds:=""
$dataToSend:=""
If (Count parameters:C259>1)
	$path:=$2
	If (Count parameters:C259>2)
		$headerAdds:=$3
		If (Count parameters:C259>3)
			$dataToSend:=$4
		End if 
	End if 
End if 
$path:=HTTP_Path
TRACE:C157
// ### bj ### 20210129_0119
//pass this incomplete
// unless noted, path must be fully formed
If (($path="build") | ($path=""))  // data or path is being passed in as parameter
	If (HTTP_URL="")
		$myOK:=-1
		vDataReceived:="HTTP_URL is empty."
		ConsoleMessage(vDataReceived)
	Else 
		If (HTTP_Path="")
			$path:="/"
		Else 
			$path:=HTTP_Path
			If ($path[[1]]#"/")
				voState.sendingPath:="Error: missing lead / "+$path
				$path:="/"+$path
			End if 
		End if 
		//$path:=HTTP_URL+$path
		$path:=HTTP_HOST+HTTP_Path
	End if 
Else 
	//$path:=HTTP_URL+$path
	$path:=HTTP_HOST+HTTP_Path
End if 
TRACE:C157
If ($myOK=1)
	
	// ### bj ### 20210129_0000
	// WC_SendHeaders standardize on this
	// Build the HTTP headers
	$crlf:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
	$headers:=""
	$headers:=$headers+$requestMethod+" "+$path+" HTTP/1.0"+$crlf
	$headers:=$headers+"User-Agent: WebClerk-CommerceExpert HTTP Client"+$crlf
	$headers:=$headers+"Host: "+HTTP_Host+$crlf
	If (eventID_Cookie#"")
		$headers:=$headers+"Cookie: "+eventID_Cookie+$crlf
	End if 
	$strLength:=String:C10(BLOB size:C605(HTTP_Data))
	//POST request requires a content-length header
	
	C_TEXT:C284($strLength)
	
	$headers:=""
	$headers:=$headers+$requestMethod+" "+$path+" HTTP/1.0"+$crlf
	$headers:=$headers+"Host: "+HTTP_Host+$crlf
	$headers:=$headers+"Port: "+String:C10(HTTP_Port)+$crlf
	$headers:=$headers+"Accept: image/gif, image/jpeg, image/pjpeg, text/plain, text/html, */*"+$crlf
	If (HTTP_ContentType="")
		$headers:=$headers+"Content-Type: text/xml"+$crlf  // used with FedEx
	Else 
		$headers:=$headers+"Content-Type: "+HTTP_ContentType+$crlf  //application/json
	End if 
	
	$headers:=$headers+"Access-Control-Allow-Credentials:true"+$crlf
	$headers:=$headers+"Connection:keep-alive"+$crlf
	
	If ($requestMethod="POST")
		If ($headerAdds#"")  // parameter $3
			ARRAY TEXT:C222($aAdders; 0)
			ARRAY TEXT:C222($aPairs; 0)
			TextToArray($headerAdds; ->$aAdders; ";")
			$cntAdders:=Size of array:C274($aAdders)
			For ($incAdders; 1; $cntAdders)
				TextToArray($aAdders{$incAdders}; ->$aPairs; ",")
				If (Size of array:C274($aPairs)=2)
					$headers:=$headers+$aPairs{1}+": "+$aPairs{2}+$crlf
				End if 
			End for 
		End if 
		
		$headers:=$headers+"Content-Length: "+$strLength+$crlf
	End if 
	
	// $headers:=$headers+"Expires: 0"+$crlf
	// $headers:=$headers+"Content-Language: en"+$crlf
	
	// Important: the headers must end with a blank line
	$headers:=$headers+$crlf
	// Convert the headers to a blob
	TEXT TO BLOB:C554($headers; HTTP_SendingBlob; Mac text without length:K22:10)
	
	// POST appends the data to the headers
	If ($requestMethod="POST")
		COPY BLOB:C558(HTTP_Data; HTTP_SendingBlob; 0; BLOB size:C605(HTTP_SendingBlob); BLOB size:C605(HTTP_Data))
		// else the message is in the HTTP_Path
	Else 
		
	End if 
	
	If (<>viDebugMode>410)
		
		ConsoleMessage("requestMethod: "+$requestMethod)
		ConsoleMessage("headers: "+"\r"+$headers)
		C_TEXT:C284($vtOutgoingSent)
		$vtOutgoingSent:=BLOB to text:C555(HTTP_SendingBlob; Mac text without length:K22:10)
		If (Length:C16($vtOutgoingSent)>8000)
			$vtOutgoingSent:="Clipped to 8000: "+Substring:C12($vtOutgoingSent; 1; 8000)
		End if 
		ConsoleMessage("sent: "+"\r"+$vtOutgoingSent)
		[SyncRecord:109]packingNotes:14:=$vtOutgoingSent
	End if 
	
	$options:="connect-timeout="+String:C10(HTTP_TimeOut)
	
	If (HTTP_Protocol="https")
		// $options:=$options+" ssl=true"
		$options:=$options+" ssl=true ssl-method=TLSv1_2"
	End if 
	vWCPayload:=""
	
	// Set the timeout and open a connection
	voState.socket:=TCP Open(HTTP_Host; HTTP_Port; $options)
	$responseSize:=-1
	If (voState.socket=0)
		vResponse:="Failed socket: WebService Request, host: "+HTTP_Host+", Port: "+String:C10(HTTP_Port)+", options: "+$options
		ConsoleMessage(vResponse)
	Else 
		C_BLOB:C604($signalBlob)
		SET BLOB SIZE:C606($signalBlob; 0)
		$bytesSend:=TCP Send Blob(voState.socket; HTTP_SendingBlob)
		voState.socket:=String:C10(voState.socket)+": path: "+$path
		$timeoutAt:=Milliseconds:C459+(HTTP_TimeOut*1000)
		$start:=Milliseconds:C459
		
		
		If (False:C215)
			C_BOOLEAN:C305($continue)
			C_LONGINT:C283($bytesTotal; $contentLength; $elapsed; $start; $counter)
			$continue:=True:C214
			While ((TCP Get State(voState.socket)#TCP Connection Closed) & ($continue))
				$bytesRead:=TCP Receive(voState.socket; $httpContent; $ContentLength)
				$bytesTotal:=$bytesTotal+$bytesRead
				vWCPayload:=vWCPayload+$httpContent
				If ($bytesTotal>=$contentLength)
					$continue:=False:C215
				End if 
				$elapsed:=Milliseconds:C459-$start
				If ($elapsed>30000)  // Timeout after 30 seconds
					$continue:=False:C215
				End if 
				$counter:=$counter+1  // read counter
			End while 
		End if 
		
		
		While ((TCP Get State(voState.socket)#TCP Connection Closed) & (Milliseconds:C459<$timeoutAt))
			
			If (TCP Receive Blob(voState.socket; $signalBlob)>0)
				COPY BLOB:C558($signalBlob; HTTP_IncomingBlob; 0; BLOB size:C605(HTTP_IncomingBlob); BLOB size:C605($signalBlob))
			Else 
				DELAY PROCESS:C323(Current process:C322; 30)
			End if 
		End while 
		
		
		// Close the connection on timeout or end of response message received, TCP Connection Closed
		TCP Close(voState.socket)
		$responseSize:=BLOB size:C605(HTTP_IncomingBlob)
		
		// HTTP_IncomingBlob
		// vWCPayload
		
		
		// ### bj ### 20181030_1643
		// assure the sending message is properly formated
		C_TEXT:C284($httpHeader)
		$httpHeader:=BLOB to text:C555(HTTP_IncomingBlob; UTF8 text without length:K22:17)
		
		
		
		
		voState.request:=WC_ParseHTTPHeaders($httpHeader; TCP Is Secure Connection(voState.socket))
		
		voState.request.parameters:=WC_ParseRequestParameter
		
		vWCPayload:=JSON Stringify:C1217(voState.request.parameters)
		
		
		If ($responseSize>0)
			If (<>viDebugMode>410)
				ConsoleMessage("Response, "+HTTPClient_URL+" returned HTTP_IncomingBlob size: "+String:C10($responseSize))
			End if 
		Else 
			ConsoleMessage("WebService Request, "+HTTPClient_URL+" returned no value or timed out.")
		End if 
		
	End if 
	$0:=$responseSize
	
	// manage HTTP_IncomingBlob  
End if 
If (vDataReceived="")
	vDataReceived:=vResponse
End if 