//%attributes = {}




//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/22/21, 09:51:59
// ----------------------------------------------------
// Method: WccUserLogIn
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($vtUserName; $vtPassword)
$vtUserName:=WCapi_GetParameter("userName")
If ($vtUserName="")
	$vtUserName:=WCapi_GetParameter("username")
End if 
$vtPassword:=WCapi_GetParameter("password")
QUERY:C277([RemoteUser:57]; [RemoteUser:57]userName:2=$vtUserName; *)
QUERY:C277([RemoteUser:57];  & ; [RemoteUser:57]userPassword:3=$vtPassword)
If (Records in selection:C76([RemoteUser:57])=1)
	C_TEXT:C284($vtPage)
	$vtPage:=RemoteUser_SetEventLog
	voState.route:=$vtPage
	voState.statusMessage:="Successful login"
	voState.url:="EmployeesOne.html"
	[EventLog:75]idRemoteUser:60:=[RemoteUser:57]id:27
	SAVE RECORD:C53([EventLog:75])
End if 

$voTableData:=New object:C1471
//$voTableData.remoteUser:=New object("route";$vtPage)
$voTableData.idUser:=[EventLog:75]id:54
$voTableData.preferences:=""
$voTableData.role:=[RemoteUser:57]role:25
$voTableData.version:=Storage:C1525.version.rev

$voTableData.company:=New object:C1471("Company"; Storage:C1525.default.company; "Address"; Storage:C1525.default.address; "Phone"; Storage:C1525.default.phone; "Fax"; Storage:C1525.default.fax; "Email"; Storage:C1525.default.email)
C_OBJECT:C1216($obSel)
$obSel:=ds:C1482.Default.query("primeDefault=1")
$voTableData.company.lat:=$obSel.first().lat
$voTableData.company.lng:=$obSel.first().lng

C_OBJECT:C1216($voUser)

$voUser:=New object:C1471
$voUser.idUser:=obEventLog.id
$voUser.idRemote:=obRemoteUser.id
$voUser.role:=obRemoteUser.role
$voUser.securityLevel:=obRemoteUser.securityLevel
$voUser.name:=obRemoteUser.userName
$voUser.tableName:=Table name:C256(obRemoteUser.tableNum)


$voTableData.user:=voUser
$voTableData.statusConnect:="OK"
vResponse:=JSON Stringify:C1217($voTableData)
//


