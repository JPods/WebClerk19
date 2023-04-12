//%attributes = {}

// Depricate_yyy by: Bill James (2022-12-13T06:00:00Z)
//// ----------------------------------------------------
//// User name (OS): williamjames
//// Date and time: 07/06/11, 06:09:09
//// ----------------------------------------------------
//// Method: WCCInvoiceShoppingCart
//// Description
//// 
////
//// Parameters
//// ----------------------------------------------------


//C_TEXT($myText)
//C_LONGINT($p; $theFile; $theField; $testFile; $pEnd; $w; $1)
//C_POINTER($2)
////C_BOOLEAN($3)
//$suffix:=""
//vResponse:="Shopping cart to Invoice."
//$doPage:=WC_DoPage("Error"+$suffix+".html"; "")
////zttp_UserGet (1)
//$doDebug:=False
////myDoc:=create document(Storage.folder.jitDebug+"PP_"+String(Records in table([Invoice])))
//If (Record number([Customer])<0)
//vResponse:="Must be signed in as a customer, contact or lead to use this feature."

//Else 
//QUERY([zzzWebTempRec]; [zzzWebTempRec]idEventLog=vleventID; *)
//QUERY([zzzWebTempRec];  & [zzzWebTempRec]qtyOrdered#0; *)
//QUERY([zzzWebTempRec];  & [zzzWebTempRec]posted=False)
//$k:=Records in selection([zzzWebTempRec])
//FIRST RECORD([zzzWebTempRec])
//If (Records in selection([zzzWebTempRec])=0)
//vResponse:="There are no items is your shopping cart."

//Else 
////$shipVia:=WCapi_GetParameter("shipVia";"")
////$custPO:=WCapi_GetParameter("CustRFQ";"")
////$needDate:=WCapi_GetParameter("NeedDate";"")
////$needTime:=WCapi_GetParameter("NeedTime";"")
////$jitPageOne:=WCapi_GetParameter("jitPageOne";"")

//$activeSecurityLevel:=MaxValueReturn(vWccSecurity; viEndUserSecurityLevel)
//QUERY([FC]; [FC]securityLevel=$activeSecurityLevel; *)
//QUERY([FC];  & [FC]tableNum=Table(->[Invoice]))
//$cntFieldCharInvoices:=Records in selection([FC])
//QUERY([FC]; [FC]securityLevel=$activeSecurityLevel; *)
//QUERY([FC];  & [FC]tableNum=Table(->[InvoiceLine]))
//$cntFieldCharInvoiceLines:=Records in selection([FC])
//If (($cntFieldCharInvoices<5) | ($cntFieldCharInvoiceLines<5))
//vResponse:="FC not defined, Invoices: "+String($cntFieldCharInvoices)+", InvoiceLines: "+String($cntFieldCharInvoiceLines)
//Else 
//CREATE RECORD([Invoice])
//[Invoice]adSource:="WebClerk"
//[Invoice]attention:=[Customer]company

//myCycle:=3

//vHere:=3  //clear by the end
//ptCurTable:=(->[Invoice])  //so ->[Order] does not carry accross from somewhere else
//$booOK:=NxPvInvAccess

//$doMore:=True
//NxPvInvoices


//WC_Parse(Table(->[Invoice]); $2; True)  //  

//If ([Invoice]idNum=0)
////vResponse:="Proposal not processed.  Likely no FC."
//Else 
//[Invoice]dateShipped:=Current date
//myCycle:=0
//If ($doDebug)
////ALERT("Date_GoFigure")
////SEND PACKET(myDoc;"Date_GoFigure"+"\r")
//End if 
////
//C_LONGINT($pValBeg)
//C_POINTER($ptVar)
//[Invoice]profile1:=vText10
//vText10:=""  //set in Http_OldCust
//viPrplLnCnt:=0
//aiLineAction:=0

//For ($i; 1; $k)
//$pQtyOrd:=[zzzWebTempRec]qtyOrdered
//QUERY([Item]; [Item]itemNum=[zzzWebTempRec]itemNum)

//If ($doDebug)
////SEND PACKET(myDoc;[WebTempRec]ItemNum+"\r")
//End if 
//pPartNum:=[Item]itemNum
//pDescript:=[zzzWebTempRec]description
//[Item]qtySaleDefault:=$pQtyOrd
//pUnitCost:=[Item]costAverage
//IvcLnAdd((Size of array(aiLineAction)+1); 1; False)


//aiLnComment{aiLineAction}:=[zzzWebTempRec]comment
//aiProfile1{aiLineAction}:=[zzzWebTempRec]profile1
//aiProfile2{aiLineAction}:=[zzzWebTempRec]profile2
//aiProfile3{aiLineAction}:=[zzzWebTempRec]profile3
//aiDescpt{aiLineAction}:=[zzzWebTempRec]description
//aiUnitPrice{aiLineAction}:=[zzzWebTempRec]discountedPrice
//pBasePrice:=[zzzWebTempRec]discountedPrice
//pUnitPrice:=[zzzWebTempRec]discountedPrice
//vLineMod:=True
//IvcLnExtend(aiLineAction)
////Http_ItemAdds (pvItemNum;[WebTempRec]AddsDescripts;$pQtyOrd;aPLineAction)

