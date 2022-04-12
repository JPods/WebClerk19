//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/17/07, 08:49:56
// ----------------------------------------------------
// Method: Http_ServerLoadTags
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
	$trackingID:=WCapi_GetParameter("TrackingID"; "")
	C_LONGINT:C283($recentDays)
	$recentDays:=Num:C11(WCapi_GetParameter("Recent"; ""))
	C_DATE:C307($dateBegin; $dateEnd)
	$dateBegin:=Date:C102(WCapi_GetParameter("DateBegin"; ""))
	$dateEnd:=Date:C102(WCapi_GetParameter("DateEnd"; ""))
	Case of 
		: ($customerPO#"")
			QUERY:C277([LoadTag:88]; [LoadTag:88]customerPO:37=$customerPO; *)
			If ([Customer:2]customerID:1#"")
				QUERY:C277([LoadTag:88];  & [LoadTag:88]customerID:23=[Customer:2]customerID:1)
			End if 
			QUERY:C277([LoadTag:88])
			If (Records in selection:C76([LoadTag:88])=0)
				vResponse:="No valid LoadTags for "+String:C10($InvoiceNum)
			Else 
				$jitPageList:=WCapi_GetParameter("jitPageList"; "")
				$doPage:=WC_DoPage("LoadTagsList.html"; $jitPageList)
			End if 
		: ($InvoiceNum>0)
			QUERY:C277([LoadTag:88]; [LoadTag:88]idNumInvoice:19=$InvoiceNum; *)
			QUERY:C277([LoadTag:88];  & [LoadTag:88]customerID:23=[Customer:2]customerID:1)
			If (Records in selection:C76([LoadTag:88])=0)
				vResponse:="No valid LoadTags for "+String:C10($InvoiceNum)
			Else 
				$jitPageList:=WCapi_GetParameter("jitPageList"; "")
				$doPage:=WC_DoPage("LoadTagsList.html"; $jitPageOne)
			End if 
		: ($recentDays>0)
			$dateBegin:=Current date:C33-$recentDays
			C_LONGINT:C283($beginDT)
			$beginDT:=DateTime_Enter($dateBegin)
			QUERY:C277([LoadTag:88]; [LoadTag:88]customerID:23=[Customer:2]customerID:1; *)
			QUERY:C277([LoadTag:88];  & [LoadTag:88]dtAssembly:9>=$beginDT)
			If (Records in selection:C76([LoadTag:88])>0)
				$jitPageList:=WCapi_GetParameter("jitPageList"; "")
				$doPage:=WC_DoPage("LoadTagsList.html"; "")
			Else 
				vResponse:="No LoadTags in the last "+String:C10($recentDays)+" days."
			End if 
		: ($dateBegin>!00-00-00!)
			C_LONGINT:C283($beginDT; $endDT)
			$beginDT:=DateTime_Enter($dateBegin)
			$endDT:=DateTime_Enter($dateEnd; ?23:59:59?)
			QUERY:C277([LoadTag:88]; [LoadTag:88]customerID:23=[Customer:2]customerID:1; *)
			QUERY:C277([LoadTag:88];  & [LoadTag:88]dtAssembly:9>=$beginDT; *)
			If (($dateEnd>!00-00-00!) & ($dateBegin<$dateEnd))
				$endDT:=DateTime_Enter($dateEnd; ?23:59:59?)
			Else 
				$dateEnd:=$dateBegin
				$endDT:=DateTime_Enter($dateBegin; ?23:59:59?)
			End if 
			QUERY:C277([LoadTag:88];  & [LoadTag:88]dtAssembly:9>=$beginDT)
			If (Records in selection:C76([LoadTag:88])>0)
				$jitPageList:=WCapi_GetParameter("jitPageList"; "")
				$doPage:=WC_DoPage("LoadTagsList.html"; $jitPageList)
			Else 
				vResponse:="No LoadTags in the period of "+String:C10($dateBegin)+"/"+String:C10($dateEnd)+"."
			End if 
		Else 
			vResponse:="You must submit a valid Invoice Number."
	End case 
Else 
	vResponse:=vResponse+"Must be a customer to check Invoice status, remote user relates to :"+Table name:C256([EventLog:75]tableNum:9)+"\r"
End if 
$err:=WC_PageSendWithTags($1; $doPage; 0)

vItemRelated:=""