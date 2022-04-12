//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-05-01T00:00:00, 17:43:38
// ----------------------------------------------------
// Method: RptPastDue
// Description
// Modified: 05/01/17
// 
// 
//
// Parameters
// ----------------------------------------------------

//Begin Example:  Procedure or Menu Call directly into a new process

ProcessInitTestFix

// end example

QUERY:C277([Customer:2]; [Customer:2]balanceDue:42#0)
ORDER BY:C49([Customer:2]; [Customer:2]balPastPeriod3:45; <; [Customer:2]balPastPeriod2:44; <; [Customer:2]balPastPeriod1:43; <)
MESSAGES ON:C181
jsetDefaultFile(->[Customer:2])
FORM SET OUTPUT:C54([Customer:2]; "oPastDue_9")
vOverDueBy:=""
booSorted:=True:C214
<>prcControl:=202  //force to output layout  "oPastDue_9"
MODIFY SELECTION:C204([Customer:2])
//ProcessTableOpen (->[Customer])
FORM SET OUTPUT:C54([Customer:2]; "Output")