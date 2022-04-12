//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 130216, 18:25:41
// ----------------------------------------------------
// Method: SMTP_SendMsg4D
// Description
// 
//
// Parameters
// ----------------------------------------------------

// Modified by: Bill James (2016-08-11T00:00:00) Added Console


//improved error reporting, use veriable <>viDebugMode > 0 to record
// ### jwm ### 20141203_1201 change GroupID of EventLog based on Error Code

// Method: SMTP_SendMsg4D
// Description
//$errCode:=SMTP_SetPrefs (lineFeed; bodyType; lineLength) 
//$errCode:=SMTP_GetPrefs (lineFeeds;bodyType;lineLength)
//
//$myMailID:=SMTP_QuickSend (vtEmailServer;vtEmailSender;vtEmailReceiver;vtEmailSubject;vtEmailBody)
//$errCode:=SMTP_Host ($myMailID; vtEmailServer{; deleteOption})
//$errCode:=SMTP_Send ($myMailID)
//$errCode:=SMTP_Clear ($myMailID)
//$errCode:=SMTP_Date ($myMailID; msgDate; msgTime; timeZone; offset{; deleteOption})
//$errCode:=SMTP_From ($myMailID; msgFrom{; deleteOption})
//$errCode:=SMTP_Sender ($myMailID; msgSender{; deleteOption})
//$errCode:=SMTP_ReplyTo ($myMailID; replyTo{; deleteOption})
//$errCode:=SMTP_To ($myMailID; msgTo{; deleteOption})
//$errCode:=SMTP_Cc ($myMailID; carbonCopy{; deleteOption})
//$errCode:=SMTP_Bcc ($myMailID; blindCarbon{; deleteOption})
//$errCode:=SMTP_InReplyTo ($myMailID; inReplyTo{; deleteOption})
//$errCode:=SMTP_References ($myMailID; references{; deleteOption})
//$errCode:=SMTP_Comments ($myMailID; comments{; deleteOption})
//$errCode:=SMTP_Keywords ($myMailID; keywords{; deleteOption})
//SMTP_Encrypted ($myMailID; encrypted{; deleteOption})
//$errCode:=SMTP_AddHeader ($myMailID; headerName; headerText{; deleteOption})
//$errCode:=SMTP_Subject ($myMailID; subject{; deleteOption})
//$errCode:=SMTP_Body ($myMailID; msgBody{; deleteOption})
//$errCode:=SMTP_Attachment ($myMailID; fileName; encodeType{; deleteOption})
//$errCode:=SMTP_Auth ($myMailID; userName; password{; authMode}) 
//
//$errCode:=SMTP_Charset (encodeHeaders; bodyCharset)

// Parameters
//instructions: If <>viDebugMode > 0 and eventLogs record will document the email.
// ----------------------------------------------------
C_LONGINT:C283($myMailID; $errCode; $myMailPref; $incRay; $sizeRay; $currentPort; returnEmailAction)
C_BOOLEAN:C305($1; $testOnly)
C_TEXT:C284(vtEmailAttachment)

// Modified by: Bill James (2016-01-23T00:00:00 Subrecord eliminated)
C_LONGINT:C283(<>emailEncode)
If (<>emailEncode=0)
	<>emailEncode:=2
End if 
<>emailEncode:=2  // 1 = binhex, 2 = base 64, 7 = UUEncode
If (<>viDeBugMode>0)
	ConsoleMessage("\r"+"\r"+"SMPT_SendMsg"+"\r"+"<>emailEncode: "+String:C10(<>emailEncode))
End if 
C_TEXT:C284(vtEmailReport; $listText)
C_BOOLEAN:C305($reportEmail)
vtEmailReport:=""
$reportEmail:=False:C215
// If ((<>viDebugMode>0) | (returnEmailAction>0))
// $reportEmail:=True
// End if 

$testOnly:=False:C215
If (Count parameters:C259=1)  //verification of emails must be re-written 20091207
	$testOnly:=$1
End if 
vResponse:="email failed to "+vtEmailReceiver+" from "+vtEmailSender
$errCode:=IT_GetPort(2; $currentPort)  //capture status of current port
If (<>viDeBugMode>0)
	ConsoleMessage("IT_GetPort: "+String:C10(viEmailport)+": "+String:C10($errCode))
