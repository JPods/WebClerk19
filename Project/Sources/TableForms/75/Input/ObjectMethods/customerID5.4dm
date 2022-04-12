
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
If ([EventLog:75]invoiceNum:12#0)
	$script:="QUERY([Invoice];[Invoice]InvoiceNum="+String:C10([EventLog:75]invoiceNum:12)+")"
	ProcessTableOpen(Table:C252(->[Invoice:26]); $script; "EventLogs "+String:C10([EventLog:75]idNum:5))
End if 