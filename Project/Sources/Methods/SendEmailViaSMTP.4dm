//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 04/23/19, 13:15:10
// ----------------------------------------------------
// Method: SendEmailViaSMTP
// Description
// 
//
// Parameters
// ----------------------------------------------------


// SendEmailViaSMTP($voEmail)
// SendEmailViaSMTP($voEmail;$voSMTPServer)

// $voMessage = {
//   "to" : "",             // STRING; ONE OR MORE EMAIL ADDRESSES, COMMA-DELIMITED
//   "cc" : "",             // STRING; ONE OR MORE EMAIL ADDRESSES, COMMA-DELIMITED
//   "bcc" : "",            // STRING; ONE OR MORE EMAIL ADDRESSES, COMMA-DELIMITED
//   "replyTo" : "",        // STRING; ONE EMAIL ADDRESS
//   "subject" : "",        // STRING; THE SUBJECT OF THE EMAIL BEING SENT
//   "body" : "",           // STRING; THE BODY OF THE EMAIL BEING SENT
//   "attachments" : ""     // ARRAY; ONE OR MORE ATTACHMENTS BEING SENT WITH THE EMAIL
// }

// $voSMTPServer = {
//   "from" : "",           // STRING; ONE EMAIL ADDRESS
//   "host" : "",           // STRING; THE HOST OF THE SMPT SERVER
//   "port" : "",           // LONGINT; THE PORT TO USE FOR THE SMPT SERVER
//   "username" : "",       // STRING; THE USERNAME OF THE SMTP ACCOUNT
//   "password" : ""        // STRING; THE PASSWORD OF THE SMTP ACCOUNT
// }

// ******************************************* //
// ****** TYPE AND INITIALIZE PARAMETERS ***** //
// ******************************************* //

// INIT HELPER VARIABLES

ARRAY LONGINT:C221($aiErrorCodes; 0)
ARRAY TEXT:C222($atErrorMessages; 0)

C_BOOLEAN:C305($0; $vbSucceeded)
$vbSucceeded:=True:C214

C_LONGINT:C283($viErrorCode; $viSMTP_ID; $viOriginalPortNum; $viCounter)
$viErrorCode:=0
$viSMTP_ID:=0
$viOriginalPortNum:=0
$viCounter:=0

// LOAD THE SMTP SERVER INFORMATION, EITHER FROM A PASSED
// PARAMETER OVERRIDE, OR BY LOOKING UP THE EMAIL INFORMATION
// FROM THE EMPLOYEE RECORD WITH nameID = "Email".

C_LONGINT:C283($viServerPort)
C_TEXT:C284($vtServerHost; $vtServerFrom; $vtServerUsername; $vtServerPassword)
If (Count parameters:C259>1)
	C_OBJECT:C1216($2)
	$viServerPort:=OB Get:C1224($2; "port")
	$vtServerHost:=OB Get:C1224($2; "host")
	$vtServerFrom:=OB Get:C1224($2; "from")
	$vtServerUsername:=OB Get:C1224($2; "username")
	$vtServerPassword:=OB Get:C1224($2; "password")
	If (($viServerPort=0) | ($vtServerHost="") | ($vtServerFrom="") | ($vtServerUsername="") | ($vtServerPassword=""))
		APPEND TO ARRAY:C911($aiErrorCodes; 20001)
		APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: A Server Info object was provided as a parameter, but it is missing required information. Please make sure it contains the following: port, host, from, username, and password.")
	End if 
Else 
	QUERY:C277([Employee:19]; [Employee:19]nameid:1="Email")
	If (Records in selection:C76([Employee:19])=1)
		$viServerPort:=[Employee:19]emailPortOut:59
		$vtServerHost:=[Employee:19]emailServerOut:58
		$vtServerFrom:=[Employee:19]email:16
		$vtServerUsername:=[Employee:19]emailUserName:60
		$vtServerPassword:=[Employee:19]emailPassword:61
		If (($viServerPort=0) | ($vtServerHost="") | ($vtServerFrom="") | ($vtServerUsername="") | ($vtServerPassword=""))
			APPEND TO ARRAY:C911($aiErrorCodes; 20002)
			APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: An employee Email record was found, but it is missing required information.")
		End if 
	Else 
		APPEND TO ARRAY:C911($aiErrorCodes; 20003)
		APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: No matching Email employee record found.")
	End if 
	REDUCE SELECTION:C351([Employee:19]; 0)
End if 

// IF NO ERROR, KEEP GOING 



// LOAD THE EMAIL SPECIFIC INFORMATION, FROM SPECIFIED PARAMETERS

C_TEXT:C284($vtEmailTo; $vtEmailCC; $vtEmailBCC; $vtEmailSubject; $vtEmailBody; $vtEmailReplyTo)
ARRAY TEXT:C222($atEmailTo; 0)
ARRAY TEXT:C222($atEmailCC; 0)
ARRAY TEXT:C222($atEmailBCC; 0)
ARRAY TEXT:C222($atAttachments; 0)
C_OBJECT:C1216($1)

$vtEmailTo:=OB Get:C1224($1; "to")
$vtEmailCC:=OB Get:C1224($1; "CC")
$vtEmailBCC:=OB Get:C1224($1; "BCC")
$vtEmailSubject:=OB Get:C1224($1; "subject")
$vtEmailBody:=OB Get:C1224($1; "body")
$vtEmailReplyTo:=OB Get:C1224($1; "replyTo")
If ($vtEmailReplyTo="")
	$vtEmailReplyTo:=$vtServerFrom
End if 

OB GET ARRAY:C1229($1; "attachments"; $atAttachments)

// SPLIT THE TO, CC, and BCC STRINGS INTO ARRAYS

TextToArray($vtEmailTo; ->$atEmailTo; ",")
TextToArray($vtEmailCC; ->$atEmailCC; ",")
TextToArray($vtEmailBCC; ->$atEmailBCC; ",")

If (($vtEmailTo="") | ($vtEmailSubject="") | ($vtEmailBody=""))
	APPEND TO ARRAY:C911($aiErrorCodes; 20004)
	APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: The Email Message object parameter is missing required information. Please make sure it contains at least the following: to, subject, and body.")
End if 

// ******************************************* //
// ************** SEND THE EMAIL ************* //
// ******************************************* //

