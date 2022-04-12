//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/15/13, 11:49:50
// ----------------------------------------------------
// Method: EmailVerifyWithTelnet
// Description
// 
//
// Parameters
// ----------------------------------------------------

//  https://www.webdigi.co.uk/blog/2009/how-to-check-if-an-email-address-exists-without-sending-an-email/

//Ref:  SMTP_SendMsg4D ($doTestOnly)
//Ref:  SMTPVerifyWithAnE
//Ref: SMTP_SendMailByTCP

C_POINTER:C301($1)
C_TEXT:C284($2)
C_BOOLEAN:C305($3; vbDoEventLog)
C_TEXT:C284($receivereMailServer)

SMTP_SentBy("admin")  //[CallReport]nameID;Current user)
If (Position:C15("@"; vtEmailSender)>1)
	vtEmailMessageLog:=""
	C_LONGINT:C283($originalPort)
	C_LONGINT:C283($originalPort)
	C_LONGINT:C283(ePortOverRide)
	$originalPort:=viEmailport
	If (ePortOverRide=0)
		viEmailport:=25
	Else 
		viEmailport:=ePortOverRide
	End if 
	vtEmailStatusMessage:=""  //used to state status not messages
	If (Count parameters:C259>1)
		$ptCurTable:=$1
		vtEmailReceiver:=$2
	Else 
		$ptCurTable:=(->[Customer:2])
		vtEmailSender:="<bill.james@jitcorp.com>"
		vtEmailReceiver:="<bill.james@functionaldevices.com>"
	End if 
	vbDoEventLog:=(<>viDebugMode>0)
	If (vbDoEventLog)
		vbDoEventLog:=True:C214
	End if 
	$p:=Position:C15(Char:C90(64); vtEmailReceiver)
	If ($p<2)
		vtEmailReceiver:=""
	End if 
	If (vtEmailReceiver#"")
		$receivereMailServer:=Substring:C12(vtEmailReceiver; $p+1)  // should this switch from sender's server to receiver server?
		
		C_BOOLEAN:C305($doTestOnly)
		C_LONGINT:C283(viMatch; $i; $k; $lowValue; $currentValue)
		C_TEXT:C284($command; $input; $output; $errorText; vtEmailMessageLog; $finalText)
		$finalText:=""
		
		If (<>viDebugMode>410)
			ConsoleMessage("Verify: "+vtEmailReceiver)
		End if 
		$command:="nslookup -q=mx "+$receivereMailServer
		If (<>viDebugMode>410)
			ConsoleMessage($command)
		End if 
		LAUNCH EXTERNAL PROCESS:C811($command; $input; $output; $errorText)
		
		If ($errorText="")
			$errorText:="NONE"
		End if 
		
		vtEmailMessageLog:="//COMMAND: "+"\r"+$command+"\r"+"//INPUT: "+"\r"+$input+"\r"+"//OUTPUT: "+"\r"+$output+"\r"+"//ERROR: "+"\r"+$errorText+"\r"
		ARRAY TEXT:C222(atMatches; 0; 0)
		$output:=Replace string:C233($output; "\r"; "\n")
		viMatch:=Preg Match All("(?m)^.*?mail exchanger = ([0-9]*)\\s*(.*?)\\.?$"; $output; atMatches; Regex Multi Line)
		If (viMatch=0)
			// ### jwm ### 20171207_1331 added missing error message for mail server not found
			If (<>viDebugMode>410)
				ConsoleMessage("Output: "+$output)
				ConsoleMessage("ERROR: No Mail Server Found "+$receivereMailServer)
			End if 
			vtEmailMessageLog:=vtEmailMessageLog+"\r"+"ERROR: No Mail Server Found For "+$receivereMailServer+"\r"
		Else 
			
			//ALERT(String(viMatch))
			$k:=Size of array:C274(atMatches)
			ARRAY TEXT:C222($aDomainList; $k)
			ARRAY LONGINT:C221($aDomainPriority; $k)
			
			$lowValue:=32000
			For ($i; 1; $k)
				//ALERT(atMatches{vi1}{1}+", "+atMatches{vi1}{2}+", "+atMatches{vi1}{3})
				$finalText:=$finalText+atMatches{$i}{1}+", "+atMatches{$i}{2}+", "+atMatches{$i}{3}+"\r"
				$aDomainList{$i}:=atMatches{$i}{3}
				$aDomainPriority{$i}:=Num:C11(atMatches{$i}{2})
			End for 
			//SET TEXT TO CLIPBOARD(vText1)
			
			
			SORT ARRAY:C229($aDomainPriority; $aDomainList)
			Repeat 
				$cntRay:=Size of array:C274($aDomainList)
				If ($cntRay=0)
					vtEmailMessageLog:="//No valid $receivereMailServer found"+"\r"+vtEmailMessageLog
				Else   // we have an email server
					$receivereMailServer:=$aDomainList{1}
					//
					C_LONGINT:C283($serverSocket; $cntMailWait; $err)
					$err:=0
					If (<>vlWebTimeOutDelay=0)
						<>vlWebTimeOutDelay:=10
					End if 
					$cntMailWait:=0
					C_TEXT:C284($options)
					
					HTTP_TimeOut:=Milliseconds:C459+3000
					$options:="connect-timeout="+String:C10(HTTP_TimeOut)
					
					$serverSocket:=TCP Open($receivereMailServer; viEmailport; $options)  // open connection with SMTP host, time out 8192
					
					If (HTTP_TimeOut<Milliseconds:C459)  //??$serverSocket#0))
						TCP Close($serverSocket)  // no more data to send
						vtEmailMessageLog:="//MailServer Timed Out: "+$receivereMailServer+", Port: "+String:C10(viEmailport)+", Time: "+String:C10(HTTP_TimeOut)+"\r"+vtEmailMessageLog
					Else 
						
						vtEmailMessageLog:=vtEmailMessageLog+"\r"+"\r"+"C: TCPOpen: MailServer: "+$receivereMailServer+", Port: "+String:C10(viEmailport)+"\r"+"\r"+"S: Thread="+String:C10($serverSocket)
						vtEmailMessage:="\r"+"\r"+"S: Thread="+String:C10($serverSocket)+"\r"+"\r"+"C: TCPOpen: MailServer: "+$receivereMailServer+", Port: "+String:C10(viEmailport)
						
						//
						If (vbDoEventLog)
							EventLogsMessage(vtEmailMessageLog)
						End if 
						//
						If ($serverSocket#0)
							
							vtEmailMessageLog:=vtEmailMessageLog+"\r"+"\r"+"C: WaitConn:"+"\r"+"\r"+"S: Err="+String:C10($err)+"\r"
							vtEmailMessage:="\r"+"S: Err="+String:C10($err)+"\r"+"\r"+"C: WaitConn:"+"\r"+vtEmailMessageLog
							//
							$debut:=Current time:C178
							C_LONGINT:C283($streamStatus)
							Repeat 
								$err:=TCP Get State($serverSocket)
								IDLE:C311
							Until (($err=8) | ($err=0) | (Current time:C178>($debut+?00:00:30?)))
							//
							If ($err=8)  //for an asynchronous example, please see http_server procedure.
								
								vtEmailStatusMessage:="failed connection"  // set a default value, 
								
								Case of   // ### jwm ### 20180427_1552
									: (Storage:C1525.default.domain#"")
										$err:=SMTP_Answer($serverSocket; "HELO "+Storage:C1525.default.domain+Storage:C1525.char.crlf)  // wait SMTP answer
										
									: (vtEmailServer#"")  // senders email server
										$err:=SMTP_Answer($serverSocket; "HELO "+vtEmailServer+Storage:C1525.char.crlf)  // wait SMTP answer
										
									Else 
										$err:=SMTP_Answer($serverSocket; "HELO HI"+Storage:C1525.char.crlf)  // wait SMTP answer
										
								End case 
								
								//          
								If ($err>0)  // still ok ?
									C_TEXT:C284($testText)
									$err:=SMTP_Answer($serverSocket; "MAIL FROM: <"+vtEmailSender+">"+Storage:C1525.char.crlf)  // sender email   `+$nameFrom+ `###_jwm_### 20080318
									vtEmailStatusMessage:="sender rejected"
									
									If ($err>0)  // still ok ?
										$err:=SMTP_Answer($serverSocket; "RCPT TO: <"+vtEmailReceiver+">"+Storage:C1525.char.crlf)  // recipient email      +$nameTo+ `###_jwm_### 20080318
										
										vtEmailStatusMessage:=vtEmailMessage
										$err:=SMTP_Answer($serverSocket; "quit"+Storage:C1525.char.crlf)
										
										$cntMailWait:=30
									End if 
								Else 
									$cntMailWait:=$cntMailWait+1
									DELAY PROCESS:C323(Current process:C322; 10)  //tics
									//$0:=$cntMailWait
								End if 
							End if 
						End if 
						TCP Close($serverSocket)  // no more data to send
						
					End if 
					// completed testing email server decrement array
					DELETE FROM ARRAY:C228($aDomainList; 1)
				End if 
			Until (($cntRay=0) | (vtEmailMessage="2@"))  //ran out of servers to test or got a positive result
			//Until (($cntMailWait>20) | (<>vbWCstop))
			
			If (Length:C16(vtEmailMessageLog)>0)
				$err:=Num:C11(vtEmailMessageLog[[1]])
			Else 
				$err:=-5
			End if 
			//If ((vHere>1) & (allowAlerts_boo))
			//GUI_TextEditDia (->vtEmailMessageLog;"email details")
			//End if
			
			C_DATE:C307($dateStatus)
			If ((vtEmailStatusMessage="sent") | (vtEmailStatusMessage="verified"))
				$dateStatus:=Current date:C33
			Else 
				$dateStatus:=!2001-01-01!
			End if 
			Case of 
				: ($ptCurTable=(->[Customer:2]))
					[Customer:2]emailVerified:110:=$dateStatus
					SAVE RECORD:C53($ptCurTable->)
				: ($ptCurTable=(->[CallReport:34]))
					[CallReport:34]emailVerified:46:=$dateStatus
					If (($doTestOnly) & (vtEmailStatusMessage="Sent"))
						[CallReport:34]emailStatus:45:="Verified"
					Else 
						[CallReport:34]emailStatus:45:=vtEmailStatusMessage
					End if 
					SAVE RECORD:C53($ptCurTable->)
				: ($ptCurTable=(->[Contact:13]))
					[Contact:13]emailVerified:56:=$dateStatus
					SAVE RECORD:C53($ptCurTable->)
				: ($ptCurTable=(->[Order:3]))
					[Order:3]emailVerified:127:=$dateStatus
					SAVE RECORD:C53($ptCurTable->)
				: ($ptCurTable=(->[Invoice:26]))
					[Invoice:26]emailVerified:96:=$dateStatus
					SAVE RECORD:C53($ptCurTable->)
				: ($ptCurTable=(->[Proposal:42]))
					[Proposal:42]emailVerified:86:=$dateStatus
					SAVE RECORD:C53($ptCurTable->)
				: ($ptCurTable=(->[Service:6]))
					[Service:6]emailVerified:13:=$dateStatus
					SAVE RECORD:C53($ptCurTable->)
			End case 
			
		End if 
		
		ConsoleMessage(vtEmailMessageLog)  // ### jwm ### 20171207_1340 moved outside of If statement above
		
		If (vbDoEventLog)
			CREATE RECORD:C68([EventLog:75])
			[EventLog:75]groupid:3:="email verification"
			[EventLog:75]company:46:=vtEmailReceiver
			EventLogsMessage(vtEmailMessageLog)
			[EventLog:75]status:48:=vtEmailStatusMessage
			// ### bj ### 20210912_1208  should be by obEventLog.id
			If ([EventLog:75]id:54#"")
				SAVE RECORD:C53([EventLog:75])
			End if 
		End if 
	End if 
End if 
//     
//     2.X.X    Success
//     4.X.X    Persistent Transient Failure
//     5.X.X    Permanent Failure
//     X.0.X    Other or Undefined Status
//     X.1.X    Addressing Status
//     X.2.X    Mailbox Status
//     X.3.X    Mail System Status
//     X.4.X    Network and Routing Status
//     X.5.X    Mail Delivery Protocol Status
//     X.6.X    Message Content or Media Status
//     X.7.X    Security or Policy Status
//     X.0.0    Other undefined Status
//     X.1.0    Other address status
//     X.1.1    Bad destination mailbox address
//     X.1.2    Bad destination system address
//     X.1.3    Bad destination mailbox address syntax
//     X.1.4    Destination mailbox address ambiguous
//     X.1.5    Destination address valid
//     X.1.6    Destination mailbox has moved, No forwarding address
//     X.1.7    Bad sender's mailbox address syntax
//     X.1.8    Bad sender's system address
//     X.2.0    Other or undefined mailbox status
//     X.2.1    Mailbox disabled, not accepting messages
//     X.2.2    Mailbox full
//     X.2.3    Message length exceeds administrative limit
//     X.2.4    Mailing list expansion problem
//     X.3.0    Other or undefined mail system status
//     X.3.1    Mail system full
//     X.3.2    System not accepting network messages
//     X.3.3    System not capable of selected features
//     X.3.4    Message too big for system
//     X.3.5    System incorrectly configured
//     X.4.0    Other or undefined network or routing status
//     X.4.1    No answer from host
//     X.4.2    Bad connection
//     X.4.3    Directory server failure
//     X.4.4    Unable to route
//     X.4.5    Mail system congestion
//     X.4.6    Routing loop detected
//     X.4.7    Delivery time expired
//     X.5.0    Other or undefined protocol status
//     X.5.1    Invalid command
//     X.5.2    Syntax error
//     X.5.3    Too many recipients
//     X.5.4    Invalid command arguments
//     X.5.5    Wrong protocol version
//     X.6.0    Other or undefined media error
//     X.6.1    Media not supported
//     X.6.2    Conversion required and prohibited
//     X.6.3    Conversion required but not supported
//     X.6.4    Conversion with loss performed
//     X.6.5    Conversion Failed
//     X.7.0    Other or undefined security status
//     X.7.1    Delivery not authorized, message refused
//     X.7.2    Mailing list expansion prohibited
//     X.7.3    Security conversion required but not possible
//     X.7.4    Security features not supported
//     X.7.5    Cryptographic failure
//     X.7.6    Cryptographic algorithm not supported
//     X.7.7    Message integrity failure
//     X.1.0    Other address status
//     X.1.1    Bad destination mailbox address
//     X.1.2    Bad destination system address
//     X.1.3    Bad destination mailbox address syntax
//     X.1.4    Destination mailbox address ambiguous
//     X.1.5    Destination mailbox address valid
//     X.1.6    Mailbox has moved
//     X.1.7    Bad sender's mailbox address syntax
//     X.1.8    Bad sender's system address
//     X.2.0    Other or undefined mailbox status
//     X.2.1    Mailbox disabled, not accepting messages
//     X.2.2    Mailbox full
//     X.2.3    Message length exceeds administrative limit.
//     X.2.4    Mailing list expansion problem
//     X.3.0    Other or undefined mail system status
//     X.3.1    Mail system full
//     X.3.2    System not accepting network messages
//     X.3.3    System not capable of selected features
//     X.3.4    Message too big for system
//     X.4.0    Other or undefined network or routing status
//     X.4.1    No answer from host
//     X.4.2    Bad connection
//     X.4.3    Routing server failure
//     X.4.4    Unable to route
//     X.4.5    Network congestion
//     X.4.6    Routing loop detected
//     X.4.7    Delivery time expired
//     X.5.0    Other or undefined protocol status
//     X.5.1    Invalid command
//     X.5.2    Syntax error
//     X.5.3    Too many recipients
//     X.5.4    Invalid command arguments
//     X.5.5    Wrong protocol version
//     X.6.0    Other or undefined media error
//     X.6.1    Media not supported
//     X.6.2    Conversion required and prohibited
//     X.6.3    Conversion required but not supported
//     X.6.4    Conversion with loss performed
//     X.6.5    Conversion failed
//     X.7.0    Other or undefined security status
//     X.7.1    Delivery not authorized, message refused
//     X.7.2    Mailing list expansion prohibited
//     X.7.3    Security conversion required but not possible
//     X.7.4    Security features not supported
//     X.7.5    Cryptographic failure
//     X.7.6    Cryptographic algorithm not supported
//     X.7.7    Message integrity failure
//     