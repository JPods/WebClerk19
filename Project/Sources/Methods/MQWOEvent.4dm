//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/22/18, 19:17:58
// ----------------------------------------------------
// Method: MQWOEvent
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $action)
$action:=$1
// ### bj ### 20201127_2203
CREATE RECORD:C68([WorkOrderEvent:121])
[WorkOrderEvent:121]woNum:5:=[WorkOrder:66]woNum:29
[WorkOrderEvent:121]timeOrig:2:=DateTime_Enter
[WorkOrderEvent:121]table1id:10:=[WorkOrder:66]id:66
[WorkOrderEvent:121]table1:6:="WorkOrder"
//[WorkOrderEvent]Lat:=[WorkOrder]lat
//[WorkOrderEvent]Lng:=[WorkOrder]lat
[WorkOrderEvent:121]actionBy:15:=Current user:C182
[WorkOrderEvent:121]action:4:=$action  // "API_ADD_AND_LINK_WORK"

SAVE RECORD:C53([WorkOrderEvent:121])

// note unload the record when completed with it.