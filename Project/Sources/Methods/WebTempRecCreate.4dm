//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 01/09/19, 12:15:49
// ----------------------------------------------------
// Method: WebTempRecCreate
// Description
// 
//
// Parameters
// ----------------------------------------------------


CREATE RECORD:C68([WebTempRec:101])
[WebTempRec:101]idEventLog:1:=[EventLog:75]id:54
[WebTempRec:101]itemNum:3:=[Item:4]itemNum:1
[WebTempRec:101]dtCreated:16:=DateTime_DTTo
[WebTempRec:101]dtUpdated:17:=DateTime_DTTo
[WebTempRec:101]description:15:=[Item:4]description:7
[WebTempRec:101]mfrItemNum:26:=[Item:4]mfrItemNum:39
[WebTempRec:101]mfrID:22:=[Item:4]mfrID:53
[WebTempRec:101]vendorID:28:=[Item:4]vendorID:45
[WebTempRec:101]vendorItemNum:27:=[Item:4]vendorItemNum:40
[WebTempRec:101]classid:6:=[Item:4]class:92
[WebTempRec:101]typeSale:29:=[EventLog:75]typeSale:47
[WebTempRec:101]ideRemoteUser:36:=[RemoteUser:57]idNum:1  // ### jwm ### 20181107_1535

If ([RemoteUser:57]company:16#"")
	[WebTempRec:101]company:33:=[RemoteUser:57]company:16
Else 
	[WebTempRec:101]company:33:=[RemoteUser:57]userName:2
End if 
[WebTempRec:101]tableNum:24:=[RemoteUser:57]tableNum:9
//[WebTempRec]Cost:=[Item]CostAverage

//TRACE
[WebTempRec:101]taxExempt:25:=(([Item:4]taxID:17#"") & ([Item:4]taxID:17#"false") & ([Customer:2]taxExemptid:56#"") & (Record number:C243([Customer:2])>-1))
