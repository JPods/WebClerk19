//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/12/19, 12:11:26
// ----------------------------------------------------
// Method: WC_EventLogsCreate
// Description
// 
//
// Parameters
// ----------------------------------------------------

$dtNow:=DateTime_Enter

obEventLog:=ds:C1482.EventLog.new()
$result_o:=obEventLog.save()
obEventLog.dateCreated:=Current date:C33
obEventLog.dtEvent:=$dtNow
obEventLog.groupid:="webClerk"
obEventLog.securityLevel:=1

If (False:C215)  // ### bj ### 20210921_1203 
	// remove
	obEventLog.customerRecNum:=-1
	obEventLog.remoteUserRec:=-1
	obEventLog.tableNum:=-1
	obEventLog.wccPrimeUserRec:=-1
	obEventLog.tableNumWccPrime:=0
End if 

obEventLog.securityLevelWCC:=0
C_TEXT:C284($theIPAdddress)
C_LONGINT:C283($theIPPort; $w; $incRay; $cntRay)
$w:=Find in array:C230(aHeaderNameIn; "Referer")
If ($w>0)
	WC_LogEvent("WC_eventID"; aHeaderValueIn{$w})
End if 
//voState.request.cookies.eventID:=obEventLog.eventID
//voState.request.eventID:=obEventLog.eventID
// from WC_RequestHandler
TCP Get Local Address(voState.socket; vWCLocalAddress; vlWCLocalPort)
TCP Get Remote Address(voState.socket; vWCRemoteAddress; $port)
obEventLog.addressIPRemote:=vWCRemoteAddress
obEventLog.addressIPLocal:=vWCLocalAddress
obEventLog.userAgent:=WC_GetHeaderIn("User-Agent")
If (voState.source#Null:C1517)
	obEventLog.source:=voState.source
End if 
//If (<>webAreYouHuman)
//obEventLog.areYouHuman:=Txt_RandomString(4; "0"; "9")
//End if 
obEventLog.hitsTotal:=obEventLog.hitsTotal+1
obEventLog.dtEvent:=$dtNow
obEventLog.dtExpires:=$dtNow+<>vMaxLifeBrowser

If (<>doFlushBuffers)
	FLUSH CACHE:C297
End if 
viSecureLvl:=obEventLog.securityLevel
vlUserRec:=obEventLog.remoteUserRec
$result_o:=obEventLog.save()
voState.eventLog.id:=obEventLog.id

