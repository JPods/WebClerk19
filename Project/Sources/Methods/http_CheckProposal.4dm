//%attributes = {"publishedWeb":true}
//Procedure: http_CheckOut
//  C_LONGINT($eventRec; $1; $error; $remoteNum)
//  C_TEXT($dottedAddr; $txtPage)
//  C_POINTER($2)
//  If (False)
//  
//  LOAD RECORD([EventLog])
//  If ([EventLog]remoteUserRec>-1)
//  
//  GOTO RECORD([RemoteUser]; [EventLog]remoteUserRec)
//  Case of 
//  : ((Record number([RemoteUser])=-1) | ([EventLog]customerRecNum=-1))
//  [EventLog]customerRecNum:=-1
//  [EventLog]tableNum:=0
//  : ([EventLog]tableNum=2)
//  GOTO RECORD([Customer]; [EventLog]customerRecNum)
//  : ([EventLog]tableNum=48)
//  GOTO RECORD([Lead]; [EventLog]customerRecNum)
//  //$remoteNum:=Record number([RemoteUser])
//  Temp2Customer
//  //GOTO RECORD([RemoteUser];$remoteNum)
//  [EventLog]tableNum:=2
//  : ([EventLog]tableNum=13)
//  GOTO RECORD([Contact]; [EventLog]customerRecNum)
//  QUERY([Customer]; [Customer]customerID=[Contact]customerID)
//  UNLOAD RECORD([Contact])
//  : ([EventLog]tableNum=38)
//  GOTO RECORD([Vendor]; [EventLog]customerRecNum)
//  QUERY([Customer]; [Customer]phone=[Vendor]phone)
//  If (Records in selection([Customer])=0)
//  Vendor2Customer(2)  //suppress alerts
//  End if 
//  [EventLog]tableNum:=2
//  UNLOAD RECORD([Vendor])
//  : ([EventLog]tableNum=8)
//  GOTO RECORD([Rep]; [EventLog]customerRecNum)
//  //do this some time
//  [EventLog]customerRecNum:=Record number([Rep])
//  UNLOAD RECORD([Rep])
//  End case 
//  [EventLog]customerRecNum:=Record number(Table([EventLog]tableNum)->)  //
//  If ([EventLog]idNum#0)
//  SAVE RECORD([EventLog])
//  End if 
//  LOAD RECORD([EventLog])
//  If ([EventLog]customerRecNum>-1)
//  $doNew:=False
//  Else 
//  $doNew:=True
//  End if 
//  Else 
//  REDUCE SELECTION([Customer]; 0)
//  $doNew:=True
//  End if 
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
//  End if 
//  
//  If (Record number([Customer])<0)
//  $doPage:="Register.html"
//  $jitPageOne:=WCapi_GetParameter("jitPageError"; "")
//  vResponse:="You have not signed in or must register."
//  $doPagePath:=WC_DoPage($doPage; $jitPageOne)
//  $err:=WC_PageSendWithTags($1; $doPagePath; 0)
//  Else 
//  vResponse:="You are registered to proceed."
//  If (<>wcbCustomerMods=1)
//  vText1:="Changes Accepted"
//  Else 
//  vText1:="Changes NOT Accepted On-line"
//  End if 
//  CREATE RECORD([Proposal])
//  myCycle:=3
//  //TRACE
//  vHere:=3  //clear by the end
//  [Proposal]customerID:=[Customer]customerID
//  NxPvProposals(False)  //build order with or without saving
//  WC_Parse(Table(->[Proposal]); $2; False)  // 
//  
//  If (([EventLog]shipToTableNum>0) & ([EventLog]shipToRecordid>0))
//  $ptShipTo:=Table([EventLog]shipToTableNum)
//  GOTO RECORD($ptShipTo->; [EventLog]shipToRecordid)
//  [Proposal]shipVia:=[Contact]shipVia
//  [Proposal]company:=[Contact]company
//  [Proposal]address1:=[Contact]address1
//  [Proposal]address2:=[Contact]address2
//  [Proposal]city:=[Contact]city
//  [Proposal]state:=[Contact]state
//  [Proposal]zip:=[Contact]zip
//  [Proposal]country:=[Contact]country
//  [Proposal]attention:=[Contact]nameFirst+" "+[Contact]nameLast
//  [Proposal]zone:=[Contact]zone
//  [Proposal]taxJuris:=[Contact]taxJuris
//  [Proposal]phone:=[Contact]phone
//  [Proposal]contactShipTo:=[Contact]idNum
//  If ([Contact]phone="")
//  [Proposal]phone:=[Customer]phone
//  Else 
//  [Proposal]phone:=[Contact]phone
//  End if 
//  If ([Contact]fax="")
//  [Proposal]fax:=[Customer]fax
//  Else 
//  [Proposal]fax:=[Contact]fax
//  End if 
//  If ([Contact]email="")
//  [Proposal]email:=[Customer]email
//  Else 
//  [Proposal]email:=[Contact]email
//  End if 
//  End if 
//  vMod:=calcProposal(True)
//  P_PpHeadVars
//  $err:=WC_PageSendWithTags($1; WC_DoPage("CustomersConfirmProposals.html"; ""); 0)
//  vText1:=""
//  End if 
//  
//  