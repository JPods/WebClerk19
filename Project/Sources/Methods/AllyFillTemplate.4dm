//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2013-12-17T00:00:00, 23:30:46
// ----------------------------------------------------
// Method: AllyFillTemplate
// Description
// Modified: 12/17/13
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $keepRecord)
$keepRecord:=0
If (Count parameters:C259>0)  // used in Http_OrderAllyAssign
	$keepRecord:=$1
End if 
C_BOOLEAN:C305($doPop)
$doPop:=False:C215
If (($keepRecord#1) & (Record number:C243([Customer:2])>-1))
	PUSH RECORD:C176([Customer:2])
	$doPop:=True:C214
End if 
If ([Customer:2]customerID:1#[EventLog:75]allyid:49)  // skip search if ally record is alreadly loaded
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=[EventLog:75]allyid:49)
End if 
If (Record number:C243([Customer:2])=1)
	vAllyData:=<>vAllyhtmlTemplate  // put template into variable
	C_LONGINT:C283($err)
	vAllyData:=TagsToText(vAllyData)
	UNLOAD RECORD:C212([Customer:2])  // release the ally record
End if 
If ($doPop)
	POP RECORD:C177([Customer:2])
End if 