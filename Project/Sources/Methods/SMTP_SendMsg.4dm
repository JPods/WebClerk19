//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/04/18, 16:30:58
// ----------------------------------------------------
// Method: SMTP_SendMsg
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($p; vlLogRequirement)
//
C_LONGINT:C283(viEmailport; $serverSocket; $err)
C_TEXT:C284(vtEmailServer; vtEmailMessage; vtEmailMessageLog; vtEmailUserName; vtEmailPassword)  //employee record
//
C_TEXT:C284(vtEmailSender; vtEmailSubject; vtEmailBody; vtEmailPath; vtEmailReceiver; vtEmailReceiver_Tag)
//
C_TEXT:C284($theName)
C_BOOLEAN:C305(<>vbWCstop; $doTestOnly; $2)
C_LONGINT:C283(vbAccumulateMessage)
$doTestOnly:=False:C215
// ### bj ### 20191210_1013 declaration
C_POINTER:C301($ptCurTable)
If (Count parameters:C259>0)
	$ptCurTable:=$1
	If (Count parameters:C259>1)
		$doTestOnly:=$2
	End if 
Else 
	$ptCurTable:=ptCurTable
End if 
vtEmailMessageLog:=""
vtEmailMessage:=""
If (<>viDebugMode>0)
	C_TEXT:C284(webLog)
	webLog:="<webLog_Email>"+"\r"
Else 
	//If (<>webEngine=0) // #### AZM #### 20171013_1409 - This was never used.
	//SendMessage (1;String(Current time)+" HTTP "+String(Current process;"00#")+" - "+vText7+", Hit:  "+String([EventLog]HitsTotal)+"\r")
	//
	//Else 
	//  //build a message sending procedure
	//End if 
	
End if 
$p:=Position:C15("mailto:"; vtEmailSender)
If ($p>0)
	vtEmailSender:=Substring:C12(vtEmailSender; $p+7)
End if 
$p:=Position:C15("mailto:"; vtEmailReceiver)
If ($p>0)
	vtEmailReceiver:=Substring:C12(vtEmailReceiver; $p+7)
End if 
$doHtml:=False:C215
$mimeType:=""
Case of 
	: (vtEmailPath="")
	: ((Substring:C12(vtEmailPath; Length:C16(vtEmailPath)-4)=".html") | (Substring:C12(vtEmailPath; Length:C16(vtEmailPath)-3)=".htm"))  //complete this later//((vtEmailPath="http://@") |
		//vtEmailPath:=Substring($6;8)
		If (HFS_Exists(vtEmailPath)=0)
			vtEmailPath:=""  //bypass attachment
		Else 
			vtEmailPath:=vtEmailPath
			$doHtml:=True:C214
		End if 
	Else 
		If (HFS_Exists(vtEmailPath)=1)
			vtEmailPath:=vtEmailPath
		End if 
End case 
//
vtEmailMessageLog:=""
vtEmailMessageLog:=vtEmailMessageLog+" vtEmailReceiver: "+vtEmailReceiver
If (False:C215)  //  <>viDeBugMode>0
	ConsoleLog("SMTP_SendMsg"+"\r"+"vtEmailReceiver: "+vtEmailReceiver)
End if 
vtEmailMessageLog:=vtEmailMessageLog+" vtEmailSender: "+vtEmailSender+"\r"
If (False:C215)  //  <>viDeBugMode>0
	ConsoleLog("vtEmailSender: "+vtEmailSender)
End if 
vtEmailMessageLog:=vtEmailMessageLog+" vtEmailSubject: "+vtEmailSubject+"\r"
If (False:C215)  //  <>viDeBugMode>0
	ConsoleLog("vtEmailSubject: "+vtEmailSubject)
End if 
vtEmailMessageLog:=vtEmailMessageLog+" vtEmailServer: "+vtEmailServer+"\r"
If (False:C215)  //  <>viDeBugMode>0
	ConsoleLog("vtEmailServer: "+vtEmailServer)
End if 
vtEmailMessageLog:=vtEmailMessageLog+" viEmailport: "+String:C10(viEmailport)+"\r"
If (False:C215)  //  <>viDeBugMode>0
	ConsoleLog("viEmailport: "+String:C10(viEmailport))
End if 
vtEmailMessageLog:=vtEmailMessageLog+" vtEmailUserName: "+vtEmailUserName+"\r"
If (False:C215)  //  <>viDeBugMode>0
	ConsoleLog("vtEmailUserName: "+vtEmailUserName)
End if 
vtEmailMessageLog:=vtEmailMessageLog+" vtEmailPassword: "+vtEmailPassword+"\r"
If (False:C215)  //  <>viDeBugMode>0
	ConsoleLog("vtEmailPassword: "+Substring:C12(vtEmailPassword; 1; 3))
End if 

vtEmailMessageLog:=vtEmailMessageLog+" vtEmailPath: "+vtEmailPath+"\r"
If (False:C215)  //  <>viDeBugMode>0
	ConsoleLog("vtEmailPath: "+vtEmailPath)
End if 
vtEmailReceiver:=vtEmailReceiver
vtEmailStatusMessage:="no receiver/server/sender"
If ((Position:C15(Char:C90(64); vtEmailReceiver)>0) & (Position:C15(Char:C90(64); vtEmailSender)>0) & (vtEmailServer#""))
	C_LONGINT:C283($serverSocket; $cntMailWait)
	If (<>vlWebTimeOutDelay=0)
		<>vlWebTimeOutDelay:=10
	End if 
	$cntMailWait:=0
	C_TEXT:C284($options)
	
	HTTP_TimeOut:=Milliseconds:C459+2000
	$options:="connect-timeout="+String:C10(HTTP_TimeOut)
	//If (HTTP_Protocol="https")
	//$options:=$options+" ssl=true"
	//End if 
	
	SMTP_SendMsg4D($doTestOnly)
	
	
	
	//Ref:  SMTP_SendMsg4D ($doTestOnly)
	//Ref:  SMTPVerifyWithAnE
	//Ref: SMTP_SendMailByTCP
	
End if 

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


// ### bj ### 20191210_1021  Declaration interpreted
C_BOOLEAN:C305(allowAlerts_boo)
If ((vHere>1) & (allowAlerts_boo) & (<>showEmailDialog=1))
	// GUI_TextEditDia (->vtEmailReport;"email details")
End if 

If (False:C215)
	KeyModifierCurrent
	If (CapKey=1)
		SET TEXT TO PASTEBOARD:C523(vtEmailMessageLog)
	End if 
End if 
vtEmailMessageLog:=""
vtEmailServer:=""
viEmailport:=0
vtEmailUserName:=""
vtEmailPassword:=""
vtEmailAttachment:=""
vtEmailSender:=""
vtEmailReplyTo:=""
vtEmailReceiver:=""
vtEmailSubject:=""
vtEmailBody:=""
vtEmailPath:=""
ARRAY TEXT:C222(atEmailCC; 0)
ARRAY TEXT:C222(atEmailBCC; 0)
ARRAY TEXT:C222(atEmailAttachments; 0)


