//%attributes = {"publishedWeb":true}
//Method: Http_serverSearch
C_LONGINT:C283($1; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse)
C_POINTER:C301($2)
$c:=$1
$suffix:=""
$doThis:=0
vResponse:=""
Case of 
	: (voState.url="/Status_SaveRecord@")  //pay the order
		Http_SaveRecord($1; $2; True:C214)
		
		//: (voState.url="/Status_SaveCustomer@")//pay the order
		//Http_OldCust ($1;$2)
	: (voState.url="/Status_ShowRecord@")  //pay the order
		Http_QueryRecords($1; $2)
		
	: (voState.url="/Status_Invoice@")  //pay the order
		Http_ServerInvoices($c; $2)
		
	: (voState.url="/Status_Ledgers@")  //pay the order
		Http_ServerLedgers($c; $2)
		
	: (voState.url="/Status_LoadTags@")  //pay the order
		Http_ServerLoadTags($c; $2)
		
	: (voState.url="/Status_Order@")  //pay tHttp_InvoiceServerHttp_ServerLoadTagshe order
		Http_OrdStatus($c; $2)
		
	: ((voState.url="/Status_POAsk@") | (voState.url="/Status_POAsk@"))  //for the remote customer
		http_POStatusGetReturn($c; ->vText11)
		//: (|(voState.url="/Status_POFind@"))//for the remote customer
		//http_POStatusFind($c;->vText11)
	: (voState.url="/Status_POReceive@")  //coming back to us
		Http_POStatusReceive($c; ->vText11)
		
	: (voState.url="/Status_OptOutConfirm@")  //pay the order
		$emailAddress:=WCapi_GetParameter("email"; "")
		QUERY:C277([RemoteUser:57]; [RemoteUser:57]email:14=$emailAddress)
		$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
		$doPage:=WC_DoPage("OptOut.html"; $jitPageOne)
		$err:=WC_PageSendWithTags($c; $doPage; 0)
		
	: (voState.url="/Status_OptOutFinal@")  //pay the order
		$emailAddress:=WCapi_GetParameter("email"; "")
		QUERY:C277([RemoteUser:57]; [RemoteUser:57]email:14=$emailAddress)
		$why:=WCapi_GetParameter("why"; "")
		
		[RemoteUser:57]optOut:23:="N"
		SAVE RECORD:C53([RemoteUser:57])
		$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
		$doPage:=WC_DoPage("OptOutFinal.html"; $jitPageOne)
		$err:=WC_PageSendWithTags($c; $doPage; 0)
		
	Else 
		vResponse:="Improper Status request."
		$err:=WC_PageSendWithTags($c; WC_DoPage("Error.html"; ""); 0)
End case 

