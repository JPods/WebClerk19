//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/06/21, 00:27:39
// ----------------------------------------------------
// Method: WC_SendOptionResponse
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($vtDateCurrent)
ARRAY TEXT:C222(aHeaderNameOut; 0)
ARRAY TEXT:C222(aHeaderValueOut; 0)

WC_SetHeaderOut("Access-Control-Allow-Origin"; "*")
WC_SetHeaderOut("Access-Control-Allow-Methods"; "GET,POST")
WC_SetHeaderOut("Vary"; "Access-Control-Request-Headers")
WC_SetHeaderOut("Access-Control-Allow-Headers"; "Content-Type, Accept")
WC_SetHeaderOut("Content-Length"; "0")
$vtDateCurrent:=String:C10(Current date:C33; Date RFC 1123:K1:11; Time:C179(Time string:C180(Current time:C178)))
WC_SetHeaderOut("Date"; $vtDateCurrent)
WC_SetHeaderOut("Connection"; "Keep-Alive")

$vtHeaders:="HTTP/1.1 204 No Content"+Storage:C1525.char.crlf

$viCount:=Size of array:C274(aHeaderNameOut)
If ($viCount>0)
	For ($viIterator; 1; $viCount)
		$vtHeaders:=$vtHeaders+aHeaderNameOut{$viIterator}+": "+aHeaderValueOut{$viIterator}+Storage:C1525.char.crlf
	End for 
End if 
$vtHeaders:=$vtHeaders+Storage:C1525.char.crlf
$viBytesSent:=TCP Send(voState.socket; $vtHeaders)

If (<>viDebugMode>=410)
	
End if 