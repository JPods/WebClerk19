//%attributes = {}
// (PM) WC_SendBody
// $1 = Socket

C_LONGINT:C283($1; $socket; $bytesSent)
$socket:=voState.socket
$bytesSent:=TCP Send Blob($socket; vblWCResponse)

WC_LogEvent("WC_SendBody, path "+voState.request.URL.pathName+", bytes sent: "; String:C10($bytesSent))

