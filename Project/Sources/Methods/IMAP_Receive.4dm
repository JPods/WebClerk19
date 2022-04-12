//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 10/31/18, 16:19:49
// ----------------------------------------------------
// Method: IMAP_Receive
// Description
// IMAP_Receive($vtUserName;$vtUserPassword;$vtHost;$viPort)
//
// Parameters
// $1 = $vtUserName
// $2 = $vtUserPassword
// $3 = $vtHost
// $4 = $viPort
// ----------------------------------------------------

//<declarations>
//==================================
//  Type variables 
//==================================

// Folder separator;Storage.folder.jitF;$aiMsgID;$aiMsgNum;$aiMsgSize;$atEnclosureList;$atMBAttribs
// $atMBHierarchy;$atMBNames;$atMsgFlags;$atMsgHeader;$atMsgValue;$endMsg;$flagsCustom
// $flagsPermanent;$numMsg;$numMsgNew;$startMsg;values;variable
C_LONGINT:C283($vi1; $vi2; $viAttachments; $viBodySize; $viDecode; $viDuplicate; $viError; $viFolder)
C_LONGINT:C283($viHeaderOnly; $viHeaderSize; $viImap_ID; $viMBID; $viMsgCount; $viMsgCountNew; $viMsgCountUnseen)
C_LONGINT:C283($viMsgFlags; $viMsgID; $viMsgNum; $viMsgNumFlags; $viMsgPart; $viMsgSize; $viNumChars; $viOffset)
C_LONGINT:C283($viPathLength; $viPort; $viProgressID; $viProtocal; $viSessionParam; $viSOA1; $viSubscribedMB)
C_LONGINT:C283($viUpdateSeen; $viRead)
C_TEXT:C284($vtAttachmentPath; $vtAttacment; $vtBodyText; $vtCapability; $vtEmailID; $vtError)
C_TEXT:C284($vtFileName; $vtHeaderText; $vtHeaderValue; $vtHost; $vtMBName; $vtMBRefName; $vtMsgText; $vtPath)
C_TEXT:C284($vtUseerFolder; $vtUserFolder; $vtUserName; $vtUserPassword)

//==================================
//  Initialize variables 
//==================================

$vi1:=0
$vi2:=0
$viAttachments:=0
$viBodySize:=0
$viDecode:=0
$viDuplicate:=0
$viError:=0
$viFolder:=0
$viHeaderOnly:=0
$viHeaderSize:=0
$viImap_ID:=0
$viMBID:=0
$viMsgCount:=0
$viMsgCountNew:=0
$viMsgCountUnseen:=0
$viMsgPart:=0
$viMsgSize:=0
$viOffset:=0
$viPathLength:=0
$viSessionParam:=0
$viSubscribedMB:=0
$viUpdateSeen:=0
$vtAttachmentPath:=""
$vtAttacment:=""
$vtBodyText:=""
$vtCapability:=""
$vtEmailID:=""
$vtFileName:=""
$vtHeaderText:=""
$vtHeaderValue:=""
$vtHost:=""
$vtMBName:=""
$vtMBRefName:=""
$vtMsgText:=""
$vtPath:=""
$vtUserName:=""
$vtUserPassword:=""
$vtError:=""
//</declarations>

//  http:  //doc.4d.com/4Dv16R3/4D-Internet-Commands/16-R3/IMAP-CloseCurrentMB.301-3334442.en.html
ARRAY TEXT:C222($atMBNames; 0)
ARRAY TEXT:C222($atMBAttribs; 0)
ARRAY TEXT:C222($atMBHierarchy; 0)
ARRAY TEXT:C222($atMsgHeader; 0)
ARRAY TEXT:C222($atMsgValue; 0; 0)  // 2 dimensional array
ARRAY TEXT:C222($atMsgFlags; 0)
ARRAY TEXT:C222($atEnclosureList; 0)  // names of Attachments

ARRAY LONGINT:C221($aiMsgNum; 0)
ARRAY LONGINT:C221($aiMsgNumFlags; 0)
ARRAY LONGINT:C221($aiMsgSize; 0)
ARRAY LONGINT:C221($aiMsgID; 0)

C_LONGINT:C283($viError; $viSubscribedMB; $viUpdateSeen; $viHeaderSize; $viBodySize; $viMsgSize)
C_LONGINT:C283($viImap_ID; $viSessionParam; $viDecode; $viSOA1)
C_TEXT:C284($vtCapability; $vtHost; $vtUserName; $vtUserPassword; $vtAttachmentPath)
C_TEXT:C284($vtMBRefName; $vtFileName; $vtHeaderValue; $vtBodyText)

$vtUserName:="alpsedi@functionaldevices.com"
$vtUserPassword:="RIBU!C5538"
$vtHost:="outlook.office365.com"
$viPort:=993  // secure IMAP SSL

// loop through and set parameters

For ($Parameter; 1; Count parameters:C259)
	
	Case of 
		: ($Parameter=1)
			$vtUserName:=$1
			
		: ($Parameter=2)
			$vtUserPassword:=$2
			
		: ($Parameter=3)
			$vtHost:=$3
			
		: ($Parameter=4)
			$viPort:=$4
			
		Else 
			
	End case 
	
End for 

If ($viPort=993)  // SSL IMAP
	$viProtocal:=14
Else 
	$viPort:=147  // PLAIN TEXT IMAP
	$viProtocal:=4
End if 

ON ERR CALL:C155("jOECNoAction")

ConsoleMessage("\r"+String:C10(Current date:C33; Internal date short:K1:7)+" "+String:C10(Current time:C178; HH MM SS:K7:1)+" Begin IMAP Receive")

$viError:=IT_SetPort($viProtocal; $viPort)  // 14 = SSL IMAP 993 = Port
If ($viError#0)
	ConsoleMessage("Error: "+String:C10($viError)+" IT_SetPort")
End if 
$viSessionParam:=1  // 1= ssl
$viError:=IMAP_Login($vtHost; $vtUserName; $vtUserPassword; $viImap_ID; $viSessionParam)
If ($viError#0)
	ConsoleMessage("Error: "+String:C10($viError)+" IMAP_Login")
End if 

If ($viError=0)
	C_TEXT:C284($vtCapability)
	$viError:=IMAP_Capability($viImap_ID; $vtCapability)
	If ($viError#0)
		ConsoleMessage("Error: "+String:C10($viError)+" IMAP_Capability")
	End if 
	If ($vtCapability%"IMAP4rev1")
		ConsoleMessage("SUCCESS: IMAP4rev1 Capable")
		// IMAP commands using $viImap_ID parameter 
	Else 
		ConsoleMessage("WARNING: NOT IMAP4rev1 Capable Could cause errors")
	End if 
	
	// Getting the current mailbox when none is selected returns error code 10092
	//   $viError:=IMAP_GetCurrentMB ($viImap_ID;$vtMBName)
	// 
	// Case of 
	// : ($viError=10092)
	// ConsoleMessage ("STATUS: A maibox is not selected")
	// $viError:=0
	// 
	// : ($vtMBName="")
	// ConsoleMessage ("STATUS: A maibox is not selected")
	// $viError:=0
	// 
	// : ($viError#0)
	// ConsoleMessage ("Error: "+String($viError)+" IMAP_GetCurrentMB")
	// 
	// End case 
	
	$vtMBRefName:=""
	$vtMBName:="*"
	$viSubscribedMB:=0  // 0 = all mailboxes
	$viError:=IMAP_ListMBs($viImap_ID; $vtMBRefName; $vtMBName; $atMBNames; $atMBAttribs; $atMBHierarchy; $viSubscribedMB)
	If ($viError#0)
		ConsoleMessage("Error: "+String:C10($viError)+" IMAP_ListMBs")
	End if 
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
	
	//For ($vi1;1;Size of array($atMBNames))
	//ConsoleMessage ($atMBNames{$vi1})
	//End for 
	
	$vi1:=Find in array:C230($atMBNames; "INBOX")
	
	$vtMBName:=$atMBNames{$vi1}
	
	ConsoleMessage("Checking Status of INBOX...")
	
	$viError:=IMAP_GetMBStatus($viImap_ID; $vtMBName; $viMsgCount; $viMsgCountNew; $viMsgCountUnseen; $viMBID)
	If ($viError#0)
		ConsoleMessage("Error: "+String:C10($viError)+" IMAP_GetMBStatus")
	End if 
	//  imap_ID LongintinReference to an IMAP login
	//  mbName TextinName of the mailbox
	//  msgNber LongintinNumber of messages in the specified mailbox
	//  newMsgNber LongintinNumber of messages with the \Recent flag set
	//  unseenMsgNber LongintinNumber of messages with no \Seen flag
	//  mbUID LongintinSpecified mailbox unique identifier
	//  Function result IntegerinError code
	
	ConsoleMessage("Mailbox: "+$vtMBName)
	ConsoleMessage("Messages: "+String:C10($viMsgCount))
	ConsoleMessage("New: "+String:C10($viMsgCountNew))
	ConsoleMessage("Unseen: "+String:C10($viMsgCountUnseen))
	
	C_TEXT:C284($vtMBName; $flagsCustom; $flagsPermanent)
	C_LONGINT:C283($numMsg; $numMsgNew; $viMBID)
	
	ConsoleMessage("STATUS: Setting Current mailbox to INBOX...")
	
	$viError:=IMAP_SetCurrentMB($viImap_ID; $vtMBName; $numMsg; $numMsgNew; $flagsCustom; $flagsPermanent; $viMBID)
	If ($viError#0)
		ConsoleMessage("Error: "+String:C10($viError)+" IMAP_SetCurrentMB")
	End if 
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
	
	// how to determine the starting point ?
	
	$startMsg:=1
	$endMsg:=$viMsgCount
	
	// ### jwm ### 20190912_1715 commented out to eliminate downloadingg the MsgID array twice
	
	//APPEND TO ARRAY($atMsgHeader;"Sensitivity:")
	//APPEND TO ARRAY($atMsgHeader;"From:")
	//APPEND TO ARRAY($atMsgHeader;"To:")
	//APPEND TO ARRAY($atMsgHeader;"Reply-To:")
	//APPEND TO ARRAY($atMsgHeader;"Date:")
	//APPEND TO ARRAY($atMsgHeader;"Subject:")
	//APPEND TO ARRAY($atMsgHeader;"Content-Type:")
	//APPEND TO ARRAY($atMsgHeader;"Content-Transfer-Encoding:")
	//APPEND TO ARRAY($atMsgHeader;"Message-ID:")
	//APPEND TO ARRAY($atMsgHeader;"X-MDID:")
	//APPEND TO ARRAY($atMsgHeader;"Return-Path:")
	//APPEND TO ARRAY($atMsgHeader;"MIME-Version:")
	//
	//ConsoleMessage ("STATUS: Getting Message List...")
	//$viError:=IMAP_MsgLst ($viImap_ID;$startMsg;$endMsg;$atMsgHeader;$aiMsgNum;$aiMsgID;$atMsgValue)
	//
	//ConsoleMessage ("$aiMsgID: "+String(Size of array($aiMsgID)))
	//ConsoleMessage ("$aiMsgNum: "+String(Size of array($aiMsgNum)))
	//ConsoleMessage ("$atMsgValue: "+String(Size of array($atMsgValue)))
	//ConsoleMessage ("$atMsgHeader: "+String(Size of array($atMsgHeader)))
	//
	//If (Size of array($aiMsgID)#Size of array($aiMsgNum))
	//ConsoleMessage ("Error: Message Array Size Mismatch")
	//End if 
	//
	//If (Size of array($atMsgHeader)#Size of array($atMsgValue))
	//ConsoleMessage ("Error: Headers Array Size Mismatch")
	//End if 
	//
	//If ($viError#0)
	//ConsoleMessage ("Error: "+String($viError)+" IMAP_MsgLst")
	//End if 
	
	
	//  imap_ID LongintinReference to an IMAP login
	//  startMsg LongintinStart message number
	//  endMsg LongintinEnd message number
	//  msgHeaderArray String arrayinArray of headers to retrieve
	//  msgNumArray is a long integer array returned containing the message numbers between startMsg and endMsg.
	//  msgIdArray is a long integer array returning the Unique IDs of the messages between startMsg and endMsg.
	//  msgValueArray 2D String array, 2D Text arrayin2D Array of header values
	//  Function result IntegerinError code
	
	ConsoleMessage("STATUS: Getting Message Info...")
	$viError:=IMAP_MsgLstInfo($viImap_ID; $startMsg; $endMsg; $aiMsgSize; $aiMsgNum; $aiMsgID)
	If ($viError#0)
		ConsoleMessage("Error: "+String:C10($viError)+" IMAP_MsgLstInfo")
	End if 
	//  imap_ID LongintinReference to an IMAP login
	//  startMsg LongintinStart message number
	//  endMsg LongintinEnd message number
	//  msgSizeArray Longint arrayinArray of sizes
	//  msgNumArray Longint arrayinArray of message numbers
	//  msgIdArray Longint arrayinArray of Unique Msg IDs
	//  Function result IntegerinError code
	
	ConsoleMessage("STATUS: Getting Message Flags...")
	$viError:=IMAP_GetFlags($viImap_ID; $startMsg; $endMsg; $atMsgFlags; $aiMsgNumFlags)
	
	If ($viError#0)
		ConsoleMessage("Error: "+String:C10($viError)+" IMAP_GetFlags")
	End if 
	
	// Check for Array Size Mismatch
	$viMsgID:=Size of array:C274($aiMsgID)
	ConsoleMessage("MsgID:\t"+String:C10($viMsgID))
	
	$viMsgNum:=Size of array:C274($aiMsgNum)
	ConsoleMessage("MsgNum:\t"+String:C10($viMsgNum))
	
	$viMsgSize:=Size of array:C274($aiMsgSize)
	ConsoleMessage("MsgSize:\t"+String:C10($viMsgSize))
	
	$viMsgFlags:=Size of array:C274($atMsgFlags)
	ConsoleMessage("MsgFlags:\t"+String:C10($viMsgFlags))
	
	$viMsgNumFlags:=Size of array:C274($aiMsgNumFlags)
	ConsoleMessage("MsgNumFlags:\t"+String:C10($viMsgNumFlags))
	
	Case of 
		: ($viMsgNum#$viMsgNumFlags)
			$viError:=10114
			ConsoleMessage("Error: 10114 ARRAY MISMATCH MSGNUM")
			
		: ($viMsgNum#$viMsgID)
			$viError:=10115
			ConsoleMessage("Error: 10115 ARRAY MISMATCH MSGID")
			
			
		: ($viMsgNum#$viMsgSize)
			$viError:=10116
			ConsoleMessage("Error: 10116 ARRAY MISMATCH MSGSIZE")
			
			
		: ($viMsgNum#$viMsgFlags)
			$viError:=10117
			ConsoleMessage("Error: 10117 ARRAY MISMATCH MSGFLAGS")
			
			
	End case 
	
	//  imap_ID LongintinReference to an IMAP login
	//  startMsg Longintin  Start message number
	//  endMsg LongintinEnd message number
	//  msgFlagsArray String arrayinFlag values for each message
	//  msgNumArray Longint arrayinArray of message numbers
	//  Function result IntegerinError code
	
	
	If ($viError=0)
		
		$viNumChars:=Position:C15("@"; $vtUserName)-1
		$vtUserFolder:=Substring:C12($vtUserName; 1; $viNumChars)
		
		$vtPath:=Storage:C1525.folder.jitF+"Email"+Folder separator:K24:12+$vtUserFolder+Folder separator:K24:12+$vtMBName+Folder separator:K24:12
		If (Test path name:C476($vtPath)=-43)
			CREATE FOLDER:C475($vtPath; *)  // create folder path if it does not exist
		End if 
		
		$vtAttachmentPath:=Storage:C1525.folder.jitF+"Email"+Folder separator:K24:12+$vtUserFolder+Folder separator:K24:12+$vtMBName+Folder separator:K24:12+"Attachments"+Folder separator:K24:12
		If (Test path name:C476($vtAttachmentPath)=-43)
			CREATE FOLDER:C475($vtAttachmentPath; *)  // create folder path if it does not exist
		End if 
		
		ConsoleMessage("STATUS: Checking Messages...")
		
		$viProgressID:=Progress New
		
		$viSOA1:=Size of array:C274($aiMsgID)  // ### jwm ### 20190808_1331 changed $aiMsgNum to $aiMsgID
		
		$viRead:=0
		
		For ($vi1; 1; $viSOA1)
			
			ProgressUpdate($viProgressID; $vi1; $viSOA1; "Reading Email...")
			
			// ### jwm ### 20181009_1701
			// download the email 
			
			$viDuplicate:=0
			SET QUERY DESTINATION:C396(Into variable:K19:4; $viDuplicate)
			QUERY:C277([Message:137]; [Message:137]keyTags:11%String:C10($aiMsgID{$vi1}); *)
			QUERY:C277([Message:137]; [Message:137]category:25=$vtUserFolder)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			
			If ($viDuplicate=0)  // unique Merssage ID
				
				$viRead:=$viRead+1
				
				$viUpdateSeen:=0  // 0 = Add \Seen Flag; 1= Do not add \Seen Flag
				$viHeaderOnly:=0  // 0 = Entire message, 1 = Only header
				$viPathLength:=Length:C16($vtPath)+1
				$vtFileName:=$vtPath+String:C10($aiMsgID{$vi1})+".eml"
				$viError:=IMAP_Download($viImap_ID; $aiMsgNum{$vi1}; $viHeaderOnly; $vtFileName; $viUpdateSeen)
				$vtEmailID:=Substring:C12($vtFileName; $viPathLength)
				
				//Parameter Type   Description
				//imap_ID  Longint in Reference to an IMAP login
				//msgNum  Longint in Message number
				//headerOnly  Integer in 0=Entire message, 1=Only header
				//fileName  Text in Local Filename
				//in Resulting Local Filename
				//updateSeen  Integer in 0=Add\Seen Flag;1=Do not add\Seen Flag
				//Function result  Integer in Error code 
				
				$viOffset:=0
				$viMsgPart:=1  //0 = Entire message, 1 = Only header, 2= Only Body
				$viUpdateSeen:=1  //0 = Update \Seen Flag; 1 = Do not update 
				IMAP_GetMessage($viImap_ID; $aiMsgNum{$vi1}; $viOffset; $aiMsgSize{$vi1}; $viMsgPart; $vtMsgText; $viUpdateSeen)
				If ($viError#0)
					ConsoleMessage("Error: "+String:C10($viError)+" IMAP_GetMessage")
				End if 
				//Parameter Type   Description
				//imap_ID  Longint in Reference to an IMAP login
				//msgNum  Longint in Message number
				//offset  Longint in Offset of character at which to begin retrieval
				//length  Longint in How many characters to return
				//msgPart  Integer in 0=Entire message, 1=Only header, 2=Only Body
				//msgText  Text in Message Text
				//updateSeen  Integer in 0=Update\Seen Flag;1=Do not update
				//Function result  Integer in Error code
				
				If ($viError=0)
					
					$viError:=MSG_FindHeader($vtFileName; "Message-ID:"; $vtHeaderValue)
					If ($viError=0)
						[Message:137]messageid:10:=$vtHeaderValue
						$viDuplicate:=0
						SET QUERY DESTINATION:C396(Into variable:K19:4; $viDuplicate)
						QUERY:C277([Message:137]; [Message:137]messageid:10=$vtHeaderValue)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
					End if 
					
					
					If ($viDuplicate=0)  // unique Email Message ID
						
						CREATE RECORD:C68([Message:137])
						
						[Message:137]status:26:=$atMsgFlags{$vi1}
						[Message:137]pathToOriginal:13:=$vtFileName
						[Message:137]action:14:="Read Email"
						[Message:137]actionDate:16:=Current date:C33
						[Message:137]time:8:=Current time:C178
						[Message:137]dtReceived:9:=DateTime_Enter
						[Message:137]actionBy:17:=Current user:C182
						
						//Parameter Type   Description
						//fileName  Text in Filename(path defaults to message folder)
						//headerLabel  String in Header label("From:","To:","Subject:", etc.)
						//headerValue  Text in Value
						//Function result  Integer in Error Code
						
						$viError:=MSG_FindHeader($vtFileName; "Message-ID:"; $vtHeaderValue)
						If ($viError=0)
							[Message:137]messageid:10:=$vtHeaderValue
						End if 
						
						$viError:=MSG_FindHeader($vtFileName; "TO:"; $vtHeaderValue)
						If ($viError=0)
							[Message:137]to:1:=$vtHeaderValue
						End if 
						
						$viError:=MSG_FindHeader($vtFileName; "FROM:"; $vtHeaderValue)
						If ($viError=0)
							[Message:137]from:2:=$vtHeaderValue
						End if 
						
						$viError:=MSG_FindHeader($vtFileName; "SUBJECT:"; $vtHeaderValue)
						If ($viError=0)
							[Message:137]subject:6:=$vtHeaderValue
						End if 
						
						$viError:=MSG_FindHeader($vtFileName; "CC:"; $vtHeaderValue)
						If ($viError=0)
							[Message:137]cc:4:=$vtHeaderValue
						End if 
						
						$viError:=MSG_FindHeader($vtFileName; "BCC:"; $vtHeaderValue)
						If ($viError=0)
							[Message:137]bcc:5:=$vtHeaderValue
						End if 
						
						$viError:=MSG_FindHeader($vtFileName; "DATE:"; $vtHeaderValue)
						If ($viError=0)
							//[Message]Date:=Date($vtHeaderValue)
							RFC_2822($vtHeaderValue; ->[Message:137]date:7; ->[Message:137]time:8)
						End if 
						
						$viError:=MSG_FindHeader($vtFileName; "Envelope-to:"; $vtHeaderValue)
						If ($viError=0)
							[Message:137]comments:27:=[Message:137]comments:27+"Envelope-to:"+$vtHeaderValue+"\r"
						End if 
						$viError:=MSG_FindHeader($vtFileName; "Return-Path:"; $vtHeaderValue)
						If ($viError=0)
							[Message:137]comments:27:=[Message:137]comments:27+"Return-Path:"+$vtHeaderValue+"\r"
						End if 
						$viError:=MSG_FindHeader($vtFileName; "Delivered-To:"; $vtHeaderValue)
						If ($viError=0)
							[Message:137]comments:27:=[Message:137]comments:27+"Delivered-To:"+$vtHeaderValue+"\r"
						End if 
						$viError:=MSG_FindHeader($vtFileName; "Received:"; $vtHeaderValue)
						If ($viError=0)
							[Message:137]comments:27:=[Message:137]comments:27+"Received:"+$vtHeaderValue+"\r"
						End if 
						$viError:=MSG_FindHeader($vtFileName; "Delivery-date:"; $vtHeaderValue)
						If ($viError=0)
							[Message:137]date:7:=Date:C102($vtHeaderValue)
						End if 
						
						[Message:137]dtReceived:9:=DateTime_Enter
						[Message:137]keyTags:11:=String:C10($aiMsgID{$vi1})
						[Message:137]messageIMAPid:41:=$aiMsgID{$vi1}
						[Message:137]category:25:=$vtUserFolder
						
						//Parameter Type   Description
						//fileName  Text in Filename(path defaults to message folder)
						//headerSize  Longint in Header size(subtracts linefeeds if Prefs ON)
						//bodySize  Longint in Body size(subtracts linefeeds if Prefs ON)
						//msgSize  Longint in Entire message or file size(ignores Prefs)
						//Function result  Integer in Error Code 
						$viError:=MSG_MessageSize($vtFileName; $viHeaderSize; $viBodySize; $viMsgSize)
						
						If ($viError=0)
							
							[Message:137]size:28:=$viMsgSize
							$viOffset:=0  //Start of Body
							
							//Parameter Type   Description
							//fileName  Text in Filename(path defaults to message folder)
							//offset  Longint in Starting offset into message body(0=start of body)
							//length  Longint in Number of characters
							//bodyText  Text in Body text(removes linefeeds if Prefs ON)
							//Function result  Longint in Error Code 
							$viError:=MSG_GetBody($vtFileName; $viOffset; $viBodySize; $vtBodyText)
							If ($viError=0)
								[Message:137]bodyText:37:=$vtBodyText
							End if 
							$viError:=MSG_GetHeaders($vtFileName; $viOffset; $viHeaderSize; $vtHeaderText)
							If ($viError=0)
								[Message:137]headerText:38:=$vtHeaderText
							End if 
							
							//Parameter Type   Description
							//fileName  Text in Filename(path defaults to message folder)
							//offset  Longint in Starting offset into headers(0=start of header)
							//length  Longint in Number of characters
							//headerText  Text in Header text(removes linefeeds if Prefs ON)
							//Function result  Integer in Error Code
							
						End if 
						
						$viError:=MSG_HasAttach($vtFileName; $viAttachments)
						If ($viError=0)
							If ($viAttachments>0)
								[Message:137]attachmentCount:29:=$viAttachments
								$viDecode:=1
								//Parameter Type   Description
								//fileName  Text in Filename(path defaults to message folder)
								//decode  Integer in 0=No decoding, 1=Decode if possible
								//attachmentPath  Text in FolderPath(path defaults to attachment folder)
								//enclosureList  String array in Enclosure filenames w/o FolderPath
								//Function result  Integer in Error Code
								$viError:=MSG_Extract($vtFileName; $viDecode; $vtAttachmentPath; $atEnclosureList)
								
								If ($viError=0)
									For ($vi2; 1; Size of array:C274($atEnclosureList))
										[Message:137]comments:27:=[Message:137]comments:27+"Attachment: "+$vtAttachmentPath+$atEnclosureList{$vi2}+"\r"
										//$vtAttacment:=$vtEmailID+".1.txt"  // name is slightly different on Windows and Mac 1 vs .1
										If (($atEnclosureList{$vi2}=($vtEmailID+"@")) & ($atEnclosureList{$vi2}="@.txt"))  // if begins with EmailID and Ends with .txt
											[Message:137]body:12:=Document to text:C1236($vtAttachmentPath+$atEnclosureList{$vi2})  // save text to Body
										End if 
									End for 
								End if 
							End if 
						End if 
						
						SAVE RECORD:C53([Message:137])
						
						If ($viRead=1)  // write header before first message received
							ConsoleMessage("\r Email ID:\t Date:\t Time:\t Subject:")
						End if 
						
						ConsoleMessage(String:C10([Message:137]messageIMAPid:41)+"\t"+String:C10([Message:137]date:7; Internal date short:K1:7)+"\t"+String:C10([Message:137]time:8; System time short:K7:9)+"\t"+[Message:137]subject:6)
						
					Else   // delete file if duplicate
						
						//Parameter Type   Description
						//fileName  Text in Filename(path defaults to message folder)
						//attachCount  Integer in Count of Attachments
						//Function result  Integer in Error Code 
						$viError:=MSG_HasAttach($vtFileName; $viAttachments)
						
						If ($viError=0)
							If ($viAttachments>0)
								// delete email Attacments if it is a duplicate
								$viFolder:=1
								$viError:=MSG_Delete($vtFileName; $viFolder)
							End if 
						End if 
						
						// delete email if it is a duplicate
						$viFolder:=0
						//Parameter Type   Description
						//fileName  Text in Filename(path defaults to message folder)
						//folder  Integer in 0=Message Folder, 1=Attachment Folder
						//Function result  Integer in Error Code 
						$viError:=MSG_Delete($vtFileName; $viFolder)
						
						
					End if   // end unique Message ID
				End if   // end successful download
				
				
				//  imap_ID LongintinReference to an IMAP login
				//  msgNum LongintinMessage number
				//  offset LongintinOffset of character at which to begin retrieval
				//  length LongintinHow many characters to return
				//  msgPart Integerin0 = Entire message, 1 = Only header, 2= Only Body
				//  msgText TextinMessage Text
				//  updateSeen Integerin0 = Update \Seen Flag; 1 = Do not update
				//  Function result IntegerinError code
				
			End if 
			
		End for 
		
		Progress QUIT($viProgressID)
		
	Else   // report error
		
		$vtError:=""
		
		Case of 
			: ($viError=10092)
				$vtError:="A maibox is not selected"
			: ($viError=10093)
				$vtError:="Invalid message part"
			: ($viError=10094)
				$vtError:="Error with IMAP LOGIN"
			: ($viError=10095)
				$vtError:="Error with IMAP LOGOUT"
			: ($viError=10096)
				$vtError:="Error with IMAP CAPABILITY"
			: ($viError=10097)
				$vtError:="Error with IMAP SELECT"
			: ($viError=10098)
				$vtError:="Error with IMAP FETCH"
			: ($viError=10099)
				$vtError:="Error with IMAP PARTIAL"
			: ($viError=10100)
				$vtError:="Error with IMAP STORE"
			: ($viError=10101)
				$vtError:="Error with IMAP EXPUNGE"
			: ($viError=10102)
				$vtError:="Error with IMAP SEARCH"
			: ($viError=10103)
				$vtError:="Error with IMAP COPY"
			: ($viError=10104)
				$vtError:="Error with IMAP CREATE"
			: ($viError=10105)
				$vtError:="Error with IMAP DELETE"
			: ($viError=10106)
				$vtError:="Error with IMAP RENAME"
			: ($viError=10107)
				$vtError:="Error with IMAP SUBSCRIBE"
			: ($viError=10108)
				$vtError:="Error with IMAP UNSUBSCRIBE"
			: ($viError=10109)
				$vtError:="Error with IMAP LIST"
			: ($viError=10110)
				$vtError:="Error with IMAP LSUB"
			: ($viError=10111)
				$vtError:="Error with IMAP STATUS"
			: ($viError=10112)
				$vtError:="Error with IMAP CLOSE"
			: ($viError=10113)
				$vtError:="Error with AUTHENTICATION"
			: ($viError=10114)
				$vtError:="Error ARRAY MISMATCH MSGNUMFLAGS"
			: ($viError=10115)
				$vtError:="Error ARRAY MISMATCH MSGID"
			: ($viError=10116)
				$vtError:="Error ARRAY MISMATCH MSGSIZE"
			: ($viError=10117)
				$vtError:="Error ARRAY MISMATCH MSGSIZE"
				
			Else 
				
				$vtError:="Error: "+String:C10($viError)+" UNKNOWN "
				
		End case 
		
		If ($vtError#"")
			ConsoleMessage("Error: "+$vtError)
		End if 
		
	End if   // ARRAY MISMATCH
	
	$viError:=IMAP_CloseCurrentMB($viImap_ID)
	
End if 

$viError:=IMAP_Logout($viImap_ID)
CLEAR VARIABLE:C89($vtUserPassword)
ON ERR CALL:C155("")


ConsoleMessage("IMAP Receive Complete")
TRACE:C157
