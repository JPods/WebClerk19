//%attributes = {}
//    // ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/09/09, 08:59:51
// ----------------------------------------------------
// Method: Mail_Manage
// Description
// 
//

//  http://doc.4d.com/4Dv16R3/4D-Internet-Commands/16-R3/IMAP-CloseCurrentMB.301-3334442.en.html
ARRAY TEXT:C222($mbNamesArray; 0)
ARRAY TEXT:C222($mbAttribsArray; 0)
ARRAY TEXT:C222($mbHierarArray; 0)
ARRAY TEXT:C222($msgHeaderArray; 0)
ARRAY TEXT:C222($msgIdArray; 0)
ARRAY TEXT:C222($msgValueArray; 0)
ARRAY TEXT:C222($msgFlagsArray; 0)
ARRAY TEXT:C222($msgNumArray; 0)
ARRAY LONGINT:C221($msgSizeArray; 0)
ARRAY TEXT:C222($msgNumArray; 0)

C_LONGINT:C283($error)
C_LONGINT:C283($vImap_ID; $vSessionParam)
C_TEXT:C284($vCapability; $vHost; $vUserName; $vUserPassword)
$vHost:="imap.gmail.com"
$vUserName:="[hidden email]"
$vUserPassword:="pass"
$error:=IT_SetPort(14; 993)
$vSessionParam:=1
$error:=IMAP_Login($vHost; $vUserName; $vUserPassword; $vImap_ID; $vSessionParam)
If ($error=0)
	C_TEXT:C284($vCapability)
	$error:=IMAP_Capability($vImap_ID; $vCapability)
	// IMAP commands using $vImap_ID parameter 
	
	$error:=IMAP_ListMBs($imap_ID; $mbRefName; $mbName; $mbNamesArray; $mbAttribsArray; $mbHierarArray; $subscribedMB)
	//  imap_ID LongintinReference to an IMAP login
	//  mbRefName TextinNull string or Mailbox name or level of mailbox hierarchy
	//  mbName TextinNull string or MailBoxName or wildcards
	//  mbNamesArray String arrayinArray of mailbox names (pathnames)
	//  mbAttribsArray String arrayinArray of mailbox attributes
	//  mbHierarArray String arrayinArray of hierarchy delimiters
	//  subscribedMB Integerin0 = List all available user mailboxes 1 = List only subscribed mailboxes
	//  Function result IntegerinError code
	
	//  Mailbox attributes
	//  There are four mailbox attributes defined as follows:
	//  \Noinferiors: no child levels currently exist and none can be created.
	//  \Noselect: this name cannot be used as a selectable mailbox.
	//  \Marked: the server has marked the mailbox as “interesting”; the mailbox probably contains messages added since the last selection.
	//  \Unmarked: the mailbox does not contain any additional messages since the last selection.
	
	$error:=IMAP_GetMBStatus($imap_ID; $mbName; $msgNber; $newMsgNber; $unseenMsgNber; $mbUID)
	//  imap_ID LongintinReference to an IMAP login
	//  mbName TextinName of the mailbox
	//  msgNber LongintinNumber of messages in the specified mailbox
	//  newMsgNber LongintinNumber of messages with the \Recent flag set
	//  unseenMsgNber LongintinNumber of messages with no \Seen flag
	//  mbUID LongintinSpecified mailbox unique identifier
	//  Function result IntegerinError code
	
	C_TEXT:C284($mailboxName; $flagsCustom; $flagsPermanent)
	C_LONGINT:C283($numMsg; $numMsgNew; $uidMailbox)
	$error:=IMAP_SetCurrentMB($vImap_ID; $mailboxName; $numMsg; $numMsgNew; $flagsCustom; $flagsPermanent; $uidMailbox)
	//The IMAP_SetCurrentMB command allows you to open a session (i.e. selects the current working Mailbox) 
	// in order to manage the messages of the specified mailbox.
	
	//  Note that the permanentFlags string can also include the
	//  special flag \*, which means that keywords can be created by trying to 
	// store those flags in the mailbox (see IMAP_SetFlags).
	
	//  IMAP_CloseCurrentMB
	//  IMAP_GetFlags
	//  IMAP_GetMBStatus
	//  IMAP_ListMBs
	//  IMAP_Logout
	//  IMAP_SetFlags
	
	
	
	
	$error:=IMAP_GetFlags($imap_ID; $startMsg; $endMsg; $msgFlagsArray; $msgNumArray)
	//  imap_ID LongintinReference to an IMAP login
	//  startMsg Longintin  Start message number
	//  endMsg LongintinEnd message number
	//  msgFlagsArray String arrayinFlag values for each message
	//  msgNumArray Longint arrayinArray of message numbers
	//  Function result IntegerinError code
	
	$error:=IMAP_SetFlags($imap_ID; $startMsg; $endMsg; $msgFlagsList; $deleteOption)
	//  imap_ID LongintinReference to an IMAP login
	//  startMsg LongintinStart message number
	//  endMsg LongintinEnd message number
	//  msgFlagsList StringinFlag values to add or remove
	//  deleteOption Integerin1 = add flag value, 0 = remove flag value
	//  Function result IntegerinError code
	
	//  Seen: Message has been read.
	//  Answered: Message has been answered.
	//  Flagged: Message is “flagged” for urgent/special attention.
	//  Deleted: Message is “deleted” for later removal with IMAP_Delete, IMAP_CloseCurrentMB, IMAP_SetCurrentMB or IMAP_Logout.
	//  Draft: Message is in draft format; in other words, not complete.
	//  Recent: Message “recently” arrived in this mailbox. This session is the first session 
	//    notified about this message; subsequent sessions will not see the \Recent flag 
	//    set for this message. This permanent flag is managed by the IMAP server and 
	//    cannot be modified by an IMAP client using IMAP_SetFlags, for instance
	
	$error:=IMAP_GetMBStatus($imap_ID; $mbName; $msgNber; $newMsgNber; $unseenMsgNber; $mbUID)
	//  IMAP_GetFlags
	//  IMAP_ListMBs
	//  IMAP_SetCurrentMB
	//  IMAP_SetFlags
	
	
	$error:=IMAP_MsgLst($imap_ID; $startMsg; $endMsg; $msgHeaderArray; $msgNumArray; $msgIdArray; $msgValueArray)
	
	//  imap_ID LongintinReference to an IMAP login
	//  startMsg LongintinStart message number
	//  endMsg LongintinEnd message number
	//  msgHeaderArray String arrayinArray of headers to retrieve
	//  msgNumArray Longint arrayinArray of message numbers
	//  msgIdArray Longint arrayinArray of Unique Msg IDs
	//  msgValueArray 2D String array, 2D Text arrayin2D Array of header values
	//  Function result IntegerinError code
	
	$error:=IMAP_MsgLstInfo($imap_ID; $startMsg; $endMsg; $msgSizeArray; $msgNumArray; $msgIdArray)
	//  imap_ID LongintinReference to an IMAP login
	//  startMsg LongintinStart message number
	//  endMsg LongintinEnd message number
	//  msgSizeArray Longint arrayinArray of sizes
	//  msgNumArray Longint arrayinArray of message numbers
	//  msgIdArray Longint arrayinArray of Unique Msg IDs
	//  Function result IntegerinError code
	
	$error:=IMAP_MsgFetch($imap_ID; $msgNum; $msgDataItem; $msgDataItemValue)
	//  imap_ID LongintinReference to an IMAP login
	//  msgNum LongintinMessage number
	//  msgDataItem TextinData item(s) to retrieve
	//  msgDataItemValue TextinData item(s) value
	//  Function result IntegerinError code
	
	$error:=IMAP_GetMessage($imap_ID; $msgNum; $offset; $length; $msgPart; $msgText; $updateSeen)
	//  imap_ID LongintinReference to an IMAP login
	//  msgNum LongintinMessage number
	//  offset LongintinOffset of character at which to begin retrieval
	//  length LongintinHow many characters to return
	//  msgPart Integerin0 = Entire message, 1 = Only header, 2= Only Body
	//  msgText TextinMessage Text
	//  updateSeen Integerin0 = Update \Seen Flag; 1 = Do not update
	//  Function result IntegerinError code
	
	
	$error:=IMAP_Download($imap_ID; $msgNum; $headerOnly; $fileName; $updateSeen)
	//  imap_ID LongintinReference to an IMAP login
	//  msgNum LongintinMessage number
	//  headerOnly Integerin0 = Entire message, 1 = Only header
	//  fileName TextinLocal Filename
	//  inResulting Local Filename
	//  updateSeen Integerin0 = Add \Seen Flag; 1= Do not add \Seen Flag
	//  Function result IntegerinError code
	
	
	
	
	
	
	
	$error:=IMAP_CloseCurrentMB($vImap_ID)
	
	
End if 
$error:=IMAP_Logout($vImap_ID)
CLEAR VARIABLE:C89($vUserPassword)
TRACE:C157


