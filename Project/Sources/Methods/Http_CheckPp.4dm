//%attributes = {"publishedWeb":true}
//Procedure: Http_CheckPp
//  C_LONGINT($1; $p)
//  C_POINTER($2)
//  C_DATE($ccDate)
//  
//  //
//  C_TEXT(<>eMailAddr; $cardName)
//  //
//  C_BOOLEAN($gotCC)
//  //
//  $suffix:=""
//  C_TEXT($suffix; lang)
//  Case of 
//  : (lang="fr")
//  $suffix:="_fr"
//  : (lang="de")
//  $suffix:="_de"
//  Else 
//  lang:="us"
//  $suffix:=""
//  End case 
//  //
//  C_REAL($ordVal)
//  C_TEXT($approval)
//  //
//  Case of 
//  : ([EventLog]tableNum=0)
//  : (([EventLog]tableNum=2) & ([EventLog]customerRecNum>-1))
//  GOTO RECORD([Customer]; [EventLog]customerRecNum)
//  Http_SaveRecord($1; $2; False)
//  : (([EventLog]tableNum=48) & ([EventLog]customerRecNum>-1))
//  GOTO RECORD([Lead]; [EventLog]customerRecNum)
//  Temp2Customer
//  [EventLog]tableNum:=2
//  [EventLog]customerRecNum:=Record number([Customer])
//  READ WRITE([RemoteUser])
//  GOTO RECORD([RemoteUser]; [EventLog]remoteUserRec)
//  If ([EventLog]idNum#0)
//  SAVE RECORD([EventLog])
//  End if 
//  End case 
//  Case of 
//  : ([EventLog]tableNum=0)
//  $err:=WC_PageSendWithTags($1; WC_DoPage("Register"+$suffix+".html"; ""); 0)
//  : (([EventLog]tableNum>0) & ([EventLog]remoteUserRec>-1))
//  //
//  GOTO RECORD([RemoteUser]; [EventLog]remoteUserRec)
//  Http_PpFill($1; $2; True)
//  //
//  
//  FIRST RECORD([ProposalLine])
//  //set parameter 3 to -3 to force an email to the end user
//  $err:=WC_PageSendWithTags($1; WC_DoPage("PpCmplt"+$suffix+".html"; ""); 0)
//  Else 
//  $err:=WC_PageSendWithTags($1; WC_DoPage("Error"+$suffix+".html"; ""); 0)
//  End case 
//  vText3:=""
//  vText2:=""
//  //
//  