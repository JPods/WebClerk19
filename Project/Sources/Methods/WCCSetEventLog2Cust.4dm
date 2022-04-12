//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-02-15T00:00:00, 21:07:07
// ----------------------------------------------------
// Method: WCCSetEventLog2Cust
// Description
// Modified: 02/15/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $2)
If ($2=-1)
	[EventLog:75]tableNum:9:=-1
	[EventLog:75]customerRecNum:8:=-1
	[EventLog:75]securityLevel:16:=1
	
Else 
	[EventLog:75]tableNum:9:=$1
	[EventLog:75]customerRecNum:8:=$2
	[EventLog:75]remoteUserRec:10:=Record number:C243([RemoteUser:57])
	[EventLog:75]securityLevel:16:=[RemoteUser:57]securityLevel:4
	// Modified by: Bill James (2015-02-15T00:00:00 [EventLog]TypeSale not set and needed by Http_PostOrd2 or will return Aprice)
	Case of 
		: ([EventLog:75]tableNum:9=2)
			[EventLog:75]typeSale:47:=[Customer:2]typeSale:18
		: ([EventLog:75]tableNum:9=(Table:C252(->[Contact:13])))
			If ([Contact:13]customerID:1#[Customer:2]customerID:1)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Contact:13]customerID:1)
				[EventLog:75]typeSale:47:=[Customer:2]typeSale:18
			End if 
		: ([EventLog:75]tableNum:9=(Table:C252(->[Lead:48])))
			[EventLog:75]typeSale:47:=[Lead:48]typeSale:30
	End case 
End if 
If ([EventLog:75]idNum:5#0)
	SAVE RECORD:C53([EventLog:75])
End if 