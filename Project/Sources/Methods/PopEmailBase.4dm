//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/27/13, 00:39:52
// ----------------------------------------------------
// Method: PopEmailBase
// Description
// 
//
// Parameters
// ----------------------------------------------------
// /////////////////////////////////

If (Test path name:C476(Storage:C1525.folder.jitF+"emailmsg:")<0)
	CREATE FOLDER:C475(Storage:C1525.folder.jitF+"emailmsg:")
End if 
If (Test path name:C476(Storage:C1525.folder.jitF+"emailAttachments:")<0)
	CREATE FOLDER:C475(Storage:C1525.folder.jitF+"emailAttachments:")
End if 

C_LONGINT:C283($error; $stripLineFeed)
C_TEXT:C284($hostName; $userName; $password)  //Host Name or IP address of the POP3 mail server; username; password
C_LONGINT:C283($aPOP)  //	0 = Cleartext Login, 1 = APOP Login
C_LONGINT:C283($pop3_ID)  //	Reference to this POP3 login
$hostName:="pop.secureserver.net"
$userName:="bill@jpods.com"
$password:="46tlmn"
$aPOP:=0
$error:=POP3_Login($hostName; $userName; $password; $aPOP; $pop3_ID)



C_TEXT:C284($msgFolder; $attachFolder)
$stripLineFeed:=1
$msgFolder:=Storage:C1525.folder.jitF+"emailmsg:"
$attachFolder:=Storage:C1525.folder.jitF+"emailAttachments:"
$error:=POP3_SetPrefs($stripLineFeed; $msgFolder; $attachFolder)

C_TEXT:C284(msgFolder; attachFolder)
//$stripLineFeed:=1
//$msgFolder:=Storage.folder.jitF+"emailmsg:"
//$attachFolder:=Storage.folder.jitF+"emailAttachments:"
$error:=POP3_GetPrefs($stripLineFeed; msgFolder; attachFolder)



C_LONGINT:C283($pop3_ID; $msgCount; $msgSize)
$error:=POP3_BoxInfo($pop3_ID; $msgCount; $msgSize)

If ($msgCount>0)
	C_LONGINT:C283($myStartCount)
	$myStartCount:=1
	$msgCount:=3
	PopListMessageDetails($pop3_ID; $myStartCount; $msgCount)
	
	PopMessageListInfo($pop3_ID; $myStartCount; $msgCount)
	
	$msgNumber:=0
	
	PopMessageInfo($pop3_ID; $msgNumber)
	
	PopDownLoadMessage($pop3_ID; $msgNumber)
	
	$startMsg:=0
	$endMsg:=0
	PopDeleteMessage($pop3_ID; $startMsg; $endMsg)
	
End if 

$error:=POP3_Logout($pop3_ID)


// /////////////////////////////////



If (False:C215)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	C_LONGINT:C283($pop3_ID; $msgNumber)
	C_LONGINT:C283($headerOnly)
	C_TEXT:C284($fileName)
	
	$error:=POP3_Download($pop3_ID; $msgNumber; $headerOnly; $fileName)
	
	
	
	$error:=POP3_BoxInfo(pop3_ID; msgCount; msgSize)
	
	
	// /////////////////////////////////
	C_LONGINT:C283($pop3_ID)
	$error:=POP3_VerifyID($pop3_ID)
	
	
	
	
	$Err:=MSG_Charset(1; 1)
	$Err:=MSG_FindHeader($msgfile; "From"; $from)
	$Err:=MSG_FindHeader($msgfile; "To"; $to)
	$Err:=MSG_FindHeader($msgfile; "Cc"; $cc)
	$Err:=MSG_FindHeader($msgfile; "Subject"; $subject)
	
	$Err:=MSG_MessageSize($msgfile; $HdrSize; $BdySize; $MsgSize)
	$Err:=MSG_GetBody($msgfile; 0; $BdySize; $BodyContent)
	
	
	
	
End if 






