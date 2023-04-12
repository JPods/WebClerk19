//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/04/21, 16:39:45
// ----------------------------------------------------
// Method: Login_UserWC
// Description
// 
// Parameters
// ----------------------------------------------------



C_TEXT:C284($vtUserName; $vtPassword; $tableName)
C_OBJECT:C1216(obRemoteUser; $obPrimaryRec; $obResponse; $result_o)
$vtUserName:=WCapi_GetParameter("userName")
If ($vtUserName="")
	$vtUserName:=WCapi_GetParameter("username")
End if 
$vtPassword:=WCapi_GetParameter("password")
$obResponse:=New object:C1471
obRemoteUser:=ds:C1482.RemoteUser.query("userName = :1 AND userPassword = :2"; $vtUserName; $vtPassword).first()
If (obRemoteUser.id=Null:C1517)
	vResponse:="Error: status=401, No matching UserName and Password. Return to signin "
	voState.statusMessage:=vResponse
Else 
	// create a new eventlog for this seccession
	WC_EventLogsCreate
	// generalized in 19
	// QQQZZZQQQ currently only employeed
	// Cleanup of data files -- implement admin process
	var $tableNum : Integer
	If (ds:C1482[obRemoteUser.tableName]=Null:C1517)
		If ((obRemoteUser.tableNum>0) & (obRemoteUser.tableNum<=Get last table number:C254))
			obRemoteUser.tableName:=Table name:C256(obRemoteUser.tableNum)
			obRemoteUser.save()
		End if 
	End if 
	If (ds:C1482[obRemoteUser.tableName]=Null:C1517)
		vResponse:="Error: status=402, RemoteUser with no Primary table"
		ConsoleLog("Error: Orphaned RemoteUser Record userName: "+$vtUserName+", password: "+$vtPassword)
		obRemoteUser.status:="Orphaned"
		obRemoteUser.save()
		voState.statusMessage:=vResponse
	Else 
		$obPrimaryRec:=ds:C1482[obRemoteUser.tableName].query("id = :1"; obRemoteUser.idPrimary).first()
		Case of 
			: ($obPrimaryRec=Null:C1517)
				vResponse:="Error: status=401, Orphaned RemoteUser Record"
				ConsoleLog("Error: Orphaned RemoteUser Record userName: "+$vtUserName+", password: "+$vtPassword)
				obRemoteUser.status:="Orphaned"
				obRemoteUser.save()
				voState.statusMessage:=vResponse
				
			: (obRemoteUser.tableName="Employee")  // (obRemoteUser.tableName="Employee") | (obRemoteUser.tableName="Rep"))
				C_OBJECT:C1216(obEventLog)
				
				If (False:C215)
					// change to eventLog ds
					If (obEventLog.id=Null:C1517)  // should already exist
						obEventLog:=ds:C1482.EventLog.new()
						$result_o:=obEventLog.save()
					End if 
				End if 
				
				voState.statusMessage:="Successful login"
				obRemoteUser.dtLastVisit:=DateTime_DTTo
				obRemoteUser.role:=$obPrimaryRec.role
				obRemoteUser.route:=$obPrimaryRec.route
				obRemoteUser.email:=$obPrimaryRec.email
				If ($obPrimaryRec.groups#Null:C1517)
					obRemoteUser.groups:=$obPrimaryRec.groups
				End if 
				obRemoteUser.countLogIns:=obRemoteUser.countLogIns+1
				obRemoteUser.save()
				Login_FillEventLog
				Login_FIllUserTovoState
				vResponse:=LogIn_ReplyEmployee
				
				If (<>viDebugMode>410)
					ConsoleLog("Successful login vResponse: "+vResponse)
				End if 
				//:(obRemoteUser.tableName="Vendor")
				
				//:(obRemoteUser.tableName="Contact")
				
				//:(obRemoteUser.tableName="Manufacturer")
				
			Else 
				$obResponse.tableName:=$tableName
				//voState.userWCC:=New object("id"; ""; "tableName"; "securityLevel"; 0; "idRemote"; ""; "role"; ""; "route"; "")
				//voState.user:=New object("id"; ""; "tableName"; "securityLevel"; 0; "idRemote"; ""; "role"; ""; "route"; "", "lat"; 0; "lng"; 0)
				C_OBJECT:C1216(obEventLog)
				If (obEventLog.id=Null:C1517)  // should already exist
					obEventLog:=ds:C1482.EventLog.new()
					$result_o:=obEventLog.save()
				End if 
				voState.statusMessage:="Successful login"
				obRemoteUser.dtLastVisit:=DateTime_DTTo
				obRemoteUser.role:=$obPrimaryRec.role
				obRemoteUser.route:=$obPrimaryRec.route
				obRemoteUser.email:=$obPrimaryRec.email
				If ($obPrimaryRec.groups#Null:C1517)
					obRemoteUser.groups:=$obPrimaryRec.groups
				End if 
				obRemoteUser.countLogIns:=obRemoteUser.countLogIns+1
				obRemoteUser.save()
				$result_o:=obEventLog.save()
				
				
				Login_FIllUserTovoState
				
				
				// LogIn_ReplyEmployee for other table users
				// ### bj ### 20211103_2242
				// this is none functional, make it work for customers
				
				If (<>viDebugMode>410)
					ConsoleLog("Successful login "+obRemoteUser.tableName)
				End if 
		End case 
	End if 
End if 
obRemoteUser.idEventLog:=obEventLog.id
$result_o:=obRemoteUser.save()
If (<>viDebugMode>410)
	ConsoleLog("Login save RemoteUser: "+JSON Stringify:C1217($result_o))
End if 

obEventLog.idRemoteUser:=obRemoteUser.id
$result_o:=obEventLog.save()
If (<>viDebugMode>410)
	ConsoleLog("Login save EventLog: "+JSON Stringify:C1217($result_o))
End if 
WC_SendServerResponse(vResponse; "application/json")
vResponse:="AlreadySent"

