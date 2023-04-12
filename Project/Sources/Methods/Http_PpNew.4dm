//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-04-27T00:00:00, 15:48:16
// ----------------------------------------------------
// Method: Http_PpNew
// Description
// Modified: 04/27/17
// 
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($myText)
C_LONGINT:C283($p; $theFile; $theField; $testFile; $pEnd; $w; $1)
C_POINTER:C301($2)
C_BOOLEAN:C305($3)
$suffix:=""
vResponse:="Processing a Proposal."
$doPage:=WC_DoPage("Error"+$suffix+".html"; "")
//zttp_UserGet (1)
$doDebug:=False:C215
//myDoc:=create document(Storage.folder.jitDebug+"PP_"+String(Records in table([Proposal])))
If (Record number:C243([Customer:2])<0)
	vResponse:="Must be signed in as a customer, contact or lead to use this feature."
	
Else 
	QUERY:C277([zzzWebTempRec:101]; [zzzWebTempRec:101]idEventLog:1=vleventID; *)
	QUERY:C277([zzzWebTempRec:101];  & [zzzWebTempRec:101]qtyOrdered:4#0; *)
	QUERY:C277([zzzWebTempRec:101];  & [zzzWebTempRec:101]posted:5=False:C215)
	$k:=Records in selection:C76([zzzWebTempRec:101])
	FIRST RECORD:C50([zzzWebTempRec:101])
	If (Records in selection:C76([zzzWebTempRec:101])=0)
		vResponse:="There are no items is your shopping cart."
		
	Else 
		//$shipVia:=WCapi_GetParameter("shipVia";"")
		//$custPO:=WCapi_GetParameter("CustRFQ";"")
		//$needDate:=WCapi_GetParameter("NeedDate";"")
		//$needTime:=WCapi_GetParameter("NeedTime";"")
		//$jitPageOne:=WCapi_GetParameter("jitPageOne";"")
		CREATE RECORD:C68([Proposal:42])
		[Proposal:42]adSource:47:="WebClerk"
		[Proposal:42]requestedBy:62:=[RemoteUser:57]userName:2
		myCycle:=3
		TRACE:C157
		vHere:=3  //clear by the end
		[Proposal:42]customerID:1:=[Customer:2]customerID:1
		NxPvProposals(False:C215)  //build order with or without saving
		
		WC_Parse(Table:C252(->[Proposal:42]); $2; True:C214)  //  
		
		If ([Proposal:42]idNum:5=0)
			//vResponse:="Proposal not processed.  Likely no FC."
		Else 
			//[Proposal]ProposalNum:=CounterNew (->[Proposal])
			[Proposal:42]takenBy:61:=Current user:C182
			If ($shipVia#"")
				$w:=Find in array:C230(<>aShipVia; $shipVia)
				If ($w>0)
					[Proposal:42]shipVia:18:=$shipVia
				End if 
			End if 
			C_DATE:C307($ordDate)
			$ordDate:=Date_GoFigure($needDate)
			If ($ordDate>=Current date:C33)
				[Proposal:42]dateNeeded:4:=$ordDate
			End if 
			myCycle:=0
			If ($doDebug)
				//ALERT("Date_GoFigure")
				//SEND PACKET(myDoc;"Date_GoFigure"+"\r")
			End if 
			//
			C_LONGINT:C283($pValBeg)
			C_POINTER:C301($ptVar)
			[Proposal:42]profile1:51:=vText10
			vText10:=""  //set in Http_OldCust
			viPrplLnCnt:=0
			If ($doDebug)
				ALERT:C41("Lines")
				//SEND PACKET(myDoc;"PpLnAdd"+"\r")
			End if 
			TRACE:C157
			For ($i; 1; $k)
				$pQtyOrd:=[zzzWebTempRec:101]qtyOrdered:4
				QUERY:C277([Item:4]; [Item:4]itemNum:1=[zzzWebTempRec:101]itemNum:3)
				
				If ($doDebug)
					//SEND PACKET(myDoc;[WebTempRec]ItemNum+"\r")
				End if 
				pPartNum:=[Item:4]itemNum:1
				pDescript:=[zzzWebTempRec:101]description:15
				[Item:4]qtySaleDefault:15:=$pQtyOrd
				//viPrplLnCnt:=viPrplLnCnt+1
				PpLnAdd((Size of array:C274(aPLineNum)+1); 1; False:C215)
				PpLnExtend(viPrplLnCnt)
				Http_ItemAdds(pvItemNum; [zzzWebTempRec:101]addsDescripts:20; $pQtyOrd; aPLineAction)
				
				If ($doDebug)
					ALERT:C41("PpLnAdd")
					//SEND PACKET(myDoc;"PpLnAdd"+"\r")
				End if 
				//      
				aPLnComment{viPrplLnCnt}:=pvLnComment
				aPProfile1{viPrplLnCnt}:=pvLnProfile1
				apProfile2{viPrplLnCnt}:=pvLnProfile2
				apProfile3{viPrplLnCnt}:=pvLnProfile3
				[zzzWebTempRec:101]posted:5:=True:C214
				SAVE RECORD:C53([zzzWebTempRec:101])
				NEXT RECORD:C51([zzzWebTempRec:101])
			End for 
			If ($doDebug)
				ALERT:C41("Find Ship Zone")
				//SEND PACKET(myDoc;"PpLnAdd"+"\r")
			End if 
			If ([Proposal:42]zone:19<1)
				Find Ship Zone(->[Proposal:42]zip:16; ->[Proposal:42]zone:19; ->[Proposal:42]shipVia:18; ->[Proposal:42]country:17; ->[Proposal:42]siteID:77)
			End if 
			booAccept:=True:C214
			If ($doDebug)
				ALERT:C41("acceptPropsl")
				//SEND PACKET(myDoc;"PpLnAdd"+"\r")
			End if 
			vMod:=True:C214
			acceptPropsl
			//
			If ($doDebug)
				ALERT:C41("$endingExecute")
				//SEND PACKET(myDoc;"PpLnAdd"+"\r")
			End if 
			$endingExecute:=WCapi_GetParameter("ScriptEnd"; "")
			If ($endingExecute#"")
				Execute_TallyMaster("Proposals_New"; $endingExecute)
			End if 
			
			C_TEXT:C284($eventID)
			$eventID:=obEventLog.id
			
			
			// Modified by: Bill James (2017-04-27T00:00:00)
			// Removed the duplicating of the EventLog record.
			// 
			TRACE:C157
			
			
			[EventLog:75]qty:6:=0
			[EventLog:75]value:7:=0
			
			
			SAVE RECORD:C53([EventLog:75])
			
			
			vMod:=False:C215
			booAccept:=False:C215
			$doPage:=WC_DoPage("ProposalsOne.html"; $jitPageOne)  //already sent in http_saveWO    
			
			$emailConfirm:=WCapi_GetParameter("EmailConfirm"; "")
			If ($emailConfirm#"N@")
				SMTP_SentBy([Proposal:42]salesNameID:9; [Customer:2]salesNameID:59; "email")
				If ([RemoteUser:57]email:14#"")
					vtEmailReceiver:=[RemoteUser:57]email:14
				Else 
					vtEmailReceiver:=[Customer:2]email:81
				End if 
				vtEmailSubject:="Web Order "+String:C10([Proposal:42]idNum:5; "0000-0000")
				
				READ ONLY:C145([TallyMaster:60])
				QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8="WebClerk_NewProposal"; *)  //"WebClerk_NewOrder""
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="WebClerk_Auto")
				If (Records in selection:C76([TallyMaster:60])=0)
					vtEmailBody:=vtEmailSubject+"\r"+"\r"+"Placed   "+String:C10(Current date:C33)+":  "+String:C10(Current time:C178)
					$theVar:=<>tcMONEYCHAR+String:C10([Proposal:42]amount:26; "###,###,##0.00")
					$thePad:=" "*(20-Length:C16($theVar))
					vtEmailBody:=vtEmailBody+"\r"+"\r"+"Amount   "+$thePad+$theVar
					$theVar:=<>tcMONEYCHAR+String:C10([Proposal:42]salesTax:27; "###,###,##0.00")
					$thePad:=" "*(20-Length:C16($theVar))
					vtEmailBody:=vtEmailBody+"\r"+"Tax      "+$thePad+$theVar
					$theVar:=<>tcMONEYCHAR+String:C10([Proposal:42]shipTotal:31; "###,###,##0.00")
					$thePad:=" "*(20-Length:C16($theVar))
					vtEmailBody:=vtEmailBody+"\r"+"Shipping "+$thePad+$theVar
					$theVar:=<>tcMONEYCHAR+String:C10([Proposal:42]total:32; "###,###,##0.00")
					$thePad:=" "*(20-Length:C16($theVar))
					vtEmailBody:=vtEmailBody+"\r"+"Total    "+$thePad+$theVar
					vtEmailBody:=vtEmailBody+"\r"+"\r"+"Thank you.  Visit us again:  http://"+Storage:C1525.default.domain
					vtEmailPath:=""
				Else 
					vtEmailBody:=[TallyMaster:60]build:6
					
					If ([TallyMaster:60]script:9#"")
						ExecuteText(0; [TallyMaster:60]script:9)
					End if   //TallyMaster will be released in the execute of script
					vtEmailBody:=TagsToText(vtEmailBody)
					REDUCE SELECTION:C351([TallyMaster:60]; 0)
					READ WRITE:C146([TallyMaster:60])
				End if 
				SMTP_SendMsg  //primary send
				eMail_Notices($moreComments)  //send copy emails
				vtEmailSubject:=""
				vtEmailBody:=""
				vtEmailPath:=""
				//
				vText4:=""
				
				
			End if 
			
			
			If ($doDebug)
				ALERT:C41("P_PpHeadVars")
				//SEND PACKET(myDoc;"PpLnAdd"+"\r")
			End if 
			
			If ($doDebug)
				ALERT:C41("P_PpHeadVars")
				//SEND PACKET(myDoc;"PpLnAdd"+"\r")
			End if 
			P_PpHeadVars
		End if 
	End if 
	
End if 
If ($doDebug)
	ALERT:C41("Page")
	//SEND PACKET(myDoc;"PpLnAdd"+"\r")
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)
vHere:=0