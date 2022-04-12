//%attributes = {}
C_LONGINT:C283($1)
C_POINTER:C301($2)
$jitTableName:=WCapi_GetParameter("jitTableName"; "")
$jitPageList:=WCapi_GetParameter("jitPageList"; "")
$zipBegin:=WCapi_GetParameter("ZipBegin"; "")
$zipEnd:=WCapi_GetParameter("ZipEnd"; "")
$mfrID:=WCapi_GetParameter("mfrID"; "")
$customerID:=WCapi_GetParameter("customerID"; "")
C_LONGINT:C283($uniqueID)
$uniqueID:=Num:C11(WCapi_GetParameter("id"; ""))
vResponse:="No records."
Case of 
	: (voState.url="/Search_ZipItem@")  //&($jitTableName="ItemsCarried"))
		$itemNum:=WCapi_GetParameter("ItemNum"; "")
		Case of 
			: (($zipBegin#"") & ($zipEnd#""))
				QUERY:C277([ItemCarried:113]; [ItemCarried:113]zipCustomer:8>=$zipBegin+"@"; *)
				QUERY:C277([ItemCarried:113];  & [ItemCarried:113]zipCustomer:8<=$zipEnd+"@"; *)
			: (($zipBegin#"") & ($zipEnd=""))
				QUERY:C277([ItemCarried:113]; [ItemCarried:113]zipCustomer:8=$zipBegin+"@"; *)
			: (($zipBegin="") & ($zipEnd#""))
				QUERY:C277([ItemCarried:113]; [ItemCarried:113]zipCustomer:8=$zipEnd+"@"; *)
			Else 
				QUERY:C277([ItemCarried:113]; [ItemCarried:113]zipCustomer:8#""; *)
		End case 
		If ($mfrID#"")
			QUERY:C277([ItemCarried:113];  & [ItemCarried:113]mfrID:4=$mfrID; *)
		End if 
		If ($itemNum#"")
			QUERY:C277([ItemCarried:113];  & [ItemCarried:113]itemNum:2=$itemNum; *)
		End if 
		QUERY:C277([ItemCarried:113])
		If (Records in selection:C76([ItemCarried:113])>0)
			$doPage:=WC_DoPage("DealersItemsCarriedList.html"; $jitPageList)
		Else 
			$jitPageError:=WCapi_GetParameter("jitPageError"; "")
			$doPage:=WC_DoPage("Error.html"; $jitPageError)
		End if 
	: (voState.url="/Search_ZipMfr@")
		$itemClass:=WCapi_GetParameter("Class"; "")
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
			QUERY:C277([MfrCustomerXRef:110];  & [MfrCustomerXRef:110]mfrID:3=$mfrID; *)
		End if 
		If ($itemClass#"")
			QUERY:C277([MfrCustomerXRef:110];  & [MfrCustomerXRef:110]class:9=$itemClass; *)
		End if 
		QUERY:C277([MfrCustomerXRef:110])
		If (Records in selection:C76([MfrCustomerXRef:110])>0)
			$doPage:=WC_DoPage("DealersMfrsCarriedList.html"; $jitPageList)
		Else 
			$jitPageError:=WCapi_GetParameter("jitPageError"; "")
			$doPage:=WC_DoPage("Error.html"; $jitPageError)
		End if 
End case 
$err:=WC_PageSendWithTags($1; $doPage; 0)