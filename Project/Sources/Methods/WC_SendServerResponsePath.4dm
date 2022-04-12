//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 09/12/21, 16:02:31
// ----------------------------------------------------
// Method: WC_SendServerResponsePath
// Description
// 
// Parameters
// ----------------------------------------------------
ON ERR CALL:C155("OEC_Web")  // try to turn off all alerts ???? look at creating a log of alerts


//*************************************************************************************//
//** TYPE AND INITIALIZE VARIABLES ****************************************************//
//*************************************************************************************//

// RETURN VARIABLE
C_LONGINT:C283($0; $viBytesSent)
$viBytesSent:=0

// PARAMETER 1 IS THE NAME OF THE PROCESS VARIABLE
// THAT WE WANT TO RETURN THE VALUE OF.
C_TEXT:C284($1)
//C_VARIANT($var)
C_BLOB:C604($vblBody)
SET BLOB SIZE:C606($vblBody; 0)

$pathToDoc:=$1

If ($pathToDoc="")
	ConsoleMessage("WC_SendServerResponsePath: path is empty, replace with voState.url in TM WebCommandOverRide, emptyPath")
	viEndUserSecurityLevel:=1
	Execute_TallyMaster("WebCommandOverRide"; "emptyPath"; 1)
	
Else 
	
	If ($pathToDoc[[1]]="/")
		$pathToDoc:=Substring:C12($pathToDoc; 2)
	End if 
	//$pathToDoc:=Replace string($pathToDoc; "/"; Folder separator)
	//$pathToDoc:=Replace string($pathToDoc; "%20"; Storage.char.space)
	
	$pathToDoc:=URL_Decode($pathToDoc)
	
	// MustFixQQQZZZ: Bill James (2021-12-02T06:00:00Z) remove all unix escapes
	
End if 
$pathToServe:=""
var $w_i : Integer
$w_i:=Position:C15("jitWeb"; $pathToDoc)
If ($w_i>0)
	$pathToServe:=Storage:C1525.paths.localComEx+Substring:C12($pathToDoc; $w_i)
Else 
	$w_i:=Position:C15("CommerceExpert"; $pathToDoc)
	Case of 
		: ($w_i<1)  // 15)// the 
			$pathToServe:=Storage:C1525.paths.jitWeb+$pathToDoc
		: ($w_i=1)
			$pathToDoc:=$pathToDoc
		: ($w_i>1)
			$pathToDoc:=Substring:C12($pathToDoc; $w_i)  // redirect end path
		Else 
			$pathToServe:=Storage:C1525.paths.localComEx+"images/pathInvalid.jpg"
			ConsoleMessage("path in WC_SendServerResponsePath: "+$pathToServe)
	End case 
End if 
// alert(Storage.paths.serverDocuments)

If (($pathToServe="") & ($pathToDoc#""))
	If (Test path name:C476(Storage:C1525.paths.serverDocuments+$pathToDoc)=1)
		$pathToServe:=Storage:C1525.paths.serverDocuments+$pathToDoc
	Else 
		$pathToServe:=Storage:C1525.paths.documents+$pathToDoc
	End if 
	
End if 

$vtContentType:="application/json"  // unless over ridden by line 44

If (Test path name:C476($pathToServe)#1)
	ConsoleMessage("Error: ErrorDocument 404 Path invalid WC_SendServerResponsePath "+voState.url)
	vResponse:="Error: ErrorDocument 404: "+voState.url
	WC_voStateError("Error: ErrorDocument 404: "+$pathToServe)
	WC_SendServerResponse(vResponse)
Else 
	DOCUMENT TO BLOB:C525($pathToServe; $vblBody)
	$vtContentType:=WC_GetContentTypeFor($pathToServe)
	// PARAMETER 2 IS THE TYPE OF CONTENT THAT IS BEING
	// RETURNED BY THE SERVER
	//C_TEXT($2; $vtContentType)
	//  $vtContentType:=$2
	
	
	If (<>viDebugMode>410)
		ConsoleMessage("pathHappy: "+$pathToServe)
	End if 
	
	
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
	//WC_SetHeaderOut("Set-Cookie"; "eventID="+voState.eventLog.id+"; expires="+$vtDateExpires+"; path=/")
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