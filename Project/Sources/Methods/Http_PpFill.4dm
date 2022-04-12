//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/29/19, 16:11:45
// ----------------------------------------------------
// Method: Http_PpFill
// Description
// 
//
// Parameters
// ----------------------------------------------------



C_TEXT:C284($myText)
C_LONGINT:C283($p; $theFile; $theField; $testFile; $pEnd; $w; $1)
C_POINTER:C301($2)
C_BOOLEAN:C305($3)
$shipVia:=WCapi_GetParameter("shipVia"; "")
$custPO:=WCapi_GetParameter("CustRFQ"; "")
$needDate:=WCapi_GetParameter("NeedDate"; "")
$needTime:=WCapi_GetParameter("NeedTime"; "")
[Proposal:42]adSource:47:="WebClerk"
[Proposal:42]requestedBy:62:=[RemoteUser:57]userName:2
CREATE RECORD:C68([Proposal:42])
WC_Parse(Table:C252(->[Proposal:42]); $2)  //  

If ([Order:3]shipVia:13#"")
	$shipVia:=[Order:3]shipVia:13
End if 
If ($shipVia#"")
	$w:=Find in array:C230(<>aShipVia; $shipVia)
	If ($w>0)
		[Order:3]shipVia:13:=$shipVia
	Else 
		[Order:3]shipVia:13:=[Customer:2]shipVia:12
	End if 
End if 
C_TEXT:C284(tcShipMissing; tcTaxMissing)
$w:=Find in array:C230(<>aShipVia; [Order:3]shipVia:13)
If ($w>0)
	tcShipMissing:=""
Else 
	tcShipMissing:="Shipping not calculated"
End if 
$w:=Find in array:C230(<>aTaxJuris; [Order:3]taxJuris:43)
If ($w>0)
	tcTaxMissing:=""
Else 
	tcTaxMissing:="Tax not calculated"
End if 



[Proposal:42]takenBy:61:="WebClerk"
myCycle:=3
NxPvProposals  //build order with or without saving
If (Date:C102($needDate)>=Current date:C33)
	[Proposal:42]dateNeeded:4:=Date:C102($needDate)
End if 
myCycle:=0
//
$myText:=[EventLog:75]message:4
$p:=Position:C15("Name="; $myText)
[Proposal:42]profile1:51:=vText10
vText10:=""  //set in Http_OldCust
viPrplLnCnt:=0
While ($p>0)
	$myText:=Substring:C12($myText; $p+6)  //add 1 extra for Quote
	$p:=Position:C15(";"; $myText)
	pPartNum:=Substring:C12($myText; 1; $p-1)
	QUERY:C277([Item:4]; [Item:4]itemNum:1=pPartNum)
	pDescript:=[Item:4]description:7
	$pEnd:=Position:C15("!"; $myText)
	$pUnitPrice:=Num:C11(Substring:C12($myText; $p+1; $pEnd-1))
	$p:=Position:C15("Value="; $myText)
	$myText:=Substring:C12($myText; $p+7)  //add 1 extra for Quote
	$pEnd:=Position:C15(Char:C90(34); $myText)
	$pQtyOrd:=Num:C11(Substring:C12($myText; 1; $pEnd-1))
	[Item:4]qtySaleDefault:15:=$pQtyOrd  //do not save item
	//viOrdLnCnt:=viOrdLnCnt+1
	PpLnAdd((Size of array:C274(aPLineAction)+1); 1; False:C215)
	//aOQtyOrder{aoLineAction}:=$pQtyOrd
	//aOUnitPrice{aoLineAction}:=$pUnitPrice
	//check this by authority level
	//aODiscnt{aoLineAction}:=0
	PpLnExtend(aPLineAction)
	$p:=Position:C15("Name="; $myText)
End while 

If ([Proposal:42]zone:19<1)
	Find Ship Zone(->[Proposal:42]zip:16; ->[Proposal:42]zone:19; ->[Proposal:42]shipVia:18; ->[Proposal:42]country:17; ->[Proposal:42]siteid:77)
End if 
If ($3)
	vMod:=True:C214
	booAccept:=True:C214
	acceptPropsl
	//
	//C_TEXT($eventID)
	C_LONGINT:C283($eventID)
	
	//[EventLog]eventID:="Pp_"+String([Proposal]ProposalNum)
	// need to keep eventID to relate WebTemp
	[EventLog:75]tableNumTarget:53:=Table:C252(->[Proposal:42])
	[EventLog:75]targetRecordNum:52:=Record number:C243([Proposal:42])
	SAVE RECORD:C53([EventLog:75])
	// ### bj ### 20181115_1546
	// WC_DupicateEventLog
	WC_EventLogReplace("Http_PpFill")
	
	SAVE RECORD:C53([EventLog:75])
	
Else 
	booAccept:=True:C214
	vMod:=calcProposal(True:C214)
End if 
vMod:=False:C215
booAccept:=False:C215