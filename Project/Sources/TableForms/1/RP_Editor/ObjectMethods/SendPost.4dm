
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/30/18, 18:01:57
// ----------------------------------------------------
// Method: [Control].RP_Editor.Button7
// Description
// 
//
// Parameters
// ----------------------------------------------------
// 
TEXT TO BLOB:C554(vDataToSend; HTTP_DATA)

vDataReceived:=""
$error:=WC_Request("POST"; "build")

vDataReceived:=BLOB to text:C555(HTTP_IncomingBlob; UTF8 text without length:K22:17)

vDataReceived:=vDataReceived+("\r"*3)+"//////  voState.request.URL.pathName = "+voState.request.URL.pathName
