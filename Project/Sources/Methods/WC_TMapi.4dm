//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/28/20, 09:45:31
// ----------------------------------------------------
// Method: WC_TMapi
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (Macintosh command down:C546)
	TRACE:C157
End if 
vResponse:="Error: No TallyMasters Record"
C_TEXT:C284($vtPurpose; $vtName; $vtSecurityLevel; $vtParameters)
C_LONGINT:C283($visecurityLevel)
$viSecurityLevel:=[RemoteUser:57]securityLevel:4
If (voState.request.parameters.tmapi=Null:C1517)
	vResponse:="Error: tmapi: not defined"
Else 
	$vtName:=voState.request.parameters.tmapi
	If ($vtName="")
		vResponse:="Error: tmapi: tmapi name is empty."
	Else 
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="tmapi"; *)
		QUERY:C277([TallyMaster:60];  & ; [TallyMaster:60]name:8=$vtName)
		If (Records in selection:C76([TallyMaster:60])=0)
			vResponse:="Error: tmapi: tmapi name: "+$vtName+" does not exist."
		Else 
			ExecuteText(0; [TallyMaster:60]script:9; "ExecuteTM Name: "+[TallyMaster:60]name:8+"; Purpose: "+[TallyMaster:60]purpose:3)
		End if 
	End if 
End if 
SET BLOB SIZE:C606($vblWCResponse; 0)
TEXT TO BLOB:C554(vResponse; $vblWCResponse; UTF8 text without length:K22:17; *)
Case of 
	: ((vMimeType="json/app") | (vMimeType=""))
		TEXT TO BLOB:C554(vResponse; $vblWCResponse; UTF8 text without length:K22:17; *)
		Http_SendWWWHd($socket; "json/app"; BLOB size:C605($vblWCResponse))
		WC_SendBody($socket)
	Else   //  (vMimeType="application/json")
		TEXT TO BLOB:C554(vResponse; $vblWCResponse; UTF8 text without length:K22:17; *)
		Http_SendWWWHd($socket; vMimeType; BLOB size:C605($vblWCResponse))
		WC_SendBody($socket)
End case 