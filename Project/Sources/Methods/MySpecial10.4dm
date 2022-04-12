//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-06T00:00:00, 22:34:17
// ----------------------------------------------------
// Method: MySpecial10
// Description
// Modified: 01/06/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


If (False:C215)
	//If (Test path name(Storage.folder.jitF+"zzzz.txt")=1)
	//DELETE DOCUMENT(Storage.folder.jitF+"zzzz.txt")
	//End if 
	
	Txt_4D2Doc(Storage:C1525.folder.jitF+"zzzz.txt")
	iLoText7:=document
	CREATE RECORD:C68([CallReport:34])
	
	[CallReport:34]dtAction:4:=DateTime_Enter
	[CallReport:34]dateDocument:17:=Current date:C33
	[CallReport:34]complete:7:=True:C214
	[CallReport:34]initiatedBy:23:=Current user:C182
	[CallReport:34]actionBy:3:=Current user:C182
	[CallReport:34]customerID:1:=[Customer:2]customerID:1
	//[CallReport]TableNum:=Table(->[Customer])
	[CallReport:34]subject:14:="Email Orders"
	If (varible1="")
		[CallReport:34]email:38:=varible1
	Else 
		[CallReport:34]email:38:=[Customer:2]email:81
	End if 
	[CallReport:34]attention:18:=[Customer:2]nameFirst:73+" "+[Customer:2]nameLast:23
	SAVE RECORD:C53([CallReport:34])
	//
	SMTP_EmailBuild(->[CallReport:34])
	If ([CallReport:34]subject:14#"")
		Execute_TallyMaster([CallReport:34]subject:14; "eMailCallReports")
	End if 
	SMTP_SendMsg
	
	
	DELAY PROCESS:C323(Current process:C322; 360)
	CREATE RECORD:C68([SyncRecord:109])
	
	// if we are to save the document, put it in a path
	//document
	
	//[SyncRecord]:=[SyncRelation]Name
	
	//[SyncRecord]TableNum:=Table($1)
	[SyncRecord:109]ideRemote:27:=0  //to be set when record is acknowledged
	[SyncRecord:109]statusReceive:19:=""  //to be set when record is completed
	[SyncRecord:109]statusSend:17:="email"
	[SyncRecord:109]dtCreated:15:=DateTime_Enter
	//[SyncRecord]siteIDFrom:=Storage.default.idPrefix
	[SyncRecord:109]approvedBySend:10:=Current user:C182
	//[SyncRecord]Password:=[RemoteUser]UserPassword
	//[SyncRecord]UserName:=[RemoteUser]UserName
	[SyncRecord:109]tableNum:4:=[RemoteUser:57]tableNum:9
	SAVE RECORD:C53([SyncRecord:109])
	
	
	
End if 