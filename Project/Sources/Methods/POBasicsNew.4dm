//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/22/19, 09:54:56
// ----------------------------------------------------
// Method: POBasicsNew
// Description
// 
//
// Parameters
// ----------------------------------------------------

changePO:=True:C214
[PO:39]lng:72:=[Vendor:38]lng:94
[PO:39]lat:88:=[Vendor:38]lat:104
[PO:39]amount:19:=0
[PO:39]taxJurisdiction:22:=0
[PO:39]miscAmount:23:=0
[PO:39]shipHandling:21:=0
[PO:39]total:24:=0
[PO:39]poNum:5:=CounterNew(->[PO:39])  // ### jwm ### 20170515_0826
newPo:=True:C214
[PO:39]dateOrdered:2:=Current date:C33
[PO:39]dateNeeded:3:=Current date:C33
[PO:39]buyer:7:=Current user:C182
// ### bj ### 20200129_1934 Always assign a taskID
TaskIDAssign(->[PO:39]idNumTask:69)
POsRecAddr