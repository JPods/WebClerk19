//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/27/20, 23:43:06
// ----------------------------------------------------
// Method: email_DraftVariables
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($returnText)
$returnText:="SMTP_SendMsg is the command that sends an email."+"\r"+"\r"

$returnText:=$returnText+"vtEmailServer: address of the mail server"+"\r"
$returnText:=$returnText+"viEmailport: port on the mail server"+"\r"
$returnText:=$returnText+"vtEmailSender: email address of the sender"+"\r"
$returnText:=$returnText+"vtEmailReceiver: email address of the receiver."+"\r"
$returnText:=$returnText+"vtEmailSubject: subject of the email.  It can contail _jit_tags."+"\r"
$returnText:=$returnText+"vtEmailBody: body of the email. It can contail _jit_tags."+"\r"
$returnText:=$returnText+"vtEmailAttachment: path to an attached document."+"\r"
$returnText:=$returnText+"atEmailAttachments: array of paths to attached documents."+"\r"
$returnText:=$returnText+"atEmailCC: array of email address to send copies to."+"\r"
$returnText:=$returnText+"atEmailBCC: array of email address to send blind copies to."+"\r"
$returnText:=$returnText+"vtEmailUserName: sender's username on the mail server."+"\r"
$returnText:=$returnText+"vtEmailPassword: sender's password on the mail server."+"\r"
vTextSummary:=$returnText+"\r"+"\r"+vTextSummary