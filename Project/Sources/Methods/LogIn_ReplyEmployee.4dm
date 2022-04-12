//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/04/21, 16:38:16
// ----------------------------------------------------
// Method: LogIn_ReplyEmployee
// Description
// 
// Parameters
// ----------------------------------------------------



C_TEXT:C284($vtPage; $0)
//$vtPage:=RemoteUser_SetEventLog
//$vtPage:="EmployeesOne.html"
voState.route:=obRemoteUser.route
voState.statusMessage:="Successful login"
obEventLog.idRemoteUser:=obRemoteUser.id
$result_o:=obEventLog.save()


$voTableData:=New object:C1471
//$voTableData.remoteUser:=New object("route";$vtPage)
$voTableData.idUser:=obRemoteUser.id
$voTableData.preferences:=""
$voTableData.role:=obRemoteUser.role
$voTableData.version:=Storage:C1525.version.rev

$voTableData.company:=New object:C1471("Company"; Storage:C1525.default.company; "Address"; Storage:C1525.default.address; "Phone"; Storage:C1525.default.phone; "Fax"; Storage:C1525.default.fax; "Email"; Storage:C1525.default.email)
C_OBJECT:C1216($obSel)
$obSel:=ds:C1482.Default.query("primeDefault=1")
$voTableData.company.lat:=$obSel.first().lat
$voTableData.company.lng:=$obSel.first().lng
C_OBJECT:C1216($voUser)

$voUser:=New object:C1471
$voUser.idUser:=obRemoteUser.id
$voUser.idRemote:=obRemoteUser.id
$voUser.role:=obRemoteUser.role
$voUser.securityLevel:=obRemoteUser.securityLevel
$voUser.name:=obRemoteUser.userName
$voUser.tableName:=Table name:C256(obRemoteUser.tableNum)


$voTableData.user:=$voUser
voState.login:=$voTableData
$voTableData.statusConnect:="OK"
$voTableData.status:=200
$0:=JSON Stringify:C1217($voTableData)

