//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/05/09, 05:56:48
// ----------------------------------------------------
// Method: NTK_SetURL
// Sets the URL for a HTTP request
// $1 = URL

C_TEXT:C284($1)



// Modified by: williamjames (121101) fix so if no protocal is defined, one is added

HTTP_URL:=$1
If ((HTTP_URL#"http://@") & (HTTP_URL#"https://@"))
	HTTP_URL:="http://"+HTTP_URL
End if 

// Extract the protocol and port to use
Case of 
	: (HTTP_URL="http://@")
		HTTP_Protocol:="http"
		HTTP_Port:=80
	: (HTTP_URL="https://@")
		HTTP_Protocol:="https"
		HTTP_Port:=443
End case 

// Extract the domain name and path to the resource
HTTP_Host:=Txt_FindInBetween(HTTP_URL; "://"; "/")
If (HTTP_Host="")
	HTTP_Host:=Txt_FindInBetween(HTTP_URL; "://")
End if 
HTTP_Path:=Txt_FindInBetween(HTTP_URL; HTTP_Host)

If (Position:C15(":"; HTTP_Host)>0)
	HTTP_Port:=Num:C11(Txt_FindInBetween(HTTP_Host; ":"; ""))
	HTTP_Host:=Txt_FindInBetween(HTTP_Host; ""; ":")
End if 
