
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/30/18, 18:54:25
// ----------------------------------------------------
// Method: [Control].RP_Editor.Button22
// Description
// 
//
// Parameters
// ----------------------------------------------------



If (vUniqueID<1)
	ALERT:C41("You must select a relationship.")
Else 
	C_LONGINT:C283($sizeResponse)
	SET BLOB SIZE:C606(HTTP_Data; 0)
	$error:=WC_Request("GET"; HTTP_URL+"/heart_beat"; "")  //Sends empth 
	vDataReceived:=BLOB to text:C555(HTTP_IncomingBlob; UTF8 text without length:K22:17)
End if 
