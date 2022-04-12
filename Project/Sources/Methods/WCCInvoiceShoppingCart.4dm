//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/06/11, 06:09:09
// ----------------------------------------------------
// Method: WCCInvoiceShoppingCart
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($myText)
C_LONGINT:C283($p; $theFile; $theField; $testFile; $pEnd; $w; $1)
C_POINTER:C301($2)
//C_BOOLEAN($3)
$suffix:=""
vResponse:="Shopping cart to Invoice."
$doPage:=WC_DoPage("Error"+$suffix+".html"; "")
//zttp_UserGet (1)
$doDebug:=False:C215
//myDoc:=create document(Storage.folder.jitDebug+"PP_"+String(Records in table([Invoice])))
If (Record number:C243([Customer:2])<0)
	vResponse:="Must be signed in as a customer, contact or lead to use this feature."
	
Else 
	QUERY:C277([WebTempRec:101]; [WebTempRec:101]idEventLog:1=vleventID; *)
	QUERY:C277([WebTempRec:101];  & [WebTempRec:101]qtyOrdered:4#0; *)
	QUERY:C277([WebTempRec:101];  & [WebTempRec:101]posted:5=False:C215)
	$k:=Records in selection:C76([WebTempRec:101])
	FIRST RECORD:C50([WebTempRec:101])
	If (Records in selection:C76([WebTempRec:101])=0)
		vResponse:="There are no items is your shopping cart."
		
	Else 
		//$shipVia:=WCapi_GetParameter("shipVia";"")
		//$custPO:=WCapi_GetParameter("CustRFQ";"")
		//$needDate:=WCapi_GetParameter("NeedDate";"")
		//$needTime:=WCapi_GetParameter("NeedTime";"")
		//$jitPageOne:=WCapi_GetParameter("jitPageOne";"")
		
		$activeSecurityLevel:=MaxValueReturn(vWccSecurity; viEndUserSecurityLevel)
		QUERY:C277([FieldCharacteristic:94]; [FieldCharacteristic:94]securityLevel:3=$activeSecurityLevel; *)
		QUERY:C277([FieldCharacteristic:94];  & [FieldCharacteristic:94]tableNum:1=Table:C252(->[Invoice:26]))
		$cntFieldCharInvoices:=Records in selection:C76([FieldCharacteristic:94])
		QUERY:C277([FieldCharacteristic:94]; [FieldCharacteristic:94]securityLevel:3=$activeSecurityLevel; *)
		QUERY:C277([FieldCharacteristic:94];  & [FieldCharacteristic:94]tableNum:1=Table:C252(->[InvoiceLine:54]))
		$cntFieldCharInvoiceLines:=Records in selection:C76([FieldCharacteristic:94])
		If (($cntFieldCharInvoices<5) | ($cntFieldCharInvoiceLines<5))
			vResponse:="FieldCharacteristics not defined, Invoices: "+String:C10($cntFieldCharInvoices)+", InvoiceLines: "+String:C10($cntFieldCharInvoiceLines)
		Else 
			CREATE RECORD:C68([Invoice:26])
			[Invoice:26]adSource:52:="WebClerk"
			[Invoice:26]attention:38:=[Customer:2]company:2
			
			myCycle:=3
			
			vHere:=3  //clear by the end
			ptCurTable:=(->[Invoice:26])  //so ->[Order] does not carry accross from somewhere else
			$booOK:=NxPvInvAccess
			
			$doMore:=True:C214
			NxPvInvoices
			
			
			WC_Parse(Table:C252(->[Invoice:26]); $2; True:C214)  //  
			
			If ([Invoice:26]invoiceNum:2=0)
				//vResponse:="Proposal not processed.  Likely no FieldCharacteristics."
			Else 
				[Invoice:26]dateShipped:4:=Current date:C33
				myCycle:=0
				If ($doDebug)
					//ALERT("Date_GoFigure")
					//SEND PACKET(myDoc;"Date_GoFigure"+"\r")
				End if 
				//
				C_LONGINT:C283($pValBeg)
				C_POINTER:C301($ptVar)
				[Invoice:26]profile1:53:=vText10
				vText10:=""  //set in Http_OldCust
				viPrplLnCnt:=0
				aiLineAction:=0
				
				For ($i; 1; $k)
					$pQtyOrd:=[WebTempRec:101]qtyOrdered:4
					QUERY:C277([Item:4]; [Item:4]itemNum:1=[WebTempRec:101]itemNum:3)
					
					If ($doDebug)
						//SEND PACKET(myDoc;[WebTempRec]ItemNum+"\r")
					End if 
					pPartNum:=[Item:4]itemNum:1
					pDescript:=[WebTempRec:101]description:15
					[Item:4]qtySaleDefault:15:=$pQtyOrd
					pUnitCost:=[Item:4]costAverage:13
					IvcLnAdd((Size of array:C274(aiLineAction)+1); 1; False:C215)
					
					
					aiLnComment{aiLineAction}:=[WebTempRec:101]comment:13
					aiProfile1{aiLineAction}:=[WebTempRec:101]profile1:7
					aiProfile2{aiLineAction}:=[WebTempRec:101]profile2:8
					aiProfile3{aiLineAction}:=[WebTempRec:101]profile3:9
					aiDescpt{aiLineAction}:=[WebTempRec:101]description:15
					aiUnitPrice{aiLineAction}:=[WebTempRec:101]discountedPrice:10
					pBasePrice:=[WebTempRec:101]discountedPrice:10
					pUnitPrice:=[WebTempRec:101]discountedPrice:10
					vLineMod:=True:C214
					IvcLnExtend(aiLineAction)
					//Http_ItemAdds (pvItemNum;[WebTempRec]AddsDescripts;$pQtyOrd;aPLineAction)
					
					[WebTempRec:101]posted:5:=True:C214
					SAVE RECORD:C53([WebTempRec:101])
					NEXT RECORD:C51([WebTempRec:101])
				End for 
				If ($doDebug)
					ALERT:C41("Find Ship Zone")
					//SEND PACKET(myDoc;"PpLnAdd"+"\r")
				End if 
				If ([Invoice:26]zone:6<1)
					Find Ship Zone(->[Invoice:26]zip:12; ->[Invoice:26]zone:6; ->[Invoice:26]shipVia:5; ->[Invoice:26]country:13; ->[Invoice:26]siteID:86)
				End if 
				booAccept:=True:C214
				If ($doDebug)
					ALERT:C41("acceptPropsl")
					//SEND PACKET(myDoc;"PpLnAdd"+"\r")
				End if 
				vMod:=True:C214
				acceptInvoice
				//
				
				If ($doDebug)
					ALERT:C41("$endingExecute")
					//SEND PACKET(myDoc;"PpLnAdd"+"\r")
				End if 
				$endingExecute:=WCapi_GetParameter("ScriptEnd"; "")
				If ($endingExecute#"")
					Execute_TallyMaster("Invoices_New"; $endingExecute)
				End if 
				
				C_TEXT:C284($eventID)
				
				// Modified by: Bill James (2017-04-27T00:00:00)
				
				
				TRACE:C157
				[EventLog:75]qty:6:=0
				[EventLog:75]value:7:=0
				If ([EventLog:75]idNum:5#0)
					SAVE RECORD:C53([EventLog:75])
				End if 
			End if 
			vMod:=False:C215
			booAccept:=False:C215
			$doPage:=WC_DoPage("WccInvoicesOne.html"; $jitPageOne)  //already sent in http_saveWO    
			
			$emailConfirm:=WCapi_GetParameter("EmailConfirm"; "")
			If ($emailConfirm#"N@")
				SMTP_SentBy([Invoice:26]salesNameID:23; [Customer:2]salesNameID:59; "email")
				If ([RemoteUser:57]email:14#"")
					vtEmailReceiver:=[RemoteUser:57]email:14
				Else 
					vtEmailReceiver:=[Customer:2]email:81
				End if 
				vtEmailSubject:="Web Invoice "+String:C10([Invoice:26]invoiceNum:2; "0000-0000")
				
				READ ONLY:C145([TallyMaster:60])
				QUERY:C277([TallyMaster:60]; [TallyMaster:60]name:8="WebClerk_NewInvoice"; *)  //"WebClerk_NewOrder""
				QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="WebClerk_Auto")
				If (Records in selection:C76([TallyMaster:60])=0)
					vtEmailBody:=vtEmailSubject+"\r"+"\r"+"Placed   "+String:C10(Current date:C33)+":  "+String:C10(Current time:C178)
					$theVar:=<>tcMONEYCHAR+String:C10([Invoice:26]amount:14; "###,###,##0.00")
					$thePad:=" "*(20-Length:C16($theVar))
					vtEmailBody:=vtEmailBody+"\r"+"\r"+"Amount   "+$thePad+$theVar
					$theVar:=<>tcMONEYCHAR+String:C10([Invoice:26]salesTax:19; "###,###,##0.00")
					$thePad:=" "*(20-Length:C16($theVar))
					vtEmailBody:=vtEmailBody+"\r"+"Tax      "+$thePad+$theVar
					$theVar:=<>tcMONEYCHAR+String:C10([Invoice:26]shipTotal:20; "###,###,##0.00")
					$thePad:=" "*(20-Length:C16($theVar))
					vtEmailBody:=vtEmailBody+"\r"+"Shipping "+$thePad+$theVar
					$theVar:=<>tcMONEYCHAR+String:C10([Invoice:26]total:18; "###,###,##0.00")
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
				ALERT:C41("P_InvHeadVars")
				//SEND PACKET(myDoc;"PpLnAdd"+"\r")
			End if 
			
			If ($doDebug)
				ALERT:C41("P_InvHeadVars")
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
ptCurTable:=(->[Control:1])