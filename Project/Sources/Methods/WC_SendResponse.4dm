//%attributes = {}

// ----------------------------------------------------
// User name (OS): AndyMercer
// Date and time: 05/22/20, 10:23:54
// ----------------------------------------------------
// Method: WC_SendResponse
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ******************************************************************************************** //
// ** TYPE AND INITIALIZE PARAMETERS ********************************************************** //
// ******************************************************************************************** //

C_LONGINT:C283($0; $viBytesSent)
$viBytesSent:=0

C_OBJECT:C1216($1; $voResponse)
$voResponse:=$1

C_BLOB:C604($2; $vblBody)
$vblBody:=$2



// ******************************************************************************************** //
// ** TYPE AND INITIALIZE LOCAL VARIABLES ***************************************************** //
// ******************************************************************************************** //

C_LONGINT:C283($viCounter)
C_TEXT:C284($vtHeadersString)



// ******************************************************************************************** //
// ** SEND THE HEADERS ************************************************************************ //
// ******************************************************************************************** //

// COMBINE HEADERS INTO STRING

$viCounter:=0

$vtHeadersString:="HTTP/1.1 "+$voResponse.HTTPStatus+Storage:C1525.char.crlf

For ($viCounter; 0; $voResponse.headers.names.length-1)
	
	$vtHeadersString:=$vtHeadersString+$voResponse.headers.names[$viCounter]+": "+$voResponse.headers.values[$viCounter]+Storage:C1525.char.crlf
	
End for 

$vtHeadersString:=$vtHeadersString+Storage:C1525.char.crlf

// SEND STRING

$viBytesSent:=TCP Send(voState.socket; $vtHeadersString)



// ******************************************************************************************** //
// ** SEND RESPONSE BODY ********************************************************************** //
// ******************************************************************************************** //

// IF THE RESPONSE IS A CSV, WE WANT TO EXPLICITLY SAY THAT IT IS UTF8 BY PREPENDING A "Byte Order Mark" or "BOM".

If (voState.response.isCSV)
	$viBytesSent:=$viBytesSent+TCP Send Blob(voState.socket; <>vblUTF8BOM)
End if 
$viBytesSent:=$viBytesSent+TCP Send Blob(voState.socket; $vblBody)
DebugMessage("BytesSent: "+String:C10($viBytesSent))



// ******************************************************************************************** //
// ** RETURN THE TOTAL BYTES SENT ************************************************************* //
// ******************************************************************************************** //

$0:=$viBytesSent