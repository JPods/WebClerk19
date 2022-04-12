//%attributes = {}
// (PM) WC_UpdateMonitor

C_LONGINT:C283(HTTPD_BytesSend; HTTPD_BytesReceived)
C_LONGINT:C283(HTTPD_AttemptedConn; HTTPD_AcceptedConn; HTTPD_FailedConn; HTTPD_ClosedConn; HTTPD_ActiveConn; HTTPD_MaxConn)

If (<>HTTPD_ServerSocket#0)
	
	// Get the statistics from the server socket
	HTTPD_BytesSend:=TCP Get Statistics(<>HTTPD_ServerSocket; TCP Bytes Send)
	HTTPD_BytesReceived:=TCP Get Statistics(<>HTTPD_ServerSocket; TCP Bytes Receivd)
	HTTPD_AttemptedConn:=TCP Get Statistics(<>HTTPD_ServerSocket; TCP Attempted Connections)
	HTTPD_AcceptedConn:=TCP Get Statistics(<>HTTPD_ServerSocket; TCP Accepted Connections)
	HTTPD_FailedConn:=TCP Get Statistics(<>HTTPD_ServerSocket; TCP Failed Connections)
	HTTPD_ClosedConn:=TCP Get Statistics(<>HTTPD_ServerSocket; TCP Closed Connections)
	HTTPD_ActiveConn:=TCP Get Statistics(<>HTTPD_ServerSocket; TCP Active Connections)
	HTTPD_MaxConn:=TCP Get Statistics(<>HTTPD_ServerSocket; TCP Maximum Connections)
	
End if 

If ((<>HTTPD_EnableSSL) & (<>HTTPD_SSLSocket#0))
	
	// Add the statistics for the SSL socket
	HTTPD_BytesSend:=HTTPD_BytesSend+TCP Get Statistics(<>HTTPD_SSLSocket; TCP Bytes Send)
	HTTPD_BytesReceived:=HTTPD_BytesReceived+TCP Get Statistics(<>HTTPD_SSLSocket; TCP Bytes Receivd)
	HTTPD_AttemptedConn:=HTTPD_AttemptedConn+TCP Get Statistics(<>HTTPD_SSLSocket; TCP Attempted Connections)
	HTTPD_AcceptedConn:=HTTPD_AcceptedConn+TCP Get Statistics(<>HTTPD_SSLSocket; TCP Accepted Connections)
	HTTPD_FailedConn:=HTTPD_FailedConn+TCP Get Statistics(<>HTTPD_SSLSocket; TCP Failed Connections)
	HTTPD_ClosedConn:=HTTPD_ClosedConn+TCP Get Statistics(<>HTTPD_SSLSocket; TCP Closed Connections)
	HTTPD_ActiveConn:=HTTPD_ActiveConn+TCP Get Statistics(<>HTTPD_SSLSocket; TCP Active Connections)
	HTTPD_MaxConn:=HTTPD_MaxConn+TCP Get Statistics(<>HTTPD_SSLSocket; TCP Maximum Connections)
	
End if 

ARRAY LONGINT:C221(alWCREQHANDLERID; 0)
ARRAY TEXT:C222(aREQHANDLERNAME; 0)
ARRAY TEXT:C222(aREQHANDLERSTATE; 0)
//ARRAY TEXT(HTTPD_ReqHandlereventID;0)

WC_ThreadPoolGetThreadStates(->alWCREQHANDLERID; ->aREQHANDLERNAME; ->aREQHANDLERSTATE)
