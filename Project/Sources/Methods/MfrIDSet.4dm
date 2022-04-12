//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-01-11T00:00:00, 08:19:35
// ----------------------------------------------------
// Method: mfrIDSet
// Description
// Modified: 01/11/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------





PUSH RECORD:C176([Customer:2])
QUERY:C277([Customer:2]; [Customer:2]mfrLocationid:67<-2000000)

ARRAY LONGINT:C221($mfrLocations; 0)
ORDER BY:C49([Customer:2]; [Customer:2]mfrLocationid:67)
C_LONGINT:C283($mfrID)
FIRST RECORD:C50([Customer:2])
$mfrID:=[Customer:2]mfrLocationid:67
REDUCE SELECTION:C351([Customer:2]; 0)
POP RECORD:C177([Customer:2])
[Customer:2]mfrLocationid:67:=$mfrID-1