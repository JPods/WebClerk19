//%attributes = {}
// (PM) WC_SendHeaders
// Sends the HTTP headers
// $1 = Socket

C_LONGINT:C283($index; $bytesSend; $socket)
C_TEXT:C284($headers)

If (vbWCHeadersSent=False:C215)
	
	vbWCHeadersSent:=True:C214
	
	//Make sure HTTP status is set
	
	// Modified by: Bill James (2017-08-22T00:00:00)  Redirect to https
	// messey
	
	Case of 
		: (vWCStatus#"")
			// Already set
		: ((vtapiURLFragment#"") & (Position:C15("/"+vtapiURLFragment+"/"; voState.request.URL.pathNameTrimmed)>0))
			vWCStatus:="403"
		: ((vWCStatus="") & (BLOB size:C605(vblWCResponse)=0))
			vWCStatus:="404 Not Found"
		: ((vWCStatus="") & (BLOB size:C605(vblWCResponse)>0))
			vWCStatus:="200 OK"
	End case 
	// Build the string with the HTTP headers
	$headers:="HTTP/1.1 "+vWCStatus+Storage:C1525.char.crlf  //+"\r\n"
	
	// Make sure content-length is set
	$index:=Find in array:C230(aHeaderNameOut; "Content-Length")
	If ($index=-1)
		WC_SetHeaderOut("Content-Length"; String:C10(BLOB size:C605(vblWCResponse)))
	End if 
	
	For ($index; 1; Size of array:C274(aHeaderNameOut))
		$headers:=$headers+aHeaderNameOut{$index}+": "+aHeaderValueOut{$index}+Storage:C1525.char.crlf
	End for 
	
	
	
	$headers:=$headers+Storage:C1525.char.crlf
	
	If (Count parameters:C259>0)
		C_LONGINT:C283($1)
		$socket:=voState.socket
	Else 
		$socket:=voState.socket
	End if 
	
	$bytesSend:=TCP Send($socket; $headers)  // AZM 20180413 - USE PROCESS SOCKET
	
	vWCStatus:=""
	
End if 
