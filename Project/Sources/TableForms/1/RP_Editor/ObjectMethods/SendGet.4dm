
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/30/18, 17:27:34
// ----------------------------------------------------
// Method: [Control].RP_Editor.SendGet
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_BLOB:C604(HTTP_Data)
SET BLOB SIZE:C606(HTTP_Data; 0)


//maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=YOUR_API_KEY
// HTTP_URL:=HTTP_URL+HTTP_Path

$error:=WC_Request("GET")  // leave empty on a get

vDataReceived:=BLOB to text:C555(HTTP_IncomingBlob; UTF8 text without length:K22:17)

vDataReceived:=vDataReceived+("\r"*3)+"//////  voState.request.URL.pathName = "+voState.request.URL.pathName

vDataReceived:=vDataReceived+("\r"*3)+"//////  voState.request.URL.pathName = "+vWCPayload
