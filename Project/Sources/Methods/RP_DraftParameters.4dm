//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/27/20, 23:42:13
// ----------------------------------------------------
// Method: RP_DraftParameters
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($returnText)
$returnText:="WC_Request (\"GET\")  or (\"POST\")  is the command that sends and receives a web request."+"\r"+"\r"
$returnText:=$returnText+"vDataReceived data returned from the web."+"\r"+"\r"
$returnText:=$returnText+"Record Passing Editor under the File menu is a sandbox for this command."+"\r"+"\r"

$returnText:=$returnText+"HTTP_TestMode   =   1  set in test mode"+"\r"
$returnText:=$returnText+"HTTP_TimeOut   =   10//seconds"+"\r"
$returnText:=$returnText+"HTTP_Protocol   =   \"https\"//process as SSL"+"\r"
// $returnText:=$returnText+"HTTP_Method   =   \"Post\"    $returnText:=$returnText+\"method of sending\""+"\r"
$returnText:=$returnText+"HTTP_Path   =   Server command  see TechNotes examples "+"\r"
$returnText:=$returnText+"HTTP_Host   =   Server manchine, example www.webclerk.com"+"\r"
$returnText:=$returnText+"HTTP_Port   =   the Port"+"\r"
$returnText:=$returnText+"HTTP_SendingBlob     =   data to send in blob format"+"\r"
$returnText:=$returnText+"HTTP_IncomingBlob     =   data received back in blob format"+"\r"
$returnText:=$returnText+" HTTP_APIKey     =   Key to access account"+"\r"
$returnText:=$returnText+" vWCPayload and vDataReceived are two copies of the returned data to facilitate debugging your scripts"+"\r"
vTextSummary:=$returnText+"\r"+"\r"+vTextSummary
