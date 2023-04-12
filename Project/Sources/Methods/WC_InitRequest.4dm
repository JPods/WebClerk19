//%attributes = {}
// (PM) HTTPD__InitRequest
// Initializes all variables for a HTTP request to their default values

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 07/18/16, 09:51:22
// ----------------------------------------------------
// Method: WC_InitRequest
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284(vWCLocalAddress; vWCRemoteAddress; vWCStatus; vWCRequestMethod; vWCRequestURI; vWCDocumentURI; vWCPayload)
C_LONGINT:C283(vlWCLocalPort)
C_BOOLEAN:C305(vbWCHeadersSent)
C_BLOB:C604(vblWCResponse)  // get rid of this, replace with voState

vWCLocalAddress:=""
vlWCLocalPort:=0
vWCRemoteAddress:=""
vWCStatus:=""
vWCRequestMethod:=""
vWCRequestURI:=""
vWCDocumentURI:=""
vWCPayload:=""
vbWCHeadersSent:=False:C215
vWCStatus:="200 OK"  // ###  AZM ### 20180918 REVERTED. DEFAULT NEEDS TO BE 200 OK WIL BE REPLACED IF THERE IS AN ERROR LATER
vData:=""
jitPageFromScript:=""  // page override can be set by scripts
jsonPage:=""

// ### bj ### 20200314_0029
C_TEXT:C284(vtLocked; vtLockedColor)
vtLocked:=""
vtLockedColor:=""

C_TEXT:C284(vtapiURLFragment)
vtapiURLFragment:=Storage:C1525.wc.apiURLFragment

SET BLOB SIZE:C606(vblWCResponse; 0)

ARRAY TEXT:C222(aHeaderNameIn; 0)
ARRAY TEXT:C222(aHeaderValueIn; 0)

ARRAY TEXT:C222(aHeaderNameOut; 0)
ARRAY TEXT:C222(aHeaderValueOut; 0)

ARRAY TEXT:C222(aParameterName; 0)
ARRAY TEXT:C222(aParameterValue; 0)

//Content-Type: text/html; charset=utf-8

// Set some default values for the outgoing HTTP headers
//WC_SetHeaderOut ("Server";"WebClerk/CommerceExpert/NTK Plugin/4D")
// ### jwm ### 20160718_1133 consolidated headers to this procewdure except HTTP/1.1 200 OK
WC_SetHeaderOut("MIME-Version"; "1.0")
WC_SetHeaderOut("Server"; "WebClerk")
WC_SetHeaderOut("Content-Type"; "text/html; charset=utf-8")  // ### jwm ### 20160718_1427 4D now uses Unicode UTF8 ***test this***
WC_SetHeaderOut("Date"; DateTime_RFCString(Current date:C33; Current time:C178))
WC_SetHeaderOut("Access-Control-Allow-Origin"; "*")  // ### jwm ### 20160516_1620 
WC_SetHeaderOut("Access-Control-Allow-Methods"; "POST, GET")  // ### jwm ### 20160516_1708



