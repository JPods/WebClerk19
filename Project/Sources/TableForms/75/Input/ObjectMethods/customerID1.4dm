
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/15/18, 17:42:32
// ----------------------------------------------------
// Method: [EventLog].Input.customerID
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($script)
$script:="QUERY([Customer];[Customer]customerID=\""+[EventLog:75]customerid:38+"\")"
ProcessTableOpen(Table:C252(->[Customer:2]); $script; "EventLogs "+String:C10([EventLog:75]idNum:5))