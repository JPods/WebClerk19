//%attributes = {}
// (PM) WC_UpdateMonitor

C_LONGINT:C283(HTTPD_BytesSend; HTTPD_BytesReceived)
C_LONGINT:C283(HTTPD_AttemptedConn; HTTPD_AcceptedConn; HTTPD_FailedConn; HTTPD_ClosedConn; HTTPD_ActiveConn; HTTPD_MaxConn)

If (Storage:C1525.wc.serverSocket#0)
	
	// Get the statistics from the server socket
	HTTPD_BytesSend:=TCP Get Statistics(Storage:C1525.wc.serverSocket; TCP Bytes Send)
	HTTPD_BytesReceived:=TCP Get Statistics(Storage:C1525.wc.serverSocket; TCP Bytes Receivd)
	HTTPD_AttemptedConn:=TCP Get Statistics(Storage:C1525.wc.serverSocket; TCP Attempted Connections)
	HTTPD_AcceptedConn:=TCP Get Statistics(Storage:C1525.wc.serverSocket; TCP Accepted Connections)
	HTTPD_FailedConn:=TCP Get Statistics(Storage:C1525.wc.serverSocket; TCP Failed Connections)
	HTTPD_ClosedConn:=TCP Get Statistics(Storage:C1525.wc.serverSocket; TCP Closed Connections)
	HTTPD_ActiveConn:=TCP Get Statistics(Storage:C1525.wc.serverSocket; TCP Active Connections)
	HTTPD_MaxConn:=TCP Get Statistics(Storage:C1525.wc.serverSocket; TCP Maximum Connections)
	
End if 

If ((Storage:C1525.wc.enableSSL) & (Storage:C1525.wc.sslSocket#0))
	
	// Add the statistics for the SSL socket
	HTTPD_BytesSend:=HTTPD_BytesSend+TCP Get Statistics(Storage:C1525.wc.sslSocket; TCP Bytes Send)
	HTTPD_BytesReceived:=HTTPD_BytesReceived+TCP Get Statistics(Storage:C1525.wc.sslSocket; TCP Bytes Receivd)
	HTTPD_AttemptedConn:=HTTPD_AttemptedConn+TCP Get Statistics(Storage:C1525.wc.sslSocket; TCP Attempted Connections)
	HTTPD_AcceptedConn:=HTTPD_AcceptedConn+TCP Get Statistics(Storage:C1525.wc.sslSocket; TCP Accepted Connections)
	HTTPD_FailedConn:=HTTPD_FailedConn+TCP Get Statistics(Storage:C1525.wc.sslSocket; TCP Failed Connections)
	HTTPD_ClosedConn:=HTTPD_ClosedConn+TCP Get Statistics(Storage:C1525.wc.sslSocket; TCP Closed Connections)
	HTTPD_ActiveConn:=HTTPD_ActiveConn+TCP Get Statistics(Storage:C1525.wc.sslSocket; TCP Active Connections)
	HTTPD_MaxConn:=HTTPD_MaxConn+TCP Get Statistics(Storage:C1525.wc.sslSocket; TCP Maximum Connections)
	
End if 

ARRAY LONGINT:C221(alWCREQHANDLERID; 0)
ARRAY TEXT:C222(aREQHANDLERNAME; 0)
ARRAY TEXT:C222(aREQHANDLERSTATE; 0)
//ARRAY TEXT(HTTPD_ReqHandlereventID;0)

WC_ThreadPoolGetThreadStates(->alWCREQHANDLERID; ->aREQHANDLERNAME; ->aREQHANDLERSTATE)