If (Size of array:C274($aiErrorCodes)=0)
	
	// SAVE THE CURRENT PORT NUMBER SO THAT IT CAN BE RESET AFTER EMAIL SENDING IS FINISHED
	
	$viErrorCode:=IT_GetPort(2; $viOriginalPortNum)
	
	If ($viErrorCode#0)
		APPEND TO ARRAY:C911($aiErrorCodes; $viErrorCode)
		APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: Unable to get the original port.")
	End if 
	
	// OPEN UP A NEW EMAIL PROCESS
	
	$viErrorCode:=SMTP_New($viSMTP_ID)
	
	If ($viErrorCode#0)
		APPEND TO ARRAY:C911($aiErrorCodes; $viErrorCode)
		APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: Unable to begin email process using SMTP_New.")
	End if 
	
	// SET THE REQUIRED SMPT SERVER INFORMATION
	
	$viErrorCode:=IT_SetPort(2; $viServerPort)
	
	If ($viErrorCode#0)
		APPEND TO ARRAY:C911($aiErrorCodes; $viErrorCode)
		APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: Unable to set \"port\" using IT_SetPort.")
	End if 
	
	$viErrorCode:=SMTP_Host($viSMTP_ID; $vtServerHost)
	
	If ($viErrorCode#0)
		APPEND TO ARRAY:C911($aiErrorCodes; $viErrorCode)
		APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: Unable to set \"host\" using SMTP_Host.")
	End if 
	
	$viErrorCode:=SMTP_From($viSMTP_ID; $vtServerFrom)
	
	If ($viErrorCode#0)
		APPEND TO ARRAY:C911($aiErrorCodes; $viErrorCode)
		APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: Unable to set \"from\" using SMTP_From.")
	End if 
	
	$viErrorCode:=SMTP_Auth($viSMTP_ID; $vtServerUsername; $vtServerPassword)
	
	If ($viErrorCode#0)
		APPEND TO ARRAY:C911($aiErrorCodes; $viErrorCode)
		APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: Unable to set \"username\" and \"password\" using SMTP_Auth.")
	End if 
	
	// SET THE REQUIRED EMAIL MESSAGE INFORMATION
	
	$viErrorCode:=SMTP_ReplyTo($viSMTP_ID; $vtEmailReplyTo)
	
	If ($viErrorCode#0)
		APPEND TO ARRAY:C911($aiErrorCodes; $viErrorCode)
		APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: Unable to set \"replyTo\" using SMTP_ReplyTo.")
	End if 
	
	$viErrorCode:=SMTP_Subject($viSMTP_ID; $vtEmailSubject)
	
	If ($viErrorCode#0)
		APPEND TO ARRAY:C911($aiErrorCodes; $viErrorCode)
		APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: Unable to set \"subject\" using SMTP_Subject.")
	End if 
	
	$viErrorCode:=SMTP_Body($viSMTP_ID; $vtEmailBody)
	
	If ($viErrorCode#0)
		APPEND TO ARRAY:C911($aiErrorCodes; $viErrorCode)
		APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: Unable to set \"body\" using SMTP_Body.")
	End if 
	
	For ($viCounter; 1; Size of array:C274($atEmailTo))
		$viErrorCode:=SMTP_To($viSMTP_ID; $atEmailTo{$viCounter})
		If ($viErrorCode#0)
			APPEND TO ARRAY:C911($aiErrorCodes; $viErrorCode)
			APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: Unable to set \"to\" using SMTP_To.")
		End if 
	End for 
	
	// SET THE OPTIONAL EMAIL MESSAGE INFORMATION
	
	For ($viCounter; 1; Size of array:C274($atEmailCC))
		$viErrorCode:=SMTP_Cc($viSMTP_ID; $atEmailCC{$viCounter})
		If ($viErrorCode#0)
			APPEND TO ARRAY:C911($aiErrorCodes; $viErrorCode)
			APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: Unable to set \"cc\" using SMTP_Cc.")
		End if 
	End for 
	For ($viCounter; 1; Size of array:C274($atEmailBCC))
		$viErrorCode:=SMTP_Bcc($viSMTP_ID; $atEmailBCC{$viCounter})
		If ($viErrorCode#0)
			APPEND TO ARRAY:C911($aiErrorCodes; $viErrorCode)
			APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: Unable to set \"bcc\" using SMTP_Bcc.")
		End if 
	End for 
	For ($viCounter; 1; Size of array:C274($atAttachments))
		$viErrorCode:=SMTP_Attachment($viSMTP_ID; $atAttachments{$viCounter}; 2)
		If ($viErrorCode#0)
			APPEND TO ARRAY:C911($aiErrorCodes; $viErrorCode)
			APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: Unable to add attachment \""+$atAttachments{$viCounter}+"\" using SMTP_Attachment.")
		End if 
	End for 
	
	// SET THE CONTENT HEADER
	
	If (Position:C15("<html"; $vtEmailBody)>0)
		$viErrorCode:=SMTP_AddHeader($viSMTP_ID; "Content-Type:"; "text/html; charset=UTF-8"; 1)
	Else 
		$viErrorCode:=SMTP_AddHeader($viSMTP_ID; "Content-Type:"; "text/plain; charset=UTF-8"; 1)
	End if 
	
	If ($viErrorCode#0)
		APPEND TO ARRAY:C911($aiErrorCodes; $viErrorCode)
		APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: Unable to set content header using SMTP_AddHeader.")
	End if 
	
	// SEND THE EMAIL AND CLEAR THE PROCESS
	
	If (Size of array:C274($aiErrorCodes)=0)
		
		$viErrorCode:=SMTP_Send($viSMTP_ID)
		
		If ($viErrorCode#0)
			APPEND TO ARRAY:C911($aiErrorCodes; $viErrorCode)
			APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: Unable to send an email using SMTP_Send.")
		End if 
		
	End if 
	
	$viErrorCode:=SMTP_Clear($viSMTP_ID)
	
	If ($viErrorCode#0)
		APPEND TO ARRAY:C911($aiErrorCodes; $viErrorCode)
		APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: Unable to clear the email process using SMTP_Clear.")
	End if 
	
	// RESET THE CURRENT PORT TO WHAT IT WAS ORIGINALLY
	
	$viErrorCode:=IT_SetPort(2; $viOriginalPortNum)
	
	If ($viErrorCode#0)
		APPEND TO ARRAY:C911($aiErrorCodes; $viErrorCode)
		APPEND TO ARRAY:C911($atErrorMessages; "SMTP Error: Unable to reset the port using IT_SetPort.")
	End if 
	
End if 

If (Size of array:C274($aiErrorCodes)#0)
	$vbSucceeded:=False:C215
	For ($viCounter; 1; Size of array:C274($aiErrorCodes))
		ConsoleMessage($atErrorMessages{$viCounter}+" | Code: "+String:C10($aiErrorCodes{$viCounter}))
	End for 
End if 

// RETURN A BOOLEAN SHOWING IF THE EMAIL WAS SUCCESSFULLY SENT

$0:=$vbSucceeded