//[zzzWebTempRec]posted:=True
//SAVE RECORD([zzzWebTempRec])
//NEXT RECORD([zzzWebTempRec])
//End for 
//If ($doDebug)
//ALERT("Find Ship Zone")
////SEND PACKET(myDoc;"PpLnAdd"+"\r")
//End if 
//If ([Invoice]zone<1)
//Find Ship Zone(->[Invoice]zip; ->[Invoice]zone; ->[Invoice]shipVia; ->[Invoice]country; ->[Invoice]siteID)
//End if 
//booAccept:=True
//If ($doDebug)
//ALERT("acceptPropsl")
////SEND PACKET(myDoc;"PpLnAdd"+"\r")
//End if 
//vMod:=True
//acceptInvoice
////

//If ($doDebug)
//ALERT("$endingExecute")
////SEND PACKET(myDoc;"PpLnAdd"+"\r")
//End if 
//$endingExecute:=WCapi_GetParameter("ScriptEnd"; "")
//If ($endingExecute#"")
//Execute_TallyMaster("Invoices_New"; $endingExecute)
//End if 

//C_TEXT($eventID)

//// Modified by: Bill James (2017-04-27T00:00:00)


//TRACE
//[EventLog]qty:=0
//[EventLog]value:=0
//If ([EventLog]idNum#0)
//SAVE RECORD([EventLog])
//End if 
//End if 
//vMod:=False
//booAccept:=False
//$doPage:=WC_DoPage("WccInvoicesOne.html"; $jitPageOne)  //already sent in http_saveWO    

//$emailConfirm:=WCapi_GetParameter("EmailConfirm"; "")
//If ($emailConfirm#"N@")
//SMTP_SentBy([Invoice]salesNameID; [Customer]salesNameID; "email")
//If ([RemoteUser]email#"")
//vtEmailReceiver:=[RemoteUser]email
//Else 
//vtEmailReceiver:=[Customer]email
//End if 
//vtEmailSubject:="Web Invoice "+String([Invoice]idNum; "0000-0000")

//READ ONLY([TallyMaster])
//QUERY([TallyMaster]; [TallyMaster]name="WebClerk_NewInvoice"; *)  //"WebClerk_NewOrder""
//QUERY([TallyMaster];  & [TallyMaster]purpose="WebClerk_Auto")
//If (Records in selection([TallyMaster])=0)
//vtEmailBody:=vtEmailSubject+"\r"+"\r"+"Placed   "+String(Current date)+":  "+String(Current time)
//$theVar:=<>tcMONEYCHAR+String([Invoice]amount; "###,###,##0.00")
//$thePad:=" "*(20-Length($theVar))
//vtEmailBody:=vtEmailBody+"\r"+"\r"+"Amount   "+$thePad+$theVar
//$theVar:=<>tcMONEYCHAR+String([Invoice]salesTax; "###,###,##0.00")
//$thePad:=" "*(20-Length($theVar))
//vtEmailBody:=vtEmailBody+"\r"+"Tax      "+$thePad+$theVar
//$theVar:=<>tcMONEYCHAR+String([Invoice]shipTotal; "###,###,##0.00")
//$thePad:=" "*(20-Length($theVar))
//vtEmailBody:=vtEmailBody+"\r"+"Shipping "+$thePad+$theVar
//$theVar:=<>tcMONEYCHAR+String([Invoice]total; "###,###,##0.00")
//$thePad:=" "*(20-Length($theVar))
//vtEmailBody:=vtEmailBody+"\r"+"Total    "+$thePad+$theVar
//vtEmailBody:=vtEmailBody+"\r"+"\r"+"Thank you.  Visit us again:  http://"+Storage.default.domain
//vtEmailPath:=""
//Else 
//vtEmailBody:=[TallyMaster]build
//If ([TallyMaster]script#"")
//ExecuteText(0; [TallyMaster]script)
//End if   //TallyMaster will be released in the execute of script
//vtEmailBody:=TagsToText(vtEmailBody)
//REDUCE SELECTION([TallyMaster]; 0)
//READ WRITE([TallyMaster])
//End if 
//SMTP_SendMsg  //primary send
//eMail_Notices($moreComments)  //send copy emails
//vtEmailSubject:=""
//vtEmailBody:=""
//vtEmailPath:=""
////
//vText4:=""


//End if 


//If ($doDebug)
//ALERT("P_InvHeadVars")
////SEND PACKET(myDoc;"PpLnAdd"+"\r")
//End if 

//If ($doDebug)
//ALERT("P_InvHeadVars")
////SEND PACKET(myDoc;"PpLnAdd"+"\r")
//End if 
//P_PpHeadVars
//End if 
//End if 
//End if 
//If ($doDebug)
//ALERT("Page")
////SEND PACKET(myDoc;"PpLnAdd"+"\r")
//End if 
//$err:=WC_PageSendWithTags($1; $doPage; 0)
//vHere:=0
//ptCurTable:=(->[Base])