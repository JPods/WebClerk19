
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-04-13T00:00:00, 21:13:09
// ----------------------------------------------------
// Method: [Counter].Input1.Variable31
// Description
// Modified: 04/13/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
vText1:=String:C10([QQQCounter:41]TableNum:4)
ProcessTableOpen(Table:C252(->[CounterPending:135]); "QUERY([CounterPending];[CounterPending]TableNum="+vText1+")"; " "+[QQQCounter:41]TableName:2)
