//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-07-24T00:00:00, 15:22:06
// ----------------------------------------------------
// Method: eMail_Receive
// Description
// Modified: 07/24/13
// 
// 
//
// Parameters
// ----------------------------------------------------


Process_InitLocal
// receive email from remote server


C_LONGINT:C283($error; pop3_ID)
C_LONGINT:C283(aPOP)
C_TEXT:C284($1; $employNameID)
$employNameID:="admin"
If (Count parameters:C259=1)
	$employNameID:=$1
End if 

QUERY:C277([Employee:19]; [Employee:19]nameID:1=$employNameID)
hostName:=[Employee:19]emailServerIn:73
hostName:=Replace string:C233([Employee:19]emailServerIn:73; "smtpout"; "pop")
userName:=[Employee:19]emailUserName:60
password:=[Employee:19]emailPassword:61

If (False:C215)
	hostName:="pop.secureserver.net"
	userName:="bill@jitcorp.com"
	password:="testthis"
	sessionOptions:=1
	
	
End if 

aPOP:=0
//[Employee]EmailPort
REDUCE SELECTION:C351([Employee:19]; 0)
// /login

QUERY:C277([TallyResult:73]; [TallyResult:73]name:1="emaillog"; *)
QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2="admin"; *)
QUERY:C277([TallyResult:73];  & [TallyResult:73]profile1:17=$employNameID)

If (Records in selection:C76([TallyResult:73])=0)
	CREATE RECORD:C68([TallyResult:73])
	
	[TallyResult:73]name:1:="emaillog"
	[TallyResult:73]purpose:2:="admin"
	[TallyResult:73]nameLong1:24:="StartMessage"
	[TallyResult:73]longint1:7:=1
	[TallyResult:73]nameProfile1:26:="EmployeeNameID"
	[TallyResult:73]profile1:17:=$employNameID
	[TallyResult:73]nameProfile2:27:="DeleteInstruction"
	$clearEmail:=DefaultSetupsReturnValue("deleteemail")
	[TallyResult:73]profile2:18:=$clearEmail
	SAVE RECORD:C53([TallyResult:73])
End if 
If (Length:C16([TallyResult:73]textBlk1:5)>64000)
	[TallyResult:73]textBlk1:5:=Substring:C12([TallyResult:73]textBlk1:5; 1; 32000)
End if 

$clearEmail:=[TallyResult:73]profile2:18  // set if to delete of not

$error:=POP3_Login(hostName; userName; password; aPOP; pop3_ID; sessionOptions)
[TallyResult:73]textBlk1:5:="HostName: "+hostName+", userName: "+userName+", password: "+("*"*Length:C16(password))+", SignError: "+String:C10($error)+"\r"+[TallyResult:73]textBlk1:5
If ($error=0)  //  no defects
	//what is in my mailbox
	C_LONGINT:C283($error; pop3_ID; msgCount; msgSize)
	$error:=POP3_BoxInfo(pop3_ID; msgCount; msgSize)
	[TallyResult:73]textBlk1:5:="msgCount: "+String:C10(msgCount)+", msgSize: "+String:C10(msgSize)+", CountError: "+String:C10($error)+"\r"+[TallyResult:73]textBlk1:5
	If ($error=0)
		
		
		If (HFS_Exists(Storage:C1525.folder.jitF+"jitemail")=0)
			CreateFolder_ReadWrite(Storage:C1525.folder.jitF+"jitEmail")
		End if 
		ARRAY LONGINT:C221(msgNumArray; 0)
		ARRAY LONGINT:C221(sizeArray; 0)
		ARRAY TEXT:C222(idArray; 0)
		
		ARRAY TEXT:C222(hdrArray; 3)  //2-dimentional array
		ARRAY LONGINT:C221(msgNumArray; 0)
		ARRAY TEXT:C222(idArray; 0)
		ARRAY TEXT:C222(valueArray; 0; 0)  //2-dimentional array
		
		C_LONGINT:C283(start; endMsg)
		// startMsg:=[TallyResult]Longint1
		startMsg:=1
		endMsg:=msgCount
		
		$error:=POP3_MsgLstInfo(pop3_ID; startMsg; endMsg; sizeArray; msgNumArray; idArray)
		If ($error=0)
			hdrArray{1}:="Date:"
			hdrArray{2}:="From:"
			hdrArray{3}:="Subject:"
			$error:=POP3_MsgLst(pop3_ID; startMsg; endMsg; hdrArray; msgNumArray; idArray; valueArray)
			
			
			$k:=Size of array:C274(sizeArray)
			For ($i; 1; $k)
				QUERY:C277([CallReport:34]; [CallReport:34]messageid:53=idArray{$i})
				
				// testing
				// DELETE RECORD([CallReport])
				
				If (Records in selection:C76([CallReport:34])=0)
					
					$msgNumber:=msgNumArray{$i}
					$document:=Storage:C1525.folder.jitF+"jitEmail"+Folder separator:K24:12+Date_strYyyymmdd(Current date:C33)+Replace string:C233(String:C10(Current time:C178); ":"; "")+".eml"
					$error:=POP3_Download(pop3_ID; $msgNumber; 0; Storage:C1525.folder.jitF+"jitemail:"+Date_strYyyymmdd(Current date:C33)+Replace string:C233(String:C10(Current time:C178); ":"; "")+".eml")
					If ($error=0)
						$offset:=0
						$length:=sizeArray{$i}
						msgText:=""
						CREATE RECORD:C68([CallReport:34])
						
						
						[TallyResult:73]profile2:18:=idArray{$i}
						
						[CallReport:34]messageid:53:=idArray{$i}
						[CallReport:34]from:49:=valueArray{2}{$i}
						[CallReport:34]subject:14:=valueArray{3}{$i}
						[CallReport:34]pathToAttachments:52:=$document
						//if(false)  // build a tool to parse header
						$myHeader:=idArray{$i}
						$cntRay:=Size of array:C274(hdrArray)
						For ($incRay; 1; $cntRay)
							$myHeader:=$myHeader+"\r"+hdrArray{$incRay}+":_ "+valueArray{$incRay}{$i}+"\r"
						End for 
						[CallReport:34]comment:16:=$myHeader
						//End if 
						$doHeader:=1
						
						$error:=POP3_GetMessage(pop3_ID; $msgNumber; $offset; $length; msgText)
						[CallReport:34]body:47:=msgText
						
						If ($doHeader=1)  // do this on the first loop
							[CallReport:34]messageText:51:=msgText
							$doHeader:=0  // after the first pass, do not add input
						End if 
						msgText:=""
						
						[CallReport:34]dateDocument:17:=Current date:C33
						[CallReport:34]emailMessage:10:=True:C214
						[CallReport:34]attention:18:=[CallReport:34]from:49
						SAVE RECORD:C53([CallReport:34])
						
						//### jwm ### 20130726_1143 varaible names did not match
						//C_TEXT(deleteemail)
						If (False:C215)
							$clearEmail:=DefaultSetupsReturnValue("deleteemail")
						End if 
						
						If (False:C215)
							If ($clearEmail="delete@")
								$error:=POP3_Delete(pop3_ID; startMsg; startMsg)
							End if 
						End if 
						
					End if 
				End if 
			End for 
			
			If ($clearEmail="delete@")
				$error:=POP3_Delete(pop3_ID; startMsg; endMsg)
			End if 
			
		End if 
	End if 
	$error:=POP3_Logout(pop3_ID)
End if 
