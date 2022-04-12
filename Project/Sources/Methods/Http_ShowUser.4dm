//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/05/09, 01:21:23
// ----------------------------------------------------
// Method: Http_ShowUser
// Description
// voState.url="/Show_User@"
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse)
C_POINTER:C301($2)
$c:=$1
$suffix:=""
$doThis:=0
//TRACE
vResponse:="You have not Signed In"
//zttp_UserGet 
$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
$jitPageError:=WCapi_GetParameter("jitPageError"; "")  // ### jwm ### 20150827_1605
$pageDo:=WC_DoPage("error.html"; $jitPageError)  // ### jwm ### 20150827_1608
// $pageDo:=WC_DoPage ("Error"+$suffix+".html";"")
If ($2->="Get /Show_UserSave@")
	If (([RemoteUser:57]tableNum:9=2) | ([RemoteUser:57]tableNum:9=48) | ([RemoteUser:57]tableNum:9=Table:C252(->[Vendor:38])) | ([RemoteUser:57]tableNum:9=Table:C252(->[Contact:13])) | ([RemoteUser:57]tableNum:9=Table:C252(->[Rep:8])) | ([RemoteUser:57]tableNum:9=Table:C252(->[Employee:19])))
		If (<>wcbCustomerMods=0)
			vResponse:="Allowing customer modifications is not checked."
		Else 
			WC_Parse([RemoteUser:57]tableNum:9; $2)
			vResponse:="Record modified"
		End if 
	Else 
		vResponse:="Incorrect table."
	End if 
End if 
Case of 
	: ([RemoteUser:57]tableNum:9=2)
		P_AddressesCustomer
		//Ledger_TallyBal(False; False)
		//SAVE RECORD([Customer])
		$pageDo:=WC_DoPage("CustomersOne"+([Customer:2]webPage:94*Num:C11([Customer:2]webPage:94#"0"))+".html"; $jitPageOne)
	: ([RemoteUser:57]tableNum:9=48)
		P_AddressesCustomer
		$pageDo:=WC_DoPage("LeadsOne.html"; $jitPageOne)
	: ([RemoteUser:57]tableNum:9=Table:C252(->[Vendor:38]))
		$pageDo:=WC_DoPage("VendorsOne"+([Vendor:38]webPage:80*Num:C11([Vendor:38]webPage:80#"0"))+".html"; $jitPageOne)
	: ([RemoteUser:57]tableNum:9=Table:C252(->[Contact:13]))
		$pageDo:=WC_DoPage("ContactsOne"+([Contact:13]webPage:47*Num:C11([Contact:13]webPage:47#"0"))+".html"; $jitPageOne)
	: ([RemoteUser:57]tableNum:9=Table:C252(->[Rep:8]))
		$pageDo:=WC_DoPage("RepsOne.html"; $jitPageOne)
	: ([RemoteUser:57]tableNum:9=Table:C252(->[Employee:19]))
		$pageDo:=WC_DoPage("EmployeesOne"+([Employee:19]webPage:43*Num:C11([Employee:19]webPage:43#"0"))+".html"; $jitPageOne)
End case 
//
$err:=WC_PageSendWithTags($1; $pageDo; 0)
//Http_ReduceSelection 
//