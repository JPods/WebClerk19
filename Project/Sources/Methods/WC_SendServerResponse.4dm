//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 07/17/18, 10:00:08
// ----------------------------------------------------
// Method: WC_SendServerResponse
// Description
// 
//
// Parameters
// ----------------------------------------------------

//*************************************************************************************//
//** TYPE AND INITIALIZE VARIABLES ****************************************************//
//*************************************************************************************//
ON ERR CALL:C155("OEC_Web")

// RETURN VARIABLE
C_LONGINT:C283($0; $viBytesSent)
$viBytesSent:=0

// PARAMETER 1 IS THE NAME OF THE PROCESS VARIABLE
// THAT WE WANT TO RETURN THE VALUE OF.
C_TEXT:C284($1)
//C_VARIANT($var)
C_BLOB:C604($vblBody)
SET BLOB SIZE:C606($vblBody; 0)

// PARAMETER 2 IS THE TYPE OF CONTENT THAT IS BEING
// RETURNED BY THE SERVER
C_TEXT:C284($2; $vtContentType)

$vtBody:=$1

var $wStatus_i; $err_i : Integer
If ($vtBody="Error@")  // put into json earlierr if practical
	$wStatus_i:=Position:C15("status="; $vtBody)
	If ($wStatus_i>0)
		$err_i:=Num:C11(Substring:C12($vtBody; $wStatus_i+7; 3))
		$vtBody:=JSON Stringify:C1217(New object:C1471("Error"; Substring:C12($vtBody; 8); "status"; $err_i))
	Else 
		$vtBody:=JSON Stringify:C1217(New object:C1471("Error"; Substring:C12($vtBody; 8); "status"; 500))
	End if 
End if 


$vtContentType:="application/json"  // unless over ridden by line 44
If (Count parameters:C259>1)
	$vtContentType:=$2
End if 
If (<>viDebugMode>910)
	ConsoleMessage("body: "+"\r"+$vtBody)
End if 
If ($vtBody#"AlreadySent@")
	TEXT TO BLOB:C554($vtBody; $vblBody; UTF8 text without length:K22:17; *)
	
	C_TEXT:C284($vtHeaders)
	$vtHeaders:=""
	
	
	// $vtContentLength IS THE LENGTH OF THE BODY OF THE 
	// RESPONSE THAT IS BEING RETURNED BY THE SERVER
	C_TEXT:C284($vtContentLength)
	$vtContentLength:=String:C10(BLOB size:C605($vblBody))  // ### AZM ### 20180920 CALCULATE SIZE FROM BLOB, NOT FROM TEXT. THIS AVOIDS A BUG IN SIZE DUE TO UNICODE CHARACTERS
	
	C_LONGINT:C283($viIterator; $viCount)
	
	C_TEXT:C284($vtDateExpires)
	$vtDateExpires:=""
	
	C_LONGINT:C283($viDurationInHours)
	$viDurationInHours:=8
	
	
	
	//*************************************************************************************//
	//** BUILD RESPONSE HEADERS ***********************************************************//
	//*************************************************************************************//
	
	
	$viDurationInHours:=8
	$vtDateExpires:=String:C10(Current date:C33; Date RFC 1123:K1:11; Time:C179(Time string:C180(Current time:C178+(60*60*$viDurationInHours))))
	// ### bj ### 20211003_1101
	WC_SetHeaderOut("Set-Cookie"; "eventID="+voState.eventLog.id+"; SameSite=Lax; expires="+$vtDateExpires+"; path=/")
	// WC_SetHeaderOut("Set-Cookie"; "eventID="+voState.eventLog.id+"; expires="+$vtDateExpires+"; path=/")
	WC_SetHeaderOut("Content-Type"; $vtContentType)
	WC_SetHeaderOut("Content-length"; $vtContentLength)
	
	$vtHeaders:="HTTP/1.1 "+vWCStatus+Storage:C1525.char.crlf
	
	$viCount:=Size of array:C274(aHeaderNameOut)
	
	If ($viCount>0)
		
		For ($viIterator; 1; $viCount)
			
			$vtHeaders:=$vtHeaders+aHeaderNameOut{$viIterator}+": "+aHeaderValueOut{$viIterator}+Storage:C1525.char.crlf
			
		End for 
		
	End if 
	
	$vtHeaders:=$vtHeaders+Storage:C1525.char.crlf
	
	//*************************************************************************************//
	//** SEND RESPONSE HEADERS ************************************************************//
	//*************************************************************************************//
	
	If (vbWCHeadersSent=False:C215)
		
		vbWCHeadersSent:=True:C214
		
		$viBytesSent:=TCP Send(voState.socket; $vtHeaders)
		
	End if 
	
	
	//*************************************************************************************//
	//** SEND RESPONSE BODY ***************************************************************//
	//*************************************************************************************//
	
	$viBytesSent:=$viBytesSent+TCP Send Blob(voState.socket; $vblBody)
	
	$0:=$viBytesSent
	
	If (<>viDebugMode>410)
		ConsoleMessage("BytesSent: "+String:C10($0))
	End if 
	
	//*************************************************************************************//
	//** UPDATE LOGS **********************************************************************//
	//*************************************************************************************//
End if 