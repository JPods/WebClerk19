//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/15/17, 10:53:45
// ----------------------------------------------------
// Method: WC_ParseHTTPHeaders
// Description
// 
//
// Parameters
// ----------------------------------------------------

// (PM) HTTPD__ParseHTTPHeaders
// Parse the incoming HTTP headers

C_OBJECT:C1216($0; $voRequest)
$voRequest:=New object:C1471
$voRequest.headers:=New object:C1471
$voRequest.URL:=New object:C1471

C_TEXT:C284($1; $httpHeader)
$httpHeader:=$1

C_LONGINT:C283($2; $viIsSocketSecure)
$viIsSocketSecure:=$2
$voRequest.isSocketSecure:=$viIsSocketSecure=1

C_LONGINT:C283($lineNr; $position)
C_TEXT:C284(eventID_Cookie)
C_LONGINT:C283($locName)
C_TEXT:C284($vtRequestProtocol)

ARRAY TEXT:C222(aHeaderNameIn; 0)
ARRAY TEXT:C222(aHeaderValueIn; 0)

ARRAY TEXT:C222(aCookies; 0)
ARRAY TEXT:C222(aCookieName; 0)
ARRAY TEXT:C222(aCookieValue; 0)

ARRAY TEXT:C222($lines; 0)
ARRAY TEXT:C222($tokens; 0)

// Split the http header into individual lines
String_Split($httpHeader; "\r\n"; ->$lines)

// Parse the first line, which is the request line
If (Size of array:C274($lines)>0)
	String_Split($lines{1}; " "; ->$tokens)
	
	If (Size of array:C274($tokens)>=1)
		vWCRequestMethod:=$tokens{1}
		APPEND TO ARRAY:C911(aHeaderNameIn; "__RequestMethod")
		APPEND TO ARRAY:C911(aHeaderValueIn; vWCRequestMethod)
		$voRequest.method:=vWCRequestMethod
	End if 
	If (Size of array:C274($tokens)>=2)
		//  $tokens{2}:=replace string($tokens{2};"//";"/")
		vWCRequestURI:=$tokens{2}
		APPEND TO ARRAY:C911(aHeaderNameIn; "__RequestURI")
		APPEND TO ARRAY:C911(aHeaderValueIn; vWCRequestURI)
		
		If (Shift down:C543)
			
		End if 
		
		
		
	End if 
	If (Size of array:C274($tokens)>=3)
		$vtRequestProtocol:=$tokens{3}
		APPEND TO ARRAY:C911(aHeaderNameIn; "__RequestProtocol")
		APPEND TO ARRAY:C911(aHeaderValueIn; $vtRequestProtocol)
	End if 
End if 

$voRequest.protocol:=$vtRequestProtocol

// Parse the subsequent lines, containg the HTTP headers
For ($lineNr; 2; Size of array:C274($lines))
	
	String_Split($lines{$lineNr}; ": "; ->$tokens)
	If (Size of array:C274($tokens)>=2)
		APPEND TO ARRAY:C911(aHeaderNameIn; $tokens{1})
		APPEND TO ARRAY:C911(aHeaderValueIn; $tokens{2})
		$voRequest.headers[$tokens{1}]:=$tokens{2}
	End if 
	
End for 


$w:=Find in array:C230(aHeaderNameIn; "@Cookie@")
If ($w>0)
	
	eventID_Cookie:=aHeaderValueIn{$w}  // contains all cookie name value pairs
	// Txt_2Array(vText;->aText1;",";True)
	
	TextToArray(aHeaderValueIn{$w}; ->aCookies; "; ")  // cookie delimiter = semicolon space
	For ($i; 1; Size of array:C274(aCookies))
		
		ARRAY TEXT:C222($aTemp; 0)  // clear array
		TextToArray(aCookies{$i}; ->$aTemp; "="; True:C214)  // split name value pairs
		// ### jwm ### 20160609_1004 check size of array
		If (Size of array:C274($aTemp)>=1)
			APPEND TO ARRAY:C911(aCookieName; $aTemp{1})  // assign name
		End if 
		If (Size of array:C274($aTemp)>=2)
			APPEND TO ARRAY:C911(aCookieValue; $aTemp{2})  // assign value
		Else 
			APPEND TO ARRAY:C911(aCookieValue; "")  // assign empty string
		End if 
		
	End for 
	
	// this could be used in other mthods or deleted
	// ### jwm ### 20160623_1324 changed Name everywhere from HTTP_Cookie to eventID_Cookie  
	$w:=Find in array:C230(aCookieName; "eventID")
	If ($w>0)
		eventID_Cookie:=aCookieValue{$w}
	Else 
		eventID_Cookie:=""
	End if 
	
	$voRequest.cookies:=New object:C1471
	For ($viCounter; 1; Size of array:C274(aCookieName))
		$voRequest.cookies[aCookieName{$viCounter}]:=aCookieValue{$viCounter}
	End for 
	
Else 
	// No cookies found
	vResponse:="Error: No Cookies found or Cookies disabled \r\r Please enable cookies and try again"
End if 

// ### bj ### 20190130_1654
// long standing mistake of calling everything after the ? the payload. It is in a GET but not a POST
// Parse the incoming request url into a document url and a query string
$vtGetPost:=PageGetHeader("__RequestMethod")

$position:=Position:C15("?"; vWCRequestURI)
If ($position>0)
	vWCDocumentURI:=URL_Decode(Substring:C12(vWCRequestURI; 1; $position-1))  //URL ahead of the '?' and pared QueryString
	
	vWCPayload:=Substring:C12(vWCRequestURI; $position+1)  //pairs of parameters and values sparated by &
Else 
	vWCDocumentURI:=URL_Decode(vWCRequestURI)
	vWCPayload:=""
End if 


APPEND TO ARRAY:C911(aHeaderNameIn; "__DocumentURI")
APPEND TO ARRAY:C911(aHeaderValueIn; vWCDocumentURI)
APPEND TO ARRAY:C911(aHeaderNameIn; "__QueryString")
APPEND TO ARRAY:C911(aHeaderValueIn; vWCPayload)  // Do not decode these, other wise we won't be able to parse them

// MAKE SURE THAT WE HAVE ENOUGH LINES TO AVOID ARRAY CHECK ERRORS

If (Size of array:C274($lines)>=2)
	
	// PARSE OUT URL PARTS
	
	C_COLLECTION:C1488($vcURLParts)
	
	// LINES{1} HAS THE PATHNAME AND MAYBE THE PARAMETERS, IF THERE ARE PARAMETERS
	
	$vcURLParts:=Split string:C1554($lines{1}; " ")
	$vcURLParts:=Split string:C1554($vcURLParts[1]; "?")
	
	// GET THE PATHNAME, AND A STORE A VERSION WITH TRAILING AND LEADING SLASHES TRIMMED
	
	If ($vcURLParts.length>0)
		$voRequest.URL.pathName:=$vcURLParts[0]
	Else 
		$voRequest.URL.pathName:=""
		ConsoleLog("Bad WC Request, No 'pathName': \""+$httpHeader+"\"")
	End if 
	$voRequest.URL.pathNameTrimmed:=String_TrimEnd($voRequest.URL.pathName; "/")
	If ($voRequest.URL.pathNameTrimmed="")
		$voRequest.URL.pathNameTrimmed:="/"
	End if 
	
	// BASED ON PATHNAME, CHECK IF IT IS AN API
	
	If ($voRequest.URL.pathName="@api-v@")
		$voRequest.isAPI:=True:C214
	Else 
		$voRequest.isAPI:=False:C215
	End if 
	
	// GET THE PARAMETERS STRING
	
	If ($vcURLParts.length>1)
		$voRequest.URL.parameters:=$vcURLParts[1]
	Else 
		$voRequest.URL.parameters:=""
	End if 
	
	// LINES{2} HAS THE HOSTNAME AND THE PORT, IF THERE IS A PORT 
	
	$vcURLParts:=Split string:C1554(Replace string:C233($lines{2}; "Host: "; ""); ":")
	
	// GET THE HOSTNAME
	
	If ($vcURLParts.length>0)
		$voRequest.URL.hostName:=$vcURLParts[0]
	Else 
		$voRequest.URL.hostName:=""
		ConsoleLog("Bad WC Request, No 'hostName': \""+$httpHeader+"\"")
	End if 
	
	// GET THE PORT
	
	If ($vcURLParts.length>1)
		$voRequest.URL.port:=$vcURLParts[1]
	Else 
		$voRequest.URL.port:=""
	End if 
	
	// WE HAVE TO RECREATE THE PROTOCOL PREFIX FROM KNOWING IF THE SOCKET IS SECURE, BECAUSE IT ISN'T SENT AS TEXT WITH THE REQUEST
	
	If ($viIsSocketSecure=1)
		$voRequest.URL.protocolPrefix:="https://"
	Else 
		$voRequest.URL.protocolPrefix:="http://"
	End if 
	
	// BUILD THE MERGED HREF (OR FULL URL)
	
	$voRequest.URL.href:=$voRequest.URL.protocolPrefix+$voRequest.URL.hostName+":"+$voRequest.URL.port+$voRequest.URL.pathName
	
	If ($voRequest.URL.parameters#"")
		$voRequest.URL.href:=$voRequest.URL.href+"?"+$voRequest.URL.parameters
	End if 
	
Else 
	
	ConsoleLog("Bad WC Request: \""+$httpHeader+"\"")
	
End if 

$0:=$voRequest