End if 
$errCode:=IT_SetPort(2; viEmailport)  //set to email port // Port must be 587 for MS Exchange server // ### jwm ### 20140910_1547
If (<>viDeBugMode>0)
	ConsoleMessage("IT_SetPort: "+String:C10(viEmailport)+": "+String:C10($errCode))
End if 
//
$myMailPref:=2  //force the use of full SMTP process
Case of 
	: ($myMailPref=1)
		$myMailID:=SMTP_QuickSend(vtEmailServer; vtEmailSender; vtEmailReceiver; vtEmailSubject; vtEmailBody)
	: ($myMailPref=2)
		$errCode:=SMTP_New($myMailID)
		If (<>viDeBugMode>0)
			ConsoleMessage("MailID: "+String:C10($myMailID)+": Err: "+String:C10($errCode))
		End if 
		If ($errCode=0)
			$errCode:=SMTP_Host($myMailID; vtEmailServer)
			If (<>viDeBugMode>0)
				ConsoleMessage("vtEmailServer: "+vtEmailServer+": Err: "+String:C10($errCode))
			End if 
			If ($errCode=0)
				$errCode:=SMTP_From($myMailID; vtEmailSender)
				If (<>viDeBugMode>0)
					ConsoleMessage("vtEmailSender: "+vtEmailSender+": Err: "+String:C10($errCode))
				End if 
				If ($errCode=0)
					$errCode:=SMTP_Subject($myMailID; vtEmailSubject)
					If (<>viDeBugMode>0)
						ConsoleMessage("vtEmailSubject: "+vtEmailSubject+": Err: "+String:C10($errCode))
					End if 
					If ($errCode=0)
						$errCode:=SMTP_To($myMailID; vtEmailReceiver)
						If (<>viDeBugMode>0)
							ConsoleMessage("vtEmailReceiver: "+vtEmailReceiver+": Err: "+String:C10($errCode))
						End if 
						If ($errCode=0)  // ### jwm ### 20140911_0902 add ReplyTo email address
							If (vtEmailReplyTo="")
								vtEmailReplyTo:=vtEmailSender
							End if 
							$errCode:=SMTP_ReplyTo($myMailID; vtEmailReplyTo)
							If (<>viDeBugMode>0)
								ConsoleMessage("vtEmailReplyTo: "+vtEmailReplyTo+": Err: "+String:C10($errCode))
							End if 
							If ($errCode=0)  //###_jwm_### 20110110
								If (vtEmailAttachment#"")
									// IT_Encode can be used to encode each file if this is used, send the negative value so the header are properly set
									// Negative encoder values only set the headers and do not perform any encoding function. 
									$errCode:=SMTP_Attachment($myMailID; vtEmailAttachment; <>emailEncode)  // 1 = binhex, 2 = base 64, 7 = UUEncode
									If (<>viDeBugMode>0)
										ConsoleMessage("vtEmailAttachment: "+vtEmailAttachment+": Err: "+String:C10($errCode))
									End if 
								Else 
									$sizeRay:=Size of array:C274(atEmailAttachments)
									If ($sizeRay>0)
										$listText:=""
										For ($incRay; 1; $sizeRay)
											// IT_Encode can be used to encode each file if this is used, send the negative value so the header are properly set
											// Negative encoder values only set the headers and do not perform any encoding function. 
											$errCode:=SMTP_Attachment($myMailID; atEmailAttachments{$incRay}; <>emailEncode)  // 1 binhex 2 base 64, 7 = UUEncode
											$listText:=$listText+atEmailAttachments{$incRay}+", "
										End for 
										If (<>viDeBugMode>0)
											ConsoleMessage("attachments: "+$listText+": Err: "+String:C10($errCode))
										End if 
									End if 
								End if 
								If ($errCode=0)
									$sizeRay:=Size of array:C274(atEmailCC)
									$listText:=""
									For ($incRay; 1; $sizeRay)
										$errCode:=SMTP_Cc($myMailID; atEmailCC{$incRay}; 0)
										$listText:=$listText+atEmailCC{$incRay}+", "
									End for 
									If (<>viDeBugMode>0)
										ConsoleMessage("atEmailCC: "+$listText+": Err: "+String:C10($errCode))
									End if 
									If ($errCode=0)
										$sizeRay:=Size of array:C274(atEmailBCC)
										$listText:=""
										For ($incRay; 1; $sizeRay)
											$errCode:=SMTP_Bcc($myMailID; atEmailBCC{$incRay}; 0)
											$listText:=$listText+atEmailBCC{$incRay}+", "
										End for 
										If (<>viDeBugMode>0)
											ConsoleMessage("atEmailBCC: "+$listText+": Err: "+String:C10($errCode))
										End if 
										If ($errCode=0)
											If (Position:C15("<html"; vtEmailBody)>0)
												$errCode:=SMTP_AddHeader($myMailID; "Content-Type:"; "text/html;charset=us-ascii"; 1)
												If (<>viDeBugMode>0)
													ConsoleMessage("SMTP_AddHeader: Content-Type: "+"text/html;charset=us-ascii"+": Err: "+String:C10($errCode)+"\r")
												End if 
											End if 
											If ($errCode=0)
												$errCode:=SMTP_Body($myMailID; vtEmailBody)
												If (<>viDeBugMode>0)
													ConsoleMessage("Body: (20)"+": Err: "+String:C10($errCode)+": "+Substring:C12(vtEmailBody; 1; 20))
												End if 
												If ($errCode=0)
													If ((vtEmailUserName="skip") | (vtEmailPassword="skip"))
														If (<>viDeBugMode>0)
															ConsoleMessage("Authorized: "+": Skip used to skip requirement for authenication")
														End if 
													Else 
														$errCode:=SMTP_Auth($myMailID; vtEmailUserName; vtEmailPassword)
														If (<>viDeBugMode>0)
															ConsoleMessage("Authorized: "+": Err: "+String:C10($errCode)+": vtEmailUserName="+vtEmailUserName+": password="+Substring:C12(vtEmailPassword; 1; 3))
														End if 
													End if 
													If (($errCode=0) & (Not:C34($testOnly)))
														// Modified by: Bill James (2015-02-17T00:00:00 Better error reporting and added SSL, auto detect was not working)
														$errCode:=SMTP_Send($myMailID; viEmailSSL)  // 0 = Zero Send in 'upgradable' mode auto detect SSL/TLS // ### jwm ### 20140910_1546
														If ($errCode=0)  // ### bj ### 20181211_1900 support web notification
															vResponse:="email successfully sent to "+vtEmailReceiver+" from "+vtEmailSender
															ConsoleMessage(vResponse)
														Else 
															ConsoleMessage("Email Error Code: "+vResponse)
														End if 
														If ((<>viDeBugMode>0) | ($errCode#0))  // ### jwm ### 20170606_1032
															ConsoleMessage("Send: "+"; Err: "+String:C10($errCode)+(Num:C11($errCode=10113)*": AUTHENTICATION ERROR"))
														End if 
													End if 
												End if 
											End if 
										End if 
									End if 
								End if 
							End if 
							
						End if   //###_jwm_### 20110110
					End if 
				End if 
			End if 
		End if 
		Case of 
			: (($errCode=0) & ($testOnly))
				vtEmailStatusMessage:="verified"
				vResponse:=vResponse+"\r"+"verified"
			: ($errCode=0)  //successful sending of email
				vtEmailStatusMessage:="sent"
			Else 
				vtEmailStatusMessage:=String:C10($errCode)+": "+String:C10($myMailID)+(Num:C11($errCode=10113)*": AUTHENTICATION ERROR")
				vResponse:=vResponse+"\r"+vtEmailStatusMessage
		End case 
		If (<>viDeBugMode>0)
			ConsoleMessage(vtEmailStatusMessage)
		End if 
		If (False:C215)  // $reportEmail)
			vtEmailReport:=vtEmailReport
			CREATE RECORD:C68([EventLog:75])
			[EventLog:75]company:46:=vtEmailReceiver
			// ### jwm ### 20141203_1201 change GroupID of EventLog based on Error Code
			If ($errCode=0)
				[EventLog:75]groupid:3:="Sent Email"
			Else 
				[EventLog:75]groupid:3:="Failed Email"
			End if 
			[EventLog:75]dtEvent:1:=DateTime_Enter
			EventLogsMessage(vtEmailReport)
			[EventLog:75]status:48:=vtEmailStatusMessage
			
			If ([EventLog:75]idNum:5#0)
				SAVE RECORD:C53([EventLog:75])
			End if 
		End if 
		$errCode:=SMTP_Clear($myMailID)
		If (<>viDeBugMode>0)
			ConsoleMessage("Clear port: "+": Err: "+String:C10($errCode))
		End if 
End case 



$errCode:=IT_SetPort(2; $currentPort)  //reset to current port

