//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/28/21, 23:47:28
// ----------------------------------------------------
// Method: WC_OneReceive
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($bytesRead; $position; $contentLength; $timeoutAt; $port; $timeoutHit; <>vHitTimeOut; $err)
C_BOOLEAN:C305($continue)
C_TEXT:C284($buffer; $httpHeader)
C_BLOB:C604($blobReadIn)
C_LONGINT:C283($theDelay)
//  voState.socket:=$1
// variable already is set
WCapi_voStateSetup

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

While (($continue) & ($timeoutHit>Milliseconds:C459) & (<>vbWCstop=False:C215))  //
	$theDelay:=Tickcount:C458
	WC_InitRequest  //ntk
	WC_ServerInit
	
	// Get the local and remote address
	// move the creating the EventLog
	TCP Get Local Address(voState.socket; vWCLocalAddress; vlWCLocalPort)
	TCP Get Remote Address(voState.socket; vWCRemoteAddress; $port)
	
	$bytesRead:=-1
	$position:=0
	$timeoutAt:=Milliseconds:C459+2000
	While ((TCP Get State(voState.socket)=TCP Connection Established) & ($position=0) & ($timeoutAt>Milliseconds:C459))
		$bytesRead:=TCP Lookahead(voState.socket; $buffer)
		$position:=Position:C15("\r\n\r\n"; $buffer)
	End while 
	
	If ($bytesRead>0)
		// Read the HTTP header
		$bytesRead:=TCP Receive(voState.socket; $httpHeader; $position+3)  // we have read to the data break
		voState.request:=WC_ParseHTTPHeaders($httpHeader; TCP Is Secure Connection(voState.socket))
		voState.request.bytes:=$bytesRead
		
		// Check if we have content for the request (in case it is a POST or PUT request)
		$contentLength:=Num:C11(PageGetHeader("Content-Length@"))
		If ($contentLength>0)  // if there is no content close the socket
			$bytesRead:=TCP Receive(voState.socket; $httpContent; $ContentLength)
			vWCPayload:=$httpContent
		End if 
		
		C_LONGINT:C283($viIsSocketSecure)
		
		$viIsSocketSecure:=TCP Is Secure Connection(voState.socket)
		
		
		// #### AZM #### 20180716 // SET A VARIABLE TO HOLD THE ENTIRE REQUESTED URL
		
		If (Caps lock down:C547)
			ConsoleLog(voState.request.headers.Referer)
		End if 
		// ### bj ### 20190124_1918
		
		voState.request.parameters:=WC_ParseRequestParameter
	End if 
End while 