//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/30/21, 23:03:08
// ----------------------------------------------------
// Method: WC_RequestReceive
// Description
// 
//
// Parameters
// ----------------------------------------------------


#DECLARE($requestMethod : Text; $path : Text; $headerAdds : Text; $dataToSend : Text)->$result : Integer
// If this is a GET the path with parameters must be complete
// If this is a Post, the dataToSend must be provided
// $datatosend must already be text from a stringified object

C_LONGINT:C283($bytesRead; $position; $contentLength; $timeoutAt; $port; $timeoutHit; <>vHitTimeOut; $err)
C_BOOLEAN:C305($continue)
C_TEXT:C284($buffer; $httpHeader; $headerAdds; $dataToSend)
C_BLOB:C604($signalBlob; $vIncomingBlob)
C_LONGINT:C283($theDelay; $viStartPayload)
C_OBJECT:C1216(voState)
SET BLOB SIZE:C606($vIncomingBlob; 0)
//  voState.socket:=$1
// variable already is set
WCapi_voStateSetup

voState.outbound:=New object:C1471
voState.outbound.method:=$requestMethod
voState.outbound.path:=$path
voState.outbound.headerAdds:=$headerAdds
voState.outbound.data:=$dataToSend
$continue:=True:C214
If (<>vHitTimeOut<4000)
	<>vHitTimeOut:=10000
End if 
// ### jwm ### 20171215_1100 initialize header and content
$httpHeader:=""
$httpContent:=""

//SET TEXT TO PASTEBOARD(vtext11)

// Modified by: William James (2014-01-10T00:00:00)
ON ERR CALL:C155("OEC_Web")  // try to turn off all alerts ???? look at creating a log of alerts

$timeoutHit:=Milliseconds:C459+<>vHitTimeOut

C_LONGINT:C283($responseSize; $timeoutAt; $bytesSend; $position; $cntAdders; $incAdders)
C_BLOB:C604($vBlobOutGoing; $vBlobPOSTData)
C_LONGINT:C283(HTTP_TestMode; $myOK)

TEXT TO BLOB:C554($dataToSend; $vBlobPOSTData; UTF8 text without length:K22:17)
C_LONGINT:C283($strLength)
$strLength:=BLOB size:C605($vBlobPOSTData)


$crlf:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)

//$headers:="https://"+HTTP_Host+$crlf
ARRAY TEXT:C222(aHeaderNameOut; 0)
ARRAY TEXT:C222(aHeaderValueOut; 0)
//WC_SetHeaderOut("$requestMethod"; "*")

$headers:=""
$headers:=$headers+$requestMethod+" "+$path+" HTTP/1.0"+$crlf

ConsoleLog("\r"+$path+"\r")

//$headers:=$headers+"Referrer: WebClerk."+$crlf
$headers:=$headers+"Host: "+HTTP_Host+$crlf
$headers:=$headers+"Port: "+String:C10(HTTP_Port)+$crlf
$headers:=$headers+"Accept: image/gif, image/jpeg, image/pjpeg, text/plain, text/html, */*"+$crlf
If (HTTP_ContentType="")
	$headers:=$headers+"Content-Type: text/xml"+$crlf  // used with FedEx
Else 
	$headers:=$headers+"Content-Type: "+HTTP_ContentType+$crlf  //application/json
End if 
If ($strLength>0)
	$headers:=$headers+"Content-Length: "+String:C10($strLength)+$crlf
End if 
$headers:=$headers+"Access-Control-Allow-Credentials:true"+$crlf
$headers:=$headers+"Connection:keep-alive"+$crlf
$headers:=$headers+$crlf



ConsoleLog("\r"+$headers)
// Convert the headers to a blob
TEXT TO BLOB:C554($headers; $vBlobOutGoing; Mac text without length:K22:10)

// POST appends the data to the headers
If ($requestMethod="POST")
	TRACE:C157
	COPY BLOB:C558($vBlobPOSTData; $vBlobOutGoing; 0; BLOB size:C605($vBlobOutGoing); BLOB size:C605($vBlobPOSTData))
End if 

$options:="connect-timeout="+String:C10(HTTP_TimeOut)

If (HTTP_Protocol="https")
	$options:=$options+" ssl=true ssl-method=TLSv1_2"
End if 

// send the message
// Set the timeout and open a connection
voState.socket:=TCP Open(HTTP_Host; HTTP_Port; $options)
$responseSize:=-1
If (voState.socket=0)
	vResponse:="Failed socket: WebService Request, host: "+HTTP_Host+", Port: "+String:C10(HTTP_Port)+", options: "+$options
	ConsoleLog(vResponse)
Else 
	
	$bytesSend:=TCP Send Blob(voState.socket; $vBlobOutGoing)
	vResponse:="Socket: "+String:C10(voState.socket)+": path: "+$path
	
	$timeoutAt:=Milliseconds:C459+(HTTP_TimeOut*1000)
End if 

$result:=voState.socket

While ((TCP Get State(voState.socket)#TCP Connection Closed) & (Milliseconds:C459<$timeoutAt))
	
	If (TCP Receive Blob(voState.socket; $signalBlob)>0)
		COPY BLOB:C558($signalBlob; $vIncomingBlob; 0; BLOB size:C605($vIncomingBlob); BLOB size:C605($signalBlob))
	Else 
		DELAY PROCESS:C323(Current process:C322; 30)
	End if 
End while 

TCP Close(voState.socket)
$responseSize:=BLOB size:C605($vIncomingBlob)
C_TEXT:C284($httpContent)
$httpContent:=BLOB to text:C555($vIncomingBlob; UTF8 text without length:K22:17)

// not needed 
voState.request:=WC_ParseHTTPHeaders($httpContent; 0)  //.
$viStartPayload:=Position:C15("\r\n\r\n{"; $httpContent)
If ($viStartPayload>0)
	vWCPayload:=Substring:C12($httpContent; $viStartPayload+4)
Else 
	vWCPayload:=""
End if 
voState.request.parameters:=WC_ParseRequestParameter
If (vWCPayload#"")
	vWCPayload:=JSON Stringify:C1217(voState.request.parameters)
End if 
ConsoleLog(vWCPayload)


