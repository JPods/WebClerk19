//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/03/21, 21:09:31
// ----------------------------------------------------
// Method: WC_EventByID
// Description
// 
// Parameters
// ----------------------------------------------------
var $doHack; $doNewEventLog : Boolean
C_LONGINT:C283($dtNow)
var $cookie_t; $idUser_t : Text

C_OBJECT:C1216(obRemoteUser; obEventLog)
obRemoteUser:=New object:C1471
obEventLog:=New object:C1471
$dtNow:=DateTime_Enter

$doFound:=False:C215
$doHack:=False:C215
If (Storage:C1525.hacks.bypass="yes")
	If (voState.request.parameters.idUser=Null:C1517)
		$doHack:=True:C214
	Else 
		If (voState.request.parameters.idUser="")
			$doHack:=True:C214
		End if 
	End if 
	If ($doHack=True:C214)
		$idUser_t:="DF221D6FCE5D9E468A1F04F1972CF308"
		$doFound:=True:C214
	End if 
End if 

If (<>viDebugMode>=210)
	ConsoleMessage("voState.request.cookies.eventID: "+voState.request.cookies.eventID)
	ConsoleMessage("voState.request.parameters.idUser: "+voState.request.parameters.idUser)
	ConsoleMessage("voState.request.URL.pathName: "+voState.request.URL.pathName)
End if 
$doNewEventLog:=True:C214
// first see if we have a user with a valid event log
If (voState.url="@user/Login@")  // to sign in as customer (voState.url="/User/AsCustomer@")
	Login_UserWC
	WC_SendServerResponse(vResponse; "application/json")
	vResponse:="AlreadySent"
	$doFound:=True:C214
End if 

// has a idUser but it is empty
If ((voState.request.parameters.idUser#Null:C1517) & ($doFound=False:C215))
	$idUser_t:=voState.request.parameters.idUser
	obRemoteUser:=ds:C1482.RemoteUser.query("id = :1"; $idUser_t).first()
	If (obRemoteUser#Null:C1517)
		$doFound:=True:C214
		obEventLog:=ds:C1482.EventLog.query("id = :1"; obRemoteUser.idEventLog).first()
		If (obEventLog#Null:C1517)
			If (obEventLog.dtExpires>$dtNow)
				$doNewEventLog:=False:C215
			Else 
				WC_EventLogsCreate
				Login_FillEventLog
			End if 
		End if 
	End if 
End if 

If ((voState.request.cookies.eventID#Null:C1517) & ($doFound=False:C215))
	If (voState.request.cookies.eventID#"")
		obEventLog:=ds:C1482.EventLog.query("id = :1"; voState.request.cookies.eventID).first()
		If (obEventLog#Null:C1517)
			$doFound:=True:C214
			obRemoteUser:=ds:C1482.RemoteUser.query("id = :1"; obEventLog.idRemoteUser).first()
			If (obEventLog.dtExpires>$dtNow)
				$doNewEventLog:=False:C215
			Else 
				WC_EventLogsCreate  // consider forcing a new sign in
				Login_FillEventLog
			End if 
		End if 
	End if 
End if 

If ($doFound=False:C215)
	WC_EventLogsCreate
	voState.url:="/index.html"
End if 
Login_FIllUserTovoState
voState.eventLog:=New object:C1471
voState.eventLog.id:=obEventLog.id
voState.eventLog.remoteUserRec:=obEventLog.remoteUserRec
voState.eventLog.remoteUserTable:=obEventLog.tableNum
voState.eventLog.remoteLevel:=obEventLog.securityLevel
voState.eventLog.remoteWccUserID:=obEventLog.remoteUserIDwcc
voState.eventLog.remoteWccUserTable:=obEventLog.tableNumWccPrime
voState.eventLog.remoteWccLevel:=obEventLog.securityLevelWCC
voState.eventLog.remoteWccUserRec:=obEventLog.wccRemoteUserRec




