//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1)
C_POINTER:C301($2)
//

$jitTableName:=WCapi_GetParameter("jitTableName"; "")
Case of 
	: ((voState.url="/Wcc_QueryReport_MfrByZip") | (voState.url="/Search_mfrIDZip"))
		$jitPageList:=WCapi_GetParameter("jitPageList"; "")
		$zipBegin:=WCapi_GetParameter("ZipBegin"; "")
		$zipEnd:=WCapi_GetParameter("ZipEnd"; "")
		$mfrID:=WCapi_GetParameter("mfrID"; "")
		$itemNum:=WCapi_GetParameter("ItemNum"; "")
		Case of 
			: (($zipBegin#"") & ($zipEnd#""))
				QUERY:C277([MfrCustomerXRef:110]; [MfrCustomerXRef:110]zipCustomer:8>=$zipBegin+"@"; *)
				QUERY:C277([MfrCustomerXRef:110];  & [MfrCustomerXRef:110]zipCustomer:8<=$zipEnd+"@"; *)
			: (($zipBegin#"") & ($zipEnd=""))
				QUERY:C277([MfrCustomerXRef:110]; [MfrCustomerXRef:110]zipCustomer:8=$zipBegin+"@"; *)
			: (($zipBegin="") & ($zipEnd#""))
				QUERY:C277([MfrCustomerXRef:110]; [MfrCustomerXRef:110]zipCustomer:8=$zipEnd+"@"; *)
			Else 
				QUERY:C277([MfrCustomerXRef:110]; [MfrCustomerXRef:110]zipCustomer:8#""; *)
		End case 
		If ($mfrID#"")
			QUERY:C277([MfrCustomerXRef:110];  & [MfrCustomerXRef:110]mfrID:3=$mfrID+"@"; *)
		End if 
		If ($itemNum#"")
			//QUERY([MfrsCarried];&[MfrsCarried]MfgID=$mfrID+"@";*)
		End if 
		QUERY:C277([MfrCustomerXRef:110])
		
		
		$itemNum:=WCapi_GetParameter("ItemNum"; "")
		
		
		
		
		
		If (Records in selection:C76([MfrCustomerXRef:110])>0)
			$jitPageList:=WCapi_GetParameter("jitPageList"; "")
			$doPage:=WC_DoPage("WccMfrsCarriedList.html"; $jitPageList)
		Else 
			$doPage:=WC_DoPage("error.html"; "")
			vResponse:="No matching records."
		End if 
		$err:=WC_PageSendWithTags($1; $doPage; 0)
End case 