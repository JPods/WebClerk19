//%attributes = {}

// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/07/08, 08:39:30
// ----------------------------------------------------
// Method: WC_Server
// Listens for incoming http connections
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(<>HTTPD_Socket; $1; $webClerkRecordNum)
C_TEXT:C284($certAlert; $keyAlert)
//ztest_<>vbWCstop:=False
//
//This will use the default file names "cert.pem" and "key.pem".
$webClerkRecordNum:=$1
READ ONLY:C145([WebClerk:78])
GOTO RECORD:C242([WebClerk:78]; $webClerkRecordNum)
If (Records in selection:C76([WebClerk:78])=1)
	
	
	<>HTTPD_Socket:=TCP Listen(""; Storage:C1525.wc.portNum)
	//for the monitor to work
	
	// Fix_QQQ by: Bill James (2023-01-06T06:00:00Z)
	
	//Storage.wc.serverSocket:=<>HTTPD_Socket
	
	
	<>tcCertificateFile:=[WebClerk:78]pathToCert:21
	<>tcPrivateKeyFile:=[WebClerk:78]pathToKey:22
	
	
	//zzzCheckThis
	//TRACE
	//Storage.wc.portNumSSL:=0
	//TRACE
	C_TEXT:C284($sslOptions)
	$sslOptions:=""
	// Terminal command to generate a cert request and privatekey
	//  Go to GoDaddy
	//  
	//  openssl req -out CSR.csr -new -newkey rsa:2048 -nodes -keyout privateKey.key
	// the cert request and key will be output to the current directory.
	// Go to Godaddy and buy an SSL for the desired domain. use the domain without the www.
	// Select the choice of Provide a certificate Signing Request (CSR above)
	// Paste in the CSR
	// Download the Apache version of the Certificate
	// Open the Certificate in BBEdit and Open the GoDaddy intermediete cert (multiple certs instead of just one
	// Copy and paste the intermedeia cert below the Certificate
	// Save with Unix LF. 
	// Use this combined certificate as the certificate
	// we should start putting the issue date into the name of the cert and key
	
	// Modified by: Bill James (creditcard, alert removed for greater flexibility using xml)
	// Self-signed certificate
	//  openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout privateKey.key -out certificate.crt
	
	// One line self-signed cert
	// openssl req -x509 -nodes -sha256 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365
	
	
	If (Records in selection:C76([WebClerk:78])#1)
		ALERT:C41("No WebClerk record.")
	Else 
		
		//Storage.wc.enableSSL:=[WebClerk]SSLEnable    // ### JWM ### 20171012_1547 set in WC_TestFolder
		C_LONGINT:C283($sslOK; $hostingStarted)
		$sslOK:=WC_CertKeyCheck
		
		$hostingStarted:=2
		
		// placed for readability of quoted string
		$path2Cert:=[WebClerk:78]pathToCert:21
		$path2Key:=[WebClerk:78]pathToKey:22
		$path2Cert:="\""+$path2Cert+"\""  // ### jwm ### 20170608_1620 Quoted Path
		$path2Key:="\""+$path2Key+"\""  // ### jwm ### 20170608_1620 Quoted Path
		
		If ($sslOK=1)
			// ### jwm ### 20170623_1634 upgraded to TLS 1.2
			$sslOptions:="ssl=true ssl-method=TLSv1_2 ssl-certificate="+$path2Cert+" ssl-private-key="+$path2Key
		End if 
		
		Case of 
			: (($certAlert#"") | ($keyAlert#""))
				ALERT:C41($certAlert+"\r"+$keyAlert)
			: (Not:C34(Storage:C1525.wc.enableSSL))
				Storage:C1525.wc.sslSocket:=0
			: (($sslOK=1) & (<>tcPrivateKeyPass#""))
				$sslOptions:=$sslOptions+" ssl-password="+[WebClerk:78]privateKeyPass:36
				Storage:C1525.wc.sslSocket:=TCP Listen(""; Storage:C1525.wc.portNumSSL; $sslOptions)
			: ($sslOK=1)
				Storage:C1525.wc.sslSocket:=TCP Listen(""; Storage:C1525.wc.portNumSSL; $sslOptions)
			Else 
				Storage:C1525.wc.sslSocket:=0
		End case 
		If ((Storage:C1525.wc.enableSSL) & (Storage:C1525.wc.sslSocket=0))
			ALERT:C41("Failed to launch HTTPD SSL server."+"\r"+"Cert: "+<>tcCertificateFile+"\r"+"Key: "+<>tcPrivateKeyFile+"\r"+"Pass: "+<>tcPrivateKeyPass+"\r"+"SSLSock: "+String:C10(Storage:C1525.wc.sslSocket)+"\r"+"SSLPort: "+String:C10(Storage:C1525.wc.portNumSSL))
		End if 
		
		If (Storage:C1525.wc.sslSocket=0)
			$hostingStarted:=$hostingStarted-1  // take of once chance
		End if 
		
		// ### jwm ### 20151221_1006 
		If (<>HTTPD_Socket=0)
			ALERT:C41("Failed to launch HTTPD server. Port Number: "+String:C10(Storage:C1525.wc.portNum)+"\r")
			$hostingStarted:=$hostingStarted-1
		End if 
		
		If ($hostingStarted=0)
			ConsoleLaunch
			ConsoleLog("Failed to launch HTTPD server."+"\r"+"Cert: "+<>tcCertificateFile+"\r"+"Key: "+<>tcPrivateKeyFile+"\r"+"Pass: "+<>tcPrivateKeyPass+"\r"+"SSLSock: "+String:C10(Storage:C1525.wc.sslSocket)+"\r"+"SSLPort: "+String:C10(Storage:C1525.wc.portNumSSL))
			
			If (<>HTTPD_Socket#0)
				TCP Close(<>HTTPD_Socket)
			End if 
			If (Storage:C1525.wc.sslSocket#0)
				TCP Close(Storage:C1525.wc.sslSocket)
			End if 
		Else 
			// Launch handers and start listening
			
			WC_ThreadPoolStart(Storage:C1525.wc.threadCount+<>RPServer+<>UpLoadServer; 256*1024; "WC_RequestHandler")
			
			While ((<>vbWCstop=False:C215) & (TCP Get State(<>HTTPD_Socket)=TCP Listening))  //&(Process aborted=False)
				
				// Check for incoming requests on either socket
				$socket:=TCP Accept(<>HTTPD_Socket)
				If (($socket=0) & (Storage:C1525.wc.sslSocket#0))
					$socket:=TCP Accept(Storage:C1525.wc.sslSocket)
				End if 
				
				If ($socket#0)
					// A request comes in, hand it over to the thread pool
					WC_ThreadPoolQueue("WC_RequestHandler"; String:C10($socket))
				Else 
					DELAY PROCESS:C323(Current process:C322; 1)
					
				End if 
				
			End while 
			
			If (<>HTTPD_Socket#0)
				// We're done, close the stocket and stop the thread pool
				TCP Close(<>HTTPD_Socket)
			End if 
			If (Storage:C1525.wc.sslSocket#0)
				TCP Close(Storage:C1525.wc.sslSocket)
			End if 
			
			WC_ThreadPoolStop
			//ztest_<>vbWCstop:=False
		End if 
	End if 
End if 
