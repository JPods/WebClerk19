//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/21/12, 10:12:44
// ----------------------------------------------------
// Method: XML_DataMemCommunicate
// Description
// 
//
// Parameters
// ----------------------------------------------------


//  Procedure in UserReport
If (False:C215)
	C_LONGINT:C283(vCountAspire)
	vCountAspire:=0
	Repeat 
		vCountAspire:=vCountAspire+1
		XML_DataMemCommunicate
		//Alert("Order: "+string(uLongInt9))
		
		If (vCountAspire>100)  // this limits transfer to 100 at a time for testing.
			vStatus:="endbycount"
		End if 
	Until (vStatus#"Loop@")
	
	
	
	
	
End if 



//  get specific number of orders by manually setting [TallyResult]Longint1 to the desired number

QUERY:C277([TallyResult:73]; [TallyResult:73]name:1="ExchangeOrders"; *)
QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2="DataMemory")
If (Records in selection:C76([TallyResult:73])=0)
	CREATE RECORD:C68([TallyResult:73])
	
	[TallyResult:73]purpose:2:="DataMemory"
	[TallyResult:73]name:1:="ExchangeOrders"
	[TallyResult:73]nameLong1:24:="NextOrderNum"
	[TallyResult:73]longint1:7:=629146400
	[TallyResult:73]nameProfile1:26:=""
	[TallyResult:73]profile1:17:=""
	[TallyResult:73]textBlk1:5:=""
	[TallyResult:73]textBlk2:6:=""
	SAVE RECORD:C53([TallyResult:73])
End if 
C_TEXT:C284(vStatus)
HTTPClient_URL:="http://www.datamemorysystems.com/scripts/ecs/api/gate.php"
//HTTPClient_URL:="http://dmsapi.aspiresoft.com/scripts/ecs/api/gate.php"
HTTPClient_GetRequest:=1
HTTPClient_PostRequest:=0
HTTPClient_Response:=""
//
HTTPClient_Response:=""
<>doTest:=True:C214
If (Records in selection:C76([TallyResult:73])=1)
	vStatus:="Loop"
	uLongInt9:=[TallyResult:73]longint1:7
	//http://www.datamemorysystems.com/scripts/ecs/api/gate.php
	uText11:=""
	HTTP_Protocol:="http"
	//HTTP_Host:="dmsapi.aspiresoft.com"
	HTTP_Host:="www.datamemorysystems.com"
	HTTP_Path:="/scripts/ecs/api/gate.php"
	HTTP_Port:=80
	HTTP_TimeOut:=10
	SET BLOB SIZE:C606(HTTP_Data; 0)
	
	uText9:="GET /scripts/ecs/api/gate.php?login=ecs.api"
	uText9:=uText9+"&password=ApiDMS235Jx&op=fetchOrders&op=fetchOrders"
	uText9:=uText9+"&fromID="+String:C10([TallyResult:73]longint1:7)+"&toID="+String:C10([TallyResult:73]longint1:7)+" HTTP/1.1"
	uText9:=uText9+Storage:C1525.char.crlf+"User-Agent: WebClerk-CommerceExpert HTTP Client"
	uText9:=uText9+Storage:C1525.char.crlf+"Host: dmsapi.aspiresoft.com"
	uText9:=uText9+Storage:C1525.char.crlf+"Accept: */*"
	uText9:=uText9+Storage:C1525.char.crlf+"Connection: close"+Storage:C1525.char.crlf+Storage:C1525.char.crlf
	
	TEXT TO BLOB:C554(uText9; HTTP_Data; UTF8 text without length:K22:17)
	
	HTTPFullSend:=uText9  //so it shows up in the ClientTester window
	
	uText8:="connect-timeout="+String:C10(HTTP_TimeOut)
	uText11:=""
	If (uText11#"ITK")
		uLongInt1:=TCP Open(HTTP_Host; HTTP_Port; uText8)
		//ALERT(String(uLongInt1))
		SET BLOB SIZE:C606(uBlob1; 0)
		SET BLOB SIZE:C606(uBlob2; 0)
		If (uLongInt1#0)
			
			uLongInt2:=TCP Send Blob(uLongInt1; HTTP_Data)
			
			uLongInt3:=Milliseconds:C459+(HTTP_TimeOut*1000)
			
			
			While ((TCP Get State(uLongInt1)#TCP Connection Closed) & (Milliseconds:C459<uLongInt3))
				If (TCP Receive Blob(uLongInt1; uBlob1)>0)
					COPY BLOB:C558(uBlob1; uBlob2; 0; BLOB size:C605(uBlob2); BLOB size:C605(uBlob1))
				Else 
					DELAY PROCESS:C323(Current process:C322; 30)
				End if 
			End while 
			
			TCP Close(uLongInt1)
			vi9:=BLOB size:C605(uBlob2)
			
		End if 
		HTTPClient_Response:=BLOB to text:C555(uBlob2; UTF8 text without length:K22:17)
		SET BLOB SIZE:C606(uBlob1; 0)
		
		If (<>dotest)
			If (Position:C15("</response>"; HTTPClient_Response)<10)
				
			End if 
		End if 
	Else 
		
		uLongInt3:=Milliseconds:C459+(HTTP_TimeOut*1000)
		//uncomment
		//uLongInt1:=ITK_TCPOpen(HTTP_Host;HTTP_Port;uText8)
		uText6:=""
		HTTPClient_Response:=""
		If (uLongInt1#0)
			//uncomment
			//uLongInt2:=ITK_TCPSend(uLongInt1;HTTPFullSend;1)
			uLongInt3:=Milliseconds:C459+(HTTP_TimeOut*1000)
			//uncomment
			While (1=6)  //((ITK_TCPStatus(streamRef;selector)#0)&(Milliseconds<uLongInt3))
				//uncomment
				//uLongInt2:=ITK_TCPRcv(uLongInt1;uText6)
				If (Length:C16(uText6)>0)
					HTTPClient_Response:=HTTPClient_Response+uText6
					uText6:=""
				Else 
					DELAY PROCESS:C323(Current process:C322; 30)
				End if 
			End while 
			//uncomment
			//uLongInt3:=ITK_TCPClose(uLongInt1)
			//uLongInt3:=ITK_TCPRelease(uLongInt1)
		End if 
	End if 
	
	If (Length:C16(HTTPClient_Response)>0)
		//vi9:=Position("<respons";HTTPClient_Response)
		vi9:=Position:C15(Storage:C1525.char.crlf+Storage:C1525.char.crlf; HTTPClient_Response)
		HTTPClient_Response:=Substring:C12(HTTPClient_Response; vi9+4)
		
		vi9:=Position:C15("<respon"; HTTPClient_Response)
		HTTPClient_Response:=Substring:C12(HTTPClient_Response; vi9)
		
		vi9:=Position:C15("</response>"; HTTPClient_Response)
		HTTPClient_Response:=Substring:C12(HTTPClient_Response; 1; vi9+11)
		
	End if 
	
	Case of 
		: ((Position:C15(HTTPClient_Response; "status="+Char:C90(34)+"error")>1) | (Length:C16(HTTPClient_Response)<300))
			CREATE RECORD:C68([TallyResult:73])
			
			[TallyResult:73]nameLong1:24:="OrderNum"
			[TallyResult:73]longint1:7:=-1
			[TallyResult:73]nameProfile1:26:="customerID"
			[TallyResult:73]profile1:17:="NoOrders"
			[TallyResult:73]purpose:2:="DataTransfer"
			[TallyResult:73]dtCreated:11:=DateTime_Enter
			[TallyResult:73]textBlk1:5:=HTTPFullSend
			[TallyResult:73]textBlk2:6:=HTTPClient_Response
			[TallyResult:73]name:1:="NoOrder"
			SAVE RECORD:C53([TallyResult:73])
			UNLOAD RECORD:C212([TallyResult:73])
			HTTPClient_Response:=""
			vStatus:="404 There are no orders available: "+String:C10(uLongInt9)
		: (HTTPClient_Response="")
			CREATE RECORD:C68([TallyResult:73])
			
			[TallyResult:73]nameLong1:24:="OrderNum"
			[TallyResult:73]longint1:7:=-1
			[TallyResult:73]nameProfile1:26:="customerID"
			[TallyResult:73]profile1:17:="NoOrders"
			[TallyResult:73]purpose:2:="DataTransfer"
			[TallyResult:73]dtCreated:11:=DateTime_Enter
			[TallyResult:73]textBlk1:5:="No Response"
			[TallyResult:73]textBlk2:6:="No Response"
			[TallyResult:73]name:1:="FailedCommunications"
			SAVE RECORD:C53([TallyResult:73])
			UNLOAD RECORD:C212([TallyResult:73])
			vStatus:="No Data: "+String:C10(uLongInt9)
		Else 
			CREATE RECORD:C68([TallyResult:73])
			
			[TallyResult:73]nameLong1:24:="OrderNum"
			[TallyResult:73]longint1:7:=Num:C11(Substring:C12(String:C10(uLongInt9); 2))
			[TallyResult:73]nameProfile1:26:="customerID"
			[TallyResult:73]nameProfile2:27:="Status"
			[TallyResult:73]profile2:18:="Pending"
			
			[TallyResult:73]purpose:2:="DataTransfer"
			[TallyResult:73]dtCreated:11:=DateTime_Enter
			[TallyResult:73]textBlk1:5:=HTTPFullSend
			[TallyResult:73]textBlk2:6:=HTTPClient_Response
			[TallyResult:73]name:1:="OneOrder"
			SAVE RECORD:C53([TallyResult:73])
			HTTPClient_Response:="<?xml version="+Txt_Quoted("1.0")+" encoding="+Txt_Quoted("us-ascii")+"?>"+"\r"+HTTPClient_Response
			
			QUERY:C277([TallyResult:73]; [TallyResult:73]name:1="ExchangeOrders"; *)
			QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2="DataMemory")
			[TallyResult:73]longint1:7:=[TallyResult:73]longint1:7+1
			SAVE RECORD:C53([TallyResult:73])
			UNLOAD RECORD:C212([TallyResult:73])
	End case 
End if 
REDUCE SELECTION:C351([TallyResult:73]; 0)
