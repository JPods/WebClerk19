//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/25/19, 22:36:46
// ----------------------------------------------------
// Method: WC_ajaxServer
// Description
// 
//
// Parameters
// ----------------------------------------------------CE5D9E468A1F04F1972CF308","id":"D203EF5894514BAD9D51894229FE82D8","answer":"901-Comments:","answerId":"9D117191F8AA8B4AB43D93AFFFD5D9D9","photo":"data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEASABIAAD/4TryRXhpZgAASUkqAAgAAAAKAA8BAgAGAAAAhgAAABABAgAcAAAAjAAAABoBBQABAAAAqAAAABsBBQABAAAAsAAAACgBAwABAAAAAgAAADEBAgAHAAAAuAAAADIBAgAUAAAAvwAAABMCAwABAAAAAgAAAGmHBAABAAAA1AAAACWIBAABAAAAZCMAABgkAABDYW5vbgBDYW5vbiBFT1MgRElHSVRBTCBSRUJFTCBYU2kASAAAAAEAAABIAAAAAQAAAFBpY2FzYQAyMDExOjExOjEwIDEyOjE1OjAzAAAgAJqCBQABAAAAWgIAAJ2CBQABAAAAYgIAACKIAwABAAAAAgAAACeIAwABAAAAyAAAAACQBwAEAAAAMDIyMQOQAgAUAAAAagIAAASQAgAUAAAAfgIAAAGRBwAEAAAAAQIDAAGSCgABAAAAkgIAAAKSBQABAAAAmgIAAASSCgABAAAAogIAAAeSAwABAAAAAwAAAAmSAwABAAAAEAAAAAqSBQABAAAAqgIAAHySBwB4HwAA7AMAAIaSBwAIAQAAsgIAAJCSAgADAAAAODQAAJGSAgADAAAAODQAAJKSAgADAAAAODQAAACgBwAEAAAAMDEwMAGgAwABAAAAAQAAAAKgBAABAAAAIAMAAAOgBAABAAAAFQIAAAWgBAABAAAA4iMAAA6iBQABAAAAugMAAA+iBQABAAAAwgMAABCiAwABAAAAAgAAAAGkAwABAAAAAAAAAAKkAwABAAAAAAAAAAOkAwABAAAAAAAAAAakAwABAAAAAAAAACCkAgAhAAAAygMAAAAAAAABAAAAyAAAAAsAAAABAAAAMjAxMToxMToxMCAxMjoxNTowMwAyMDExOjExOjEwIDEyOjE1OjAzAACgBwAAAAEAAAAHAAAAAQAAAAAAAQAAABYAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA


C_BOOLEAN:C305($vbSendConsole)
$vbSendConsole:=True:C214

C_LONGINT:C283($1; $socket)
$socket:=voState.socket
C_TEXT:C284(vMimeType; $vtMimeType)
vMimeType:="application/json"
$vtMimeType:=vMimeType
C_OBJECT:C1216($voPayload)
$voPayload:=New object:C1471
SET BLOB SIZE:C606(vblWCResponse; 0)


C_TEXT:C284($vtFieldList)
$vtfieldList:=""
TRACE:C157
Case of 
		
	: ((voState.url="/ajax/image@") | (voState.url="/ajax/document@"))
		WCapiTask_GetDocPath
	: (voState.url="/ajax/QAAddtoRecord")
		vResponse:=ajax_QAAddtoRecord
		
	Else 
		vResponse:="Error: No axaj handler: "+Substring:C12(voState.url; 1; 40)
		// leave a no default. Must specify ajax type in cases able
End case 
If (vResponse="Err@")
	$voTableData.error:=vResponse
	vResponse:=JSON Stringify:C1217($voTableData)
End if 

// ### bj ### 20200101_2020
// may need to expand the options and place the sending in each choice above  WC_MimeBuild
Case of 
	: (vMimeType="AlreadySent")
		// no more action required
	: (vMimeType="json/app")
		TEXT TO BLOB:C554(vResponse; vblWCResponse; UTF8 text without length:K22:17; *)
		Http_SendWWWHd($socket; "json/app"; BLOB size:C605(vblWCResponse))
		WC_SendBody($socket; ->vblWCResponse)
	Else   //  (vMimeType="application/json")
		TEXT TO BLOB:C554(vResponse; vblWCResponse; UTF8 text without length:K22:17; *)
		Http_SendWWWHd($socket; "application/json"; BLOB size:C605(vblWCResponse))
		WC_SendBody($socket; ->vblWCResponse)
End case 
//  // ### bj ### 20200612_1818
