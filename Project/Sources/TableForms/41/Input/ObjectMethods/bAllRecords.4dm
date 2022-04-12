
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 12/26/18, 14:58:04
// ----------------------------------------------------
// Method: [Counter].Input.bAllRecords
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($script)
$script:="ALL RECORDS(Table("+String:C10([QQQCounter:41]TableNum:4)+")->)"
ProcessTableOpen([QQQCounter:41]TableNum:4; $script; "Testing Counters")