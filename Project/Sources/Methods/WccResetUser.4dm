//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/07/21, 19:56:45
// ----------------------------------------------------
// Method: WccResetUser
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($voRecWeb; $voSelWeb)
$voSelWeb:=ds:C1482.WebTempRec.query("eventID = :1 "; vleventID)
For each ($voRecWeb; $voSelWeb)
	$voRecWeb.posted:=True:C214
	$voRecWeb.save()
End for each 
[EventLog:75]dateComplete:45:=Current date:C33

RemoteUsers_SetVars
$voTableData:=New object:C1471
$voTableData.action:="logged out"
$voTableData.idUser:=[EventLog:75]id:54
$voTableData.preferences:=""
$voTableData.role:=[EventLog:75]proposalNum:57
$voTableData.database:=Storage:C1525.default.company
$voTableData.version:=Storage:C1525.version.rev
$voTableData.company:=New object:C1471("Company"; Storage:C1525.default.company; "Address"; Storage:C1525.default.address; "Phone"; Storage:C1525.default.phone; "Fax"; Storage:C1525.default.fax; "Email"; Storage:C1525.default.email)
init_UserFill
$voTableData.user:=voUser
$voTableData.statusConnect:="Successful"
vResponse:=JSON Stringify:C1217($voTableData)
SAVE RECORD:C53([EventLog:75])
REDUCE SELECTION:C351([RemoteUser:57]; 0)
REDUCE SELECTION:C351([Employee:19]; 0)
REDUCE SELECTION:C351([ManufacturerTerm:111]; 0)
REDUCE SELECTION:C351([Rep:8]; 0)
REDUCE SELECTION:C351([Vendor:38]; 0)
REDUCE SELECTION:C351([Customer:2]; 0)
REDUCE SELECTION:C351([Contact:13]; 0)
REDUCE SELECTION:C351([Lead:48]; 0)
