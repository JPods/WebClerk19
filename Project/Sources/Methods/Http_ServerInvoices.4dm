//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/17/07, 08:49:37
// ----------------------------------------------------
// Method: Method: Http_ServerInvoices
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $err; $InvoiceNum; $k)
C_POINTER:C301($2)
$suffix:=""
$doThis:=0
vResponse:=""
//zttp_UserGet 
C_TEXT:C284($doPage)
$suffix:=""
$doPage:=WC_DoPage("Error.html"; "")
If (Record number:C243([Customer:2])>-1)
	$InvoiceNum:=Num:C11(WCapi_GetParameter("InvoiceNum"; ""))
	C_TEXT:C284($UnpaidInvoices; $customerPO)
	$customerPO:=WCapi_GetParameter("CustomerPO"; "")
	$UnpaidInvoices:=WCapi_GetParameter("UnpaidInvoices"; "")
	C_DATE:C307($dateBegin; $dateEnd)
	$dateBegin:=Date:C102(WCapi_GetParameter("DateBegin"; ""))
	$dateEnd:=Date:C102(WCapi_GetParameter("DateEnd"; ""))
	Case of 
		: ($InvoiceNum>0)
			QUERY:C277([Invoice:26]; [Invoice:26]invoiceNum:2=$InvoiceNum; *)
			QUERY:C277([Invoice:26];  & [Invoice:26]customerID:3=[Customer:2]customerID:1)
			If (Records in selection:C76([Invoice:26])=0)
				vResponse:="No valid Invoice by you for "+String:C10($InvoiceNum)
			Else 
				QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]invoiceNum:1=[Invoice:26]invoiceNum:2)
				$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
				$doPage:=WC_DoPage("InvoicesOne.html"; $jitPageOne)
			End if 
		: ($customerPO#"")
			QUERY:C277([Invoice:26]; [Invoice:26]customerID:3=[Customer:2]customerID:1; *)
			QUERY:C277([Invoice:26];  & [Invoice:26]customerPO:29=$customerPO+"@")
			Case of 
				: (Records in selection:C76([Invoice:26])>1)
					$jitPageList:=WCapi_GetParameter("jitPageList"; "")
					$doPage:=WC_DoPage("InvoicesList.html"; "")
				: (Records in selection:C76([Invoice:26])=1)
					$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
					$doPage:=WC_DoPage("InvoicesOne.html"; $jitPageOne)
				Else 
					vResponse:="No valid Invoice with CustomerPO "+$customerPO
			End case 
		: (($UnpaidInvoices="true") | ($UnpaidInvoices="t") | ($UnpaidInvoices="1"))
			QUERY:C277([Invoice:26]; [Invoice:26]customerID:3=[Customer:2]customerID:1; *)
			QUERY:C277([Invoice:26];  & [Invoice:26]balanceDue:44#0)
			If (Records in selection:C76([Invoice:26])>0)
				$jitPageList:=WCapi_GetParameter("jitPageList"; "")
				$doPage:=WC_DoPage("InvoicesList.html"; "")
			End if 
		: ($dateBegin>!00-00-00!)
			QUERY:C277([Invoice:26]; [Invoice:26]customerID:3=[Customer:2]customerID:1; *)
			QUERY:C277([Invoice:26];  & [Invoice:26]dateShipped:4>=$dateBegin; *)
			If (($dateEnd>!00-00-00!) & ($dateBegin<$dateEnd))
				QUERY:C277([Invoice:26];  & [Invoice:26]dateShipped:4<=$dateEnd; *)
			End if 
			QUERY:C277([Invoice:26])
			If (Records in selection:C76([Invoice:26])>0)
				$jitPageList:=WCapi_GetParameter("jitPageList"; "")
				$doPage:=WC_DoPage("InvoicesList.html"; $jitPageList)
			End if 
		Else 
			vResponse:="You must submit a valid Invoice Number."
	End case 
Else 
	vResponse:=vResponse+"Must be a customer to check Invoice status, remote user relates to :"+Table name:C256([EventLog:75]tableNum:9)+"\r"
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)
vItemRelated:=""