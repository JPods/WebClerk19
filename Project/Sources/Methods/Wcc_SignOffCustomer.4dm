//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 04/07/20, 23:37:44
// ----------------------------------------------------
// Method: Wcc_SignOffCustomer
// Description
// 
//
// Parameters
// ----------------------------------------------------



$clearCustomer:="true"
$voTableData:=New object:C1471
$voTableData.action:="Released Customer record: "+[EventLog:75]company:46
$voTableData.idUser:=[EventLog:75]id:54
$voTableData.preferences:=""
$voTableData.role:=""
$voTableData.database:=Storage:C1525.default.company
$voTableData.version:=Storage:C1525.version.rev
$voTableData.error:=""
vResponse:=JSON Stringify:C1217($voTableData)

[EventLog:75]customerRecNum:8:=-1
[EventLog:75]shipToRecordid:35:=0
[EventLog:75]shipToTableNum:34:=0
[EventLog:75]tableNum:9:=-1
[EventLog:75]company:46:=""
[EventLog:75]customerID:38:=""
[EventLog:75]zip:21:=""
REDUCE SELECTION:C351([Customer:2]; 0)

REDUCE SELECTION:C351([Contact:13]; 0)
CustAddress:=""
viEndUserSecurityLevel:=1

GOTO RECORD:C242([RemoteUser:57]; [EventLog:75]wccRemoteUserRec:26)
[EventLog:75]remoteUserRec:10:=[EventLog:75]wccRemoteUserRec:26

SAVE RECORD:C53([EventLog:75])
