//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/14/09, 23:22:56
// ----------------------------------------------------
// Method: NTKHTTPD_GetRequest
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ### bj ### 20181108_0813
// Replace with WC_Request

// (PM) HTTP_SendRequest
// Performs the actual HTTP request
// $1 = Request method (GET or POST)
// $2 = Pointer to blob with response
// $0 = Error code

C_TEXT:C284($1; $requestMethod; $headers; $path; $crlf; $options)
C_POINTER:C301($2; $response)
C_LONGINT:C283($0; $error; $socket; $timeoutAt; $bytesSend; $position)
C_BLOB:C604($data; HTTP_Data)

$requestMethod:=$1
$response:=$2
$error:=-1

// Clear the response blob
SET BLOB SIZE:C606($response->; 0)

$path:=HTTP_Path

// If we have a GET request append the data as request parameters
If (($requestMethod="GET") & (BLOB size:C605(HTTP_Data)>0))
	$path:=$path+"?"+BLOB to text:C555(HTTP_Data; UTF8 text without length:K22:17)
End if 

// Build the HTTP headers
$crlf:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
$headers:=$requestMethod+" "+$path+" HTTP/1.1"+$crlf
$headers:=$headers+"User-Agent: WebClerk"+$crlf
$headers:=$headers+"Host: "+HTTP_Host+$crlf
$headers:=$headers+"Accept: */*"+$crlf
$headers:=$headers+"Connection: close"+$crlf

// For a POST request we need to add a content-length header
If ($requestMethod="POST")
	$headers:=$headers+"Content-Length: "+String:C10(BLOB size:C605(HTTP_Data))+$crlf
	$headers:=$headers+"Content-Type: application/x-www-form-urlencoded"+$crlf
End if 

// Important: the headers must end with a blank line
$headers:=$headers+$crlf

// Convert the headers to a blob
TEXT TO BLOB:C554($headers; $data; UTF8 text without length:K22:17)

// For a POST request we append the data to the headers
If ($requestMethod="POST")
	COPY BLOB:C558(HTTP_Data; $data; 0; BLOB size:C605($data); BLOB size:C605(HTTP_Data))
End if 

$options:="connect-timeout="+String:C10(HTTP_TimeOut)

If (HTTP_Protocol="https")
	// $options:=$options+" ssl=true"  //  "ssl-method=TLSv1"
	
	$options:=$options+" ssl=true ssl-method=TLSv1"
	
End if 

// Set the timeout and open a connection
$socket:=TCP Open(HTTP_Host; HTTP_Port; $options)

// If we have a connection
If ($socket#0)
	
	// Send the request
	$bytesSend:=TCP Send Blob($socket; $data)
	$timeoutAt:=Milliseconds:C459+(HTTP_TimeOut*1000)
	
	// Get the response (wait until the connection is closed)
	While ((TCP Get State($socket)#TCP Connection Closed) & (Milliseconds:C459<$timeoutAt))
		If (TCP Receive Blob($socket; $data)>0)
			COPY BLOB:C558($data; $response->; 0; BLOB size:C605($response->); BLOB size:C605($data))
		Else 
			DELAY PROCESS:C323(Current process:C322; 1)
		End if 
	End while 
	
	// Close the connection
	TCP Close($socket)
	
	// Strip the HTTP headers from the response
	$headers:=BLOB to text:C555($response->; UTF8 text without length:K22:17)
	$position:=Position:C15($crlf+$crlf; $headers)
	If ($position>0)
		$error:=0
		$position:=$position+4
		DELETE FROM BLOB:C560($response->; 0; $position-1)
	End if 
	
End if 

$0:=$error
