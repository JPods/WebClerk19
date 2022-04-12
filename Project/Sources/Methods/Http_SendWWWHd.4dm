//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/24/09, 15:08:27
// ----------------------------------------------------
// Method: Http_SendWWWHd
// Description
// 
//
// Parameters
// ----------------------------------------------------

//Procedure: Http_SendWWWHd($1;"text/html"; pt to file - opt)
C_LONGINT:C283($1; $err; $cntParameters; $socket)
C_TEXT:C284($2; $contentType)  //Content-type
C_LONGINT:C283($3; $contentLength; $liveDays; $liveHours; $4)  //the file
C_TEXT:C284($header)

$liveDays:=0
$liveHours:=8
$contentLength:=0
$contentType:="text/html"
$cntParameters:=Count parameters:C259

$socket:=voState.socket
// Build headers  // ### jwm ### 20160517_0931

// Modified by: Bill James (2017-09-05T00:00:00)
// NTKHTTPD__InitRequest  // ### jwm ### 20160718_0951 set default headers

// append additional headers to arrays
// ### jwm ### 20160719_1705 disabled Cache-Control caused issues with Javascript
//WC_SetHeaderOut ("Cache-Control";"no-cache, no-store, must-revalidate")
If (vbWCHeadersSent=False:C215)
	vbWCHeadersSent:=True:C214
	
	
	If ($cntParameters>1)
		//$header:=$header+"Content-type: "+$2+Storage.char.crlf
		WC_SetHeaderOut("Content-Type"; $2)
		If ($cntParameters>2)
			WC_SetHeaderOut("Content-length"; String:C10($3))
			//$header:=$header+"Content-length: "+String($3)+Storage.char.crlf
			If ($cntParameters>3)
				If ($4>0)  // ### jwm ### 20160718_1522 we are not currently passing a fourth parameter (not used below)
					$liveDays:=$4
				End if 
			End if 
		End if 
	End if 
	
	// start the HTTP header
	$header:=""
	$header:=$header+"HTTP/1.1 200 OK"+Storage:C1525.char.crlf
	
	//$header:=$header+"MIME-Version: 1.0"+Storage.char.crlf
	//$header:=$header+"Server: webClerk (by James Integrated Technologies:  http://www.jitcorp.com/)/NTK"+Storage.char.crlf
	// $header:=$header+"Access-Control-Allow-Origin: *"+Storage.char.crlf
	
	// ### jwm ### 20160718_1136
	// Build headers from arrays (see NTKHTTPD__InitRequest) 
	C_LONGINT:C283($incHeader; $cntHeader)
	$cntHeader:=Size of array:C274(aHeaderNameOut)
	If ($cntHeader>0)
		For ($incHeader; 1; $cntHeader)
			$header:=$header+aHeaderNameOut{$incHeader}+": "+aHeaderValueOut{$incHeader}+Storage:C1525.char.crlf
		End for 
		ARRAY TEXT:C222(HTTPD_OutHeaderName; 0)
		ARRAY TEXT:C222(HTTPD_OutHeaderValue; 0)
	End if 
	
	//
	$hourAfterGMT:=6
	$dtLong:=DateTime_Enter(Current date:C33; Current time:C178)
	$dtLong:=$dtLong+(60*60*$liveHours)
	$date:=jDateTimeRDate($dtLong)
	$time:=jDateTimeRTime($dtLong)
	
	C_TEXT:C284($dateString; $dateExpires; $dateString2; $dateExpires2)
	$dateExpires:="expires="+DateTime_RFCString($date; $time)  //?1999;34?(Current date+$liveDays;Current time;$gmtd;$gmtt)?//+Storage.char.crlf
	
	//SMTP_Date (smtp_ID; msgDate; msgTime; timeZone; offset{; deleteOption})  Integer
	//
	//If (vleventID="")
	//vleventID:=String(DateTime_Enter )
	//End if 
	
	
	
	$header:=$header+"Set-Cookie: eventID="+voState.eventLog.id+"; "+$dateExpires+"; path=/"+Storage:C1525.char.crlf
	// ### jwm ### 20160315_1131
	// SetCookie array filled by method Set_Cookie
	For ($i; 1; Size of array:C274(aSetCookie))
		$header:=$header+aSetCookie{$i}
	End for 
	ARRAY TEXT:C222(aSetCookie; 0)  // clear array
	
	// ### jwm ### 20160718_1518 set above
	//$header:=$header+"Cache Control:  no-cache"+Storage.char.crlf
	
	$header:=$header+Storage:C1525.char.crlf
	$bytesSend:=TCP Send($socket; $header)
	//WC_SendHeaders ($1)
	
	
	If (<>viDebugMode>910)
		ConsoleMessage($header)
	End if 
End if 