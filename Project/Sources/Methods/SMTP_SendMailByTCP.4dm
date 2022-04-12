//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/15/13, 10:48:29
// ----------------------------------------------------
// Method: SMTP_SendMailByTCP
// Description
// 
//
// Parameters
// ----------------------------------------------------

//Ref:  SMTP_SendMsg4D ($doTestOnly)
//Ref:  SMTPVerifyWithAnE
//Ref: SMTP_SendMailByTCP

If (False:C215)
	C_BOOLEAN:C305($doTestOnly)
	
	vtEmailMessageLog:=""
	vtEmailMessageLog:=vtEmailMessageLog+" vtEmailReceiver: "+vtEmailReceiver
	vtEmailMessageLog:=vtEmailMessageLog+" vtEmailSender: "+vtEmailSender+"\r"
	vtEmailMessageLog:=vtEmailMessageLog+" vtEmailSubject: "+vtEmailSubject+"\r"
	vtEmailMessageLog:=vtEmailMessageLog+" vtEmailServer: "+vtEmailServer+"\r"
	vtEmailMessageLog:=vtEmailMessageLog+" viEmailport: "+String:C10(viEmailport)+"\r"
	vtEmailMessageLog:=vtEmailMessageLog+" vtEmailUserName: "+vtEmailUserName+"\r"
	vtEmailMessageLog:=vtEmailMessageLog+" vtEmailPassword: "+vtEmailPassword+"\r"
	//vtEmailMessageLog:=vtEmailMessageLog+" vtEmailBody: "+vtEmailBody+"\r"+"///////////End Message/////////"+"\r"+"\r"
	vtEmailMessageLog:=vtEmailMessageLog+" vtEmailPath: "+vtEmailPath+"\r"
	
	
	$serverSocket:=TCP Open(vtEmailServer; viEmailport; $options)  // open connection with SMTP host, time out 8192
	
	vtEmailMessageLog:="C: TCPOpen: MailServer: "+vtEmailServer+", Port: "+String:C10(viEmailport)+"\r"+"S: Tread="+String:C10($serverSocket)
	vtEmailMessage:="S: Tread="+String:C10($serverSocket)+"\r"+"C: TCPOpen: MailServer: "+vtEmailServer+", Port: "+String:C10(viEmailport)
	
	//
	If ($serverSocket#0)
		vtEmailMessageLog:=vtEmailMessageLog+"\r"+"C: WaitConn:"+"\r"+"S: Err="+String:C10($err)
		vtEmailMessage:="S: Err="+String:C10($err)+"\r"+"C: WaitConn:"+"\r"
		//
		$debut:=Current time:C178
		C_LONGINT:C283($streamStatus)
		Repeat 
			$err:=TCP Get State($serverSocket)
			IDLE:C311
		Until (($err=8) | ($err=0) | (Current time:C178>($debut+?00:00:30?)))
		//
		If ($err=8)  //for an asynchronous example, please see http_server procedure.
			vtEmailMessageLog:=vtEmailMessageLog+"\r"+"S: State: 8"
			vtEmailStatusMessage:="failed connection"
			
			//$err:=SMTP_Answer ($serverSocket;"HELO "+ITK_Addr2Name(ITK_Name2Addr(Storage.default.domain);2)+Storage.char.crlf)// wait SMTP answer
			$err:=SMTP_Answer($serverSocket; "HELO "+Storage:C1525.default.domain+Storage:C1525.char.crlf)  // wait SMTP answer
			//          
			If ($err>0)
				$err:=SMTP_AUTH_WC($serverSocket; vtEmailServer; vtEmailUserName; vtEmailPassword)
				vtEmailStatusMessage:="failed authorization"
				If ($err>0)  // still ok ?
					C_TEXT:C284($testText)
					$err:=SMTP_Answer($serverSocket; "MAIL FROM:"+vtEmailSender+Storage:C1525.char.crlf)  // sender email   //+$nameFrom+ //###_jwm_### 20080318
					vtEmailStatusMessage:="sender rejected"
					If ($err>0)  // still ok ?
						$err:=SMTP_Answer($serverSocket; "RCPT TO:"+vtEmailReceiver+Storage:C1525.char.crlf)  // recipient email      +$nameTo+ //###_jwm_### 20080318
						vtEmailStatusMessage:="receiver rejected"
						If ($err>0)
							If ($doTestOnly)
								vtEmailStatusMessage:="sent"
							Else 
								$err:=SMTP_Answer($serverSocket; "DATA"+Storage:C1525.char.crlf)  //  message to follow
								If ($err>0)
									vtEmailStatusMessage:="sent"
									
									//If (vtEmailPath#"")
									$boundary:="=_jitMail"+DateTime_RFCString(Current date:C33; Current time:C178)+"."+Txt_RandomString(10; "a"; "z")
									//$boundary:="==========_=="+String(ITK_Date2Secs (Current date;Current time))+"==_=========="
									$err:=TCP Send($serverSocket; "Mime-Version: 1.0"+Storage:C1525.char.crlf)
									$err:=TCP Send($serverSocket; "Content-Type: multipart/mixed;"+Storage:C1525.char.crlf+"\t"+"boundary="+Char:C90(34)+$boundary+Char:C90(34)+Storage:C1525.char.crlf)
									//Else 
									//$boundary:=""
									//End if 
									$err:=TCP Send($serverSocket; "Date: "+DateTime_RFCString(Current date:C33; Current time:C178)+Storage:C1525.char.crlf)
									$err:=TCP Send($serverSocket; "Subject: "+vtEmailSubject+Storage:C1525.char.crlf)
									If (False:C215)
										
										$err:=TCP Send($serverSocket; "From: "+vtEmailSender+Storage:C1525.char.crlf)
									Else 
										$err:=TCP Send($serverSocket; "From: "+eSender_Tag+Storage:C1525.char.crlf)
									End if 
									If (False:C215)
										
										$err:=TCP Send($serverSocket; "To: "+vtEmailReceiver+Storage:C1525.char.crlf)
									Else 
										$err:=TCP Send($serverSocket; "To: "+vtEmailReceiver_Tag+Storage:C1525.char.crlf)
									End if 
									$err:=TCP Send($serverSocket; Storage:C1525.char.crlf)
									$temp:=Replace string:C233(vtEmailBody; Char:C90(10); "")  // remove LF
									$temp:=Replace string:C233($temp; Char:C90(13); Storage:C1525.char.crlf)  // convert CR to CR/LF
									vtEmailBody:=Replace string:C233($temp; Storage:C1525.char.crlf+"."; Storage:C1525.char.crlf+"..")  // convert starting point
									vText7:=$temp
									C_TEXT:C284($sendThisBlock)
									
									ARRAY TEXT:C222($sendThisElement; 0)
									ARRAY TEXT:C222($sendThisType; 0)
									ARRAY TEXT:C222($sendContentTransfer; 0)
									Repeat 
										$whtml:=Position:C15("<html"; $temp)
										If ($whtml>0)
											If ($whtml>1)
												$w:=Size of array:C274($sendThisElement)+1
												INSERT IN ARRAY:C227($sendThisElement; $w; 1)
												INSERT IN ARRAY:C227($sendThisType; $w; 1)
												INSERT IN ARRAY:C227($sendContentTransfer; $w; 1)
												$sendThisElement{$w}:=Substring:C12($temp; 1; $whtml-1)
												$sendThisType{$w}:="text/plain"
												$sendContentTransfer{$w}:="Content-Transfer-Encoding: 7bit"
												$temp:=Substring:C12($temp; $whtml)
											End if 
											$whtml:=Position:C15("</html>"; $temp)
											$w:=Size of array:C274($sendThisElement)+1
											INSERT IN ARRAY:C227($sendThisElement; $w; 1)
											INSERT IN ARRAY:C227($sendThisType; $w; 1)
											INSERT IN ARRAY:C227($sendContentTransfer; $w; 1)
											$sendThisType{$w}:="Content-Type: text/html; charset="+Txt_Quoted("iso-8859-1")  //+Storage.char.crlf+"Content-Transfer-Encoding: quoted-printable"
											$sendContentTransfer{$w}:="Content-Transfer-Encoding: quoted-printable"
											If ($whtml>1)
												//$sendThisElement{$w}:=ITK_Text2Quoted(Substring($temp;1;$whtml+6))
												$temp:=Substring:C12($temp; $whtml+7)
											Else 
												$sendThisElement{$w}:=$temp
												$temp:=""
											End if 
										Else 
											$w:=Size of array:C274($sendThisElement)+1
											INSERT IN ARRAY:C227($sendThisElement; $w; 1)
											INSERT IN ARRAY:C227($sendThisType; $w; 1)
											INSERT IN ARRAY:C227($sendContentTransfer; $w; 1)
											$sendThisType{$w}:="Content-Type: text/plain"
											$sendContentTransfer{$w}:=""  //Content-Transfer-Encoding: 7bit"
											$sendThisElement{$w}:=$temp
											$temp:=""
										End if 
									Until ($whtml<1)
									
									C_LONGINT:C283($incRay; $cntRay)
									$cntRay:=Size of array:C274($sendThisElement)
									For ($incRay; 1; $cntRay)
										$err:=TCP Send($serverSocket; "--"+$boundary+Storage:C1525.char.crlf)
										$err:=TCP Send($serverSocket; $sendThisType{$incRay}+Storage:C1525.char.crlf)  //+Storage.char.crlf+Storage.char.crlf)
										If ($sendContentTransfer{$incRay}#"")
											$err:=TCP Send($serverSocket; $sendContentTransfer{$incRay}+Storage:C1525.char.crlf)
										End if 
										$err:=TCP Send($serverSocket; Storage:C1525.char.crlf)  //to provide two CRLF
										vtEmailBody:=TagsToText($sendThisElement{$incRay})
										vtEmailBody:=Replace string:C233(vtEmailBody; "="; "=3D")
										$err:=TCP Send($serverSocket; vtEmailBody+Storage:C1525.char.crlf)  // send message text
										
									End for 
									
									$err:=TCP Send($serverSocket; "--"+$boundary+Storage:C1525.char.crlf)
									
									If (False:C215)  //(vtEmailPath#"")
										
										$suffix:=SuffixGet(HFS_ShortName(vtEmailPath))
										C_LONGINT:C283($w)
										$w:=Find in array:C230(<>aMimeSuffix; $suffix)
										If ($w>0)
											$err:=TCP Send($serverSocket; "Content-Type: "+<>aMimeType{$w}+"; name="+Char:C90(34)+vtEmailPath+Char:C90(34)+Storage:C1525.char.crlf)
										Else 
											$err:=TCP Send($serverSocket; "Content-Type: "+"application/unknown"+"; name="+Char:C90(34)+vtEmailPath+Char:C90(34)+Storage:C1525.char.crlf)
										End if 
										$err:=TCP Send($serverSocket; "Content-Disposition: attachment; filename="+Char:C90(34)+vtEmailPath+Char:C90(34)+Storage:C1525.char.crlf+Storage:C1525.char.crlf)
										
										
										$err:=TCP Send File($serverSocket; vtEmailPath)  // convert CR into CRLF while sending the attachment
										$err:=TCP Send($serverSocket; Storage:C1525.char.crlf)
										//
										//
										//
										$err:=TCP Send($serverSocket; "--"+$boundary+"--"+Storage:C1525.char.crlf)
										
									End if 
									$err:=SMTP_Answer($serverSocket; Storage:C1525.char.crlf+"."+Storage:C1525.char.crlf)  // end of message
									If ($err>0)
										$err:=SMTP_Answer($serverSocket; "QUIT"+Storage:C1525.char.crlf)  // close SMTP session
									End if 
								End if 
								
								TCP Close($serverSocket)  // no more data to send
							End if 
							$cntMailWait:=30
						End if 
					Else 
						$cntMailWait:=$cntMailWait+1
						DELAY PROCESS:C323(Current process:C322; 10)  //tics
						//$0:=$cntMailWait
						
						//            
					End if 
				End if 
			End if 
		End if 
	End if 
	//Until (($cntMailWait>20) | (<>vbWCstop))
	
	$err:=Num:C11(vtEmailMessageLog[[1]])
	
End if 