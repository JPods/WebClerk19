//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: SyncWebCust
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
viRemoteIP:=0
C_LONGINT:C283($i; $k)
$k:=Records in selection:C76([Customer:2])
If ($k>0)
	C_LONGINT:C283($w)
	C_BOOLEAN:C305($killWhenDone)
	//  
	C_LONGINT:C283($stream)
	C_TEXT:C284($vendorIP; $theDomain)
	READ WRITE:C146([Customer:2])
	FIRST RECORD:C50([Customer:2])
	For ($i; 1; $k)
		LOAD RECORD:C52([Customer:2])
		If (Not:C34(Locked:C147([Customer:2])))
			MESSAGES OFF:C175
			C_BLOB:C604(HTTP_IncomingBlob)
			ON ERR CALL:C155("jOECNoAction")
			ARRAY TEXT:C222(aText1; 0)
// zzzqqq URL_Cleanup zzzqqq 			[SyncRelation:103]partner1URL:2:=URL_Cleanup([SyncRelation:103]partner1URL:2)
			$vRequest:=[SyncRelation:103]partner1URL:2+"/Sync_Customers?UserName="+[SyncRelation:103]remoteUserName:3+"&Password="+[SyncRelation:103]remoteUserPassword:4+"&_jit_2_1jj="+[Customer:2]customerID:1+"&_jit_2_8jj="+[Customer:2]zip:8+"&_jit_2_4jj="+[Customer:2]address1:4
			
			NTK_SetURL($vendorDomain)  //this is a good procedure for parsing a complete URL.  Set each variable here.
			//HTTP_TimeOut:=10//seconds
			//HTTP_Protocol:="https"//process as SSL
			//HTTP_Path:=<>tcCCVerURL//Server command
			//HTTP_Host:=<>tcCCVerHost//Server manchine
			//HTTP_Port:=<>tcCCVerPort//the Port
			C_BLOB:C604(HTTP_IncomingBlob)
			$error:=WC_Request("GET")
			vText11:=BLOB to text:C555(HTTP_IncomingBlob; UTF8 text without length:K22:17)
			SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
			
			//
			TRACE:C157
			If (vText11#"")
				$poNum:=WCapi_GetParameter("PONum"; "")
				$soNum:=WCapi_GetParameter("SONum"; "")
				$userName:=WCapi_GetParameter("OrderStatus"; "")
				$password:=WCapi_GetParameter("OrderComment"; "")
			Else 
				$userName:="NoUD_"+[PO:39]statusVendor:70
				$password:=[PO:39]commentVendor:71
			End if 
			[PO:39]statusVendor:70:=$userName
			[PO:39]commentVendor:71:=$password
			SAVE RECORD:C53([PO:39])
		End if 
		NEXT RECORD:C51([PO:39])
	End for 
End if 
