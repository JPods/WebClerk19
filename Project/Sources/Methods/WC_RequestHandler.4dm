//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/07/08, 08:45:25
// ----------------------------------------------------
// Method: Method: WC_RequestHandler

// Method: WC_RequestHandler
// Handles incoming client requests
// $1 = Socket
// ----------------------------------------------------

C_LONGINT:C283($1; $bytesRead; $position; $contentLength; $timeoutAt; $port; $timeoutHit; <>vHitTimeOut; $err)

C_BOOLEAN:C305($continue)
C_TEXT:C284($buffer; $httpHeader)
C_BLOB:C604($blobReadIn)
C_LONGINT:C283($theDelay)
WCapi_voStateSetup
voState.socket:=$1
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
			If (True:C214)  // needed to load larger images
				C_BOOLEAN:C305($continue)
				C_LONGINT:C283($bytesTotal; $elapsed; $start; $counter)
				$continue:=True:C214
				$bytesTotal:=0
				$counter:=0
				$start:=Milliseconds:C459
				$elapsed:=Milliseconds:C459-$start  // initialized milliseconds elapsed
				While ((TCP Get State(voState.socket)#TCP Connection Closed) & ($continue))
					$bytesRead:=TCP Receive(voState.socket; $httpContent; $ContentLength)
					$bytesTotal:=$bytesTotal+$bytesRead
					vWCPayload:=vWCPayload+$httpContent
					If ($bytesTotal>=$contentLength)
						$continue:=False:C215
					End if 
					$elapsed:=Milliseconds:C459-$start
					If ($elapsed>60000)  // Timeout after 60 seconds
						$continue:=False:C215
					End if 
					$counter:=$counter+1  // read counter
				End while 
			Else 
				$bytesRead:=TCP Receive(voState.socket; $httpContent; $ContentLength)
				vWCPayload:=$httpContent
			End if 
		End if 
		
		// Storage.wc.enableSSL; 
		C_LONGINT:C283($viIsSocketSecure)
		
		$viIsSocketSecure:=TCP Is Secure Connection(voState.socket)
		
		
		
		// WC_GetDefaultParameters  // ### azm ### 20171016_1113 - Created so that typical values like ReturnTable are available before alias scripts are run.
		
		//  WC_VariablesRead  // ### azm ### 20171016_1113 - Created so that typical values like ReturnTable are available before alias scripts are run. @ToDo: Combine with WC_GetDefaultParameters and remove redundency
		C_BLOB:C604($vblBody)
		Case of 
			: (voState.request.method="OPTIONS")
				$currentProcessNum:=Find in array:C230(<>ThreadPool_ThreadID; Current process:C322)
				<>ThreadPool_jitURL{$currentProcessNum}:="OPTIONS"
				WC_SendOptionResponse
				
			: ((voState.request.isSocketSecure=False:C215) & (<>voWebServerPrefs.forceSSL))
				<>ThreadPool_jitURL{$currentProcessNum}:="SSL redirect"
				WC_SendOptionResponse
				$vblBody:=HTTP_Redirect(voState.request.URL.pathName)  // AZM 20180413 USE GENERIC HTTP_Redirect
				WC_SendServerResponse("<a href=\""+vText+"\">"+vText+"</a>"; "text/html; charset=utf-8")  // AZM 20190516 I just removed sending of HTTP response from HTTP_Redirect, so it needs to be here.
				WC_SendResponse(voState.response; $vblBody)
				WC_ProfilingTimeStamp("Sending response")
			Else 
				
				voState.request.parameters:=WC_ParseRequestParameter
				If (voState.request.parameters.idUser=Null:C1517)  // assure that this is never null
					voState.request.parameters.idUser:=""
				End if 
				
				If (voState.request.URL.pathNameTrimmed="/")
					voState.request.URL.pathNameTrimmed:="/index.html"
				End if 
				voState.url:=voState.request.URL.pathNameTrimmed
				voState.urlOriginal:=voState.url
				// changed  voState.url as needed but keep voState.urlOriginal as submitted
				
				If ((Macintosh command down:C546) & (Macintosh option down:C545))
					TRACE:C157
				End if 
				
				C_LONGINT:C283(<>letMeIn_i)  // remove this after TESTONLY
				vResponse:=""
				If (voState.url="@QA@")
					var $id : Text
					$id:="DF221D6FCE5D9E468A1F04F1972CF308"
					If (voState.request.parameters.idUser="")
						voState.request.parameters.idUser:="DF221D6FCE5D9E468A1F04F1972CF308"
					End if 
				End if 
				
				WC_EventByID
				
				
				$currentProcessNum:=Find in array:C230(<>ThreadPool_ThreadID; Current process:C322)
				<>ThreadPool_jitURL{$currentProcessNum}:=voState.request.URL.pathName
				Case of 
					: (vResponse="AlreadySent")
					: (vResponse="Err@")
						WC_SendServerResponse(vResponse; "application/json")
						//WCapi_SendFromServer
					Else 
						WC_Core(voState.socket)
				End case 
				
				If (<>vLookaHead)
					// For HTTP 1.1 we have to check for another request coming in
					If ((Num:C11(voState.request.protocol)>1) & ($continue))
						$continue:=(TCP Lookahead(voState.socket; $buffer; 1)>0)
					Else 
						$continue:=False:C215
					End if 
				Else 
					$continue:=False:C215
				End if 
		End case 
	End if 
End while 
C_LONGINT:C283($viDelayMilli)
$viDelayMilli:=Milliseconds:C459-voState.debugging.requestStartTime
If ((<>viDebugMode>=410) | ($viDelayMilli><>vlHangMilli))
	ConsoleLog("voState")
	ConsoleLog(JSON Stringify:C1217(voState))
	
	If (<>viDebugMode>=510)
		C_OBJECT:C1216($voTallyResults)
		$voTallyResults:=ds:C1482.TallyResult.new()
		
		$voTallyResults.name:=voState.urlOriginal
		$voTallyResults.purpose:="voState"
		
		$voTallyResults.obGeneral:=Init_obGeneral
		$voTallyResults.itemNum:=voState.request.method
		$voTallyResults.profile1:=voState.request.URL.href
		$voTallyResults.profile2:=voState.request.URL.pathNameTrimmed
		$voTallyResults.longint1:=$viDelayMilli
		
		$voTallyResults.textBlk1:=vResponse
		$voTallyResults.dtReport:=DateTime_DTTo
		$voTallyResults.dateCreated:=Current date:C33
		$voTallyResults.save()
	End if 
End if 

TCP Close(voState.socket)
vResponse:=""
voState:=New object:C1471

ON ERR CALL:C155("")