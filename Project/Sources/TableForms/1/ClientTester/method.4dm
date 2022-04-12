// (FM) [Dialog];"HTTPClient_Demo"

C_TEXT:C284(HTTPClient_URL; HTTPClient_Response)
C_LONGINT:C283(HTTPClient_GetRequest; HTTPClient_PostRequest; HTTPClient_AddParamButton; HTTPClient_DelParamButton; HTTPClient_SendButton; HTTPTestMode)
C_TEXT:C284(HTTPClip; HTTPSendText)

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		HTTPFullSend:=""
		HTTPSendText:=""
		HTTP_ContentType:=""
		HTTPTestMode:=1
		HTTP_TestMode:=1
		HTTPClient_GetRequest:=1
		HTTPClient_PostRequest:=0
		HTTPClient_Response:=""
		
		HTTPClient_URL:="http://www.pluggers.nl/ntk_httpdemo.php"
		HTTPClient_URL:="http://dmsapi.aspiresoft.com/scripts/ecs/api/gate.php"
		HTTPClient_URL:="https://api.demo.convergepay.com/VirtualMerchantDemo/processxml.do"
		HTTPClient_URL:="https://api.demo.convergepay.com/VirtualMerchantDemo/processxml.do"
		If (Records in selection:C76([SyncRelation:103])=0)
			READ ONLY:C145([SyncRelation:103])
			QUERY:C277([SyncRelation:103]; [SyncRelation:103]RemoteUserName:3="008101")
		End if 
		HTTPClient_URL:=[SyncRelation:103]Partner2URL:33
		HTTPSendText:=[SyncRelation:103]Template:39
		HTTP_ContentType:=[SyncRelation:103]ContentType:44
		
		If ([SyncRelation:103]RequestMethod:38="Post@")
			HTTPClient_PostRequest:=1
			HTTPClient_GetRequest:=0
		Else 
			HTTPClient_PostRequest:=0
			HTTPClient_GetRequest:=1
		End if 
		// REDUCE SELECTION([SyncRelation];0)
		
		//
		ARRAY BOOLEAN:C223(HTTPClient_ParamListbox; 0)
		ARRAY TEXT:C222(HTTPClient_ParamName; 0)
		ARRAY TEXT:C222(HTTPClient_ParamValue; 0)
		If (False:C215)
			APPEND TO ARRAY:C911(HTTPClient_ParamName; "login")
			APPEND TO ARRAY:C911(HTTPClient_ParamValue; "ecs.api")
			APPEND TO ARRAY:C911(HTTPClient_ParamName; "password")
			APPEND TO ARRAY:C911(HTTPClient_ParamValue; "ApiDMS235Jx")
			APPEND TO ARRAY:C911(HTTPClient_ParamName; "op")
			APPEND TO ARRAY:C911(HTTPClient_ParamValue; "fetchOrders")
			
			APPEND TO ARRAY:C911(HTTPClient_ParamName; "op")
			APPEND TO ARRAY:C911(HTTPClient_ParamValue; "fetchOrders")
			
			APPEND TO ARRAY:C911(HTTPClient_ParamName; "fromID")  //=&page=3
			APPEND TO ARRAY:C911(HTTPClient_ParamValue; "629145620")
			
			
			APPEND TO ARRAY:C911(HTTPClient_ParamName; "toID")  //=&=3
			APPEND TO ARRAY:C911(HTTPClient_ParamValue; "629145620")
		End if 
		//APPEND TO ARRAY(HTTPClient_ParamName;"fromDate")
		//APPEND TO ARRAY(HTTPClient_ParamValue;"2012-7-22")
		//
		
End case 

