//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/17/11, 17:27:52
// ----------------------------------------------------
// Method: Http_ServerPay
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $3; $c; $doThis; <>vbSaleLevel)
C_TEXT:C284(vResponse)
C_POINTER:C301($2)
$c:=$1
$suffix:=""
$doThis:=0
vResponse:=""
$lastCarrier:=[EventLog:75]carrier:20
$lastZip:=[EventLog:75]zip:21
//TRACE
Case of 
	: ((voState.url="/pay_Ord@") | (voState.url="/CCpay_Ord@"))  //pay the order
		$shipVia:=WCapi_GetParameter("shipVia"; "")
		$myZip:=WCapi_GetParameter("ShipZip"; "")
		//zttp_UserGet 
		If (<>vWebCustBalMaxOrd=1)
			Http_OrdFill($1; $2; False:C215)
		End if 
		//TRACE
		Case of 
			: ((pSumBalance<0) & (<>vWebCustBalMaxOrd=1))
				vResponse:="Value of Order Exceeds Current Balance: "+pvSumBalance
				$jitPageOne:=WCapi_GetParameter("jitPageOne"; "")
				$jitPageOne:=WC_DoPage("CustomersConfirm.html"; $jitPageOne)
				$err:=WC_PageSendWithTags($1; $jitPageOne; 0)
			: ((([Order:3]shipVia:13=$lastCarrier) & ([Order:3]zip:20=$lastZip)) | (<>vlignorShipping=1))
				http_PayOrder($1; ->vText11)
			: ((($shipVia=$lastCarrier) & ($myZip=$lastZip)) | (<>vlignorShipping=1))
				http_PayOrder($1; ->vText11)
			Else 
				http_CheckOut($c; $2)
		End case 
		
	: (voState.url="/pay_SSLSetup@")  //capture payment from a remote site
		Http_PaySSLSetup($1; $2)
		//
	: (voState.url="/pay_SSLTrap@")  //capture payment from a remote site
		Http_PayTrap
		//
	: (voState.url="/pay_SSLReturn@")  //return 
		http_PayOrder($1; ->vText11)
		//http_PaySSLRecs ($c;$2;0)
		//
	: (voState.url="/pay_Request@")  //add items to order, 
		http_PayRequest($1; $2; 0)
		//
	: (voState.url="/pay_Request@")  //add items to order, 
		http_Custom($1; $2; 0)
		//      
	Else 
		vResponse:="Improper Payment request."
		$err:=WC_PageSendWithTags($c; WC_DoPage("Error.html"; ""); 0)
End case 