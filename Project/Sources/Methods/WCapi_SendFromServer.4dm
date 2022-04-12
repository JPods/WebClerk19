//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/29/20, 19:01:19
// ----------------------------------------------------
// Method: WCapi_SendFromServer
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_BOOLEAN:C305($vbPathError)
$vbPathError:=False:C215
C_OBJECT:C1216($voTableData)


vMimeType:="application/json"
//vMimeType:="json/app"

C_OBJECT:C1216($voTableData)
$voTableData:=New object:C1471
Case of 
	: (voState.request=Null:C1517)
		vResponse:="AlreadySent"
	: (vResponse="AlreadySent@")
		// images out of QA
	: (vResponse="Err@")  // set vResponse to an Error status and replace if a good result occured
		$voTableData.error:=vResponse
		vResponse:=JSON Stringify:C1217($voTableData)
		$vbPathError:=True:C214
		//  : (voState.result=Null)  
		//vResponse:="Error: Empty vResponse: "+voState.request.URL.pathNameTrimmed
		//$voTableData.error:=vResponse
		//vResponse:=JSON Stringify($voTableData)
	Else 
		
		// send vResponse
End case 

SET BLOB SIZE:C606(vblWCResponse; 0)
// ### bj ### 20200101_2020
// may need to expand the options and place the sending in each choice above  WC_MimeBuild
Case of 
	: (vResponse="AlreadySent")
		// no more action required
	: (vMimeType="application/json")
		TEXT TO BLOB:C554(vResponse; vblWCResponse; UTF8 text without length:K22:17; *)
		Http_SendWWWHd($socket; "application/json"; BLOB size:C605(vblWCResponse))
		WC_SendBody($socket)
	Else   //  (vMimeType="application/json")
		TEXT TO BLOB:C554(vResponse; vblWCResponse; UTF8 text without length:K22:17; *)
		Http_SendWWWHd($socket; "application/json"; BLOB size:C605(vblWCResponse))
		
		WC_SendBody($socket)
End case 
//  // ### bj ### 20200612_1818







