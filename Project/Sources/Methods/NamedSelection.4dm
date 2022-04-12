//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-09-24T00:00:00, 10:44:02
// ----------------------------------------------------
// Method: NamedSelection
// Description
// Modified: 09/24/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

// query for selection
// Order By the selection


ALL RECORDS:C47([QQQCustomer:2])
COPY NAMED SELECTION:C331([QQQCustomer:2]; "SomeNamedSelection")
C_LONGINT:C283($t)
$t:=RECORDS IN NAMED SELECTION(->[QQQCustomer:2]; "SomeNamedSelection")
TRACE:C157
CLEAR NAMED SELECTION:C333("SomeNamedSelection")

// no selection found
ALL RECORDS:C47([QQQCustomer:2])
COPY NAMED SELECTION:C331([QQQCustomer:2]; "SomeNamedSelection")



CLEAR NAMED SELECTION:C333("SomeNamedSelection")
C_LONGINT:C283($t)
$t:=RECORDS IN NAMED SELECTION(->[QQQCustomer:2]; "SomeNamedSelection")
TRACE:C157









