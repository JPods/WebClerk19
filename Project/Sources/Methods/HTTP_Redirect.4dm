//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 04/13/18, 11:40:47
// ----------------------------------------------------
// Method: HTTP_Redirect
// Description
// 
//
// Parameters
// ----------------------------------------------------

// ********************************************************************** //
// ** TYPE AND INITIALIZE VARIABLES ************************************* //
// ********************************************************************** //

C_BLOB:C604($0; $vblBody)

// PARAMETER 1 IS THE LOCATION THAT THE USER IS BEING 
// REDIRECTED TO
C_TEXT:C284($1; $vtLocation)
$vtLocation:=$1

// PARAMETER 2 IS THE HTTP RESPONSE CODE. THIS PARAMETER 
// IS OPTIONAL, AND WILL BE SET TO 301 BY DEFAULT
C_TEXT:C284($vtCode)
$vtCode:="301 Moved Permanently"
If (Count parameters:C259>1)
	C_TEXT:C284($2)
	$vtCode:=$2
End if 

// ********************************************************************** //
// ** CONVERT RELATIVE LOCATIONS TO ABSOLUTE **************************** //
// ********************************************************************** //

Case of 
		
	: (Substring:C12($vtLocation; 0; 4)="http")  // LINK IS ABSOLUTE
		
		$vtLocation:=$vtLocation
		
	: (Substring:C12($vtLocation; 0; 1)="/")  // LINK IS RELATIVE STARTING AT TOP
		
		$vtLocation:=voState.request.URL.protocolPrefix+voState.request.URL.hostName+":"+voState.request.URL.port+$vtLocation
		
	Else   // LINK IS RELATIVE STARTING FROM CURRENT LOCATION
		
		$vtLocation:=voState.request.URL.href+$vtLocation
		
End case 

// ********************************************************************** //
// ** FORCE HTTPS IF NEEDED ********************************************* //
// ********************************************************************** //

If ((<>voWebServerPrefs.forceSSL) & (Substring:C12($vtLocation; 0; 5)#"https"))
	$vtLocation:=Replace string:C233($vtLocation; "http"; "https")
	$vtLocation:=Replace string:C233($vtLocation; ":"+String:C10(<>voWebServerPrefs.portNum); ":"+String:C10(<>voWebServerPrefs.portNumSSL))
End if 

$vblBody:=String_ToBlob("<a href=\""+$vtLocation+"\">"+$vtLocation+"</a>")
vWCStatus:=$vtCode  // @todo .. remove this

WC_SetHeaderOut("Location"; $vtLocation)
WC_SetHeaderOut("Connection"; "close")  // #### AZM #### 20180716 // Close the connection, per HTTP spec.
WC_SetHeaderOut("Content-Type"; "text/html; charset=utf-8")
WC_SetHeaderOut("Content-length"; String:C10(BLOB size:C605($vblBody)))

voState.response.HTTPStatus:=$vtCode



// ******************************************************************************************** //
// ** RETURN THE VALUE ************************************************************************ //
// ******************************************************************************************** //

$0:=$vblBody