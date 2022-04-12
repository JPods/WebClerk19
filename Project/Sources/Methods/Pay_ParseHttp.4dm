//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-12-12T00:00:00, 08:28:31
// ----------------------------------------------------
// Method: Pay_ParseHttp
// Description
// Modified: 12/12/16
// 
// 
//
// Parameters
// ----------------------------------------------------

// There can be multiple payments on a single order

//  xmldata=<txn>
//  <ssl_merchant_id>_jit_103_35jj</ssl_merchant_id>
//  <ssl_user_id>shoppingcart</ssl_user_id>
//  <ssl_pin>_jit_103_40jj</ssl_pin>
//  <ssl_transaction_type>ccsale</ssl_transaction_type>
//  <ssl_test_mode>false</ssl_test_mode>
//  <ordernumber>_jit_0_vOrdNumjj</ordernumber>
//  <ssl_avs_address>_jit_0_pvAddress1jj</ssl_avs_address>
//  <ssl_avs_zip>_jit_0_pvZipjj</ssl_avs_zip>
//  <ssl_card_number>_jit_0_pCreditCardjj</ssl_card_number>
//  <ssl_exp_date>_jit_0_pccDateStrjj</ssl_exp_date>
//  <ssl_amount>_jit_0_pPaymentjj</ssl_amount>
//  <ssl_cvv2cvc2_indicator>1</ssl_cvv2cvc2_indicator>
//  <ssl_cvv2cvc2>_jit_0_pCVVjj</ssl_cvv2cvc2>
//  <ssl_first_name>_jit_0_prntAttnjj</ssl_first_name></txn>



$fromPayment:=Record number:C243([Payment:28])
If ($fromPayment>-1)
	
	
	vOrdNum:=[Payment:28]orderNum:2
	pvAddress1:=[Payment:28]Address1:36
	pvZip:=[Payment:28]Zip:40
	//  pCreditCard:=
	//  pccDateStr:=
	//  pPayment:=
	//  pCVV:=
	//  prntAttn:=
	
Else 
	pCCDateStr:=WCapi_GetParameter("ccExpires"; "")
	
	$cvv:=WCapi_GetParameter("ccCVV"; "")
	$cardType:=WCapi_GetParameter("ccType"; "")  //Dan; Arkware (10/23/01)
	//
	If ($exDate#"")
		$ccDate:=Date_GoFigure($exDate)
	Else 
		$ccDate:=!00-00-00!
	End if 
	//
	C_TEXT:C284(vCCTag)
	vCCTag:=""
	//
	$creditCard:=WCapi_GetParameter("PayCCNumber1"; "")
	$payAmount1:=Num:C11(WCapi_GetParameter("PayAmount1"; ""))
	If ($payAmount1=0)
		$payAmount1:=Num:C11(WCapi_GetParameter("PayAmount"; ""))
		If (($payAmount1=0) & ($creditCard#""))
			$payAmount1:=[Order:3]total:27
		End if 
	End if 
	
	If ($payAmount1>0)
		$creditCard:=WCapi_GetParameter("PayCCNumber1"; "")
		$cardName:=WCapi_GetParameter("PayccName1"; "")
		$cardNameLast:=WCapi_GetParameter("PayccNameLast1"; "")
		$cardZip:=WCapi_GetParameter("PayccZip1"; "")
		$cardType:=WCapi_GetParameter("PayccType1"; "")
		$cardExpire:=WCapi_GetParameter("PayCCExpire1"; "")
		$cardCVV:=WCapi_GetParameter("PayCCCVV1"; "")
		$payTendered1:=Num:C11(WCapi_GetParameter("PayccTendered1"; ""))
		pvAddress1:=WCapi_GetParameter("pvAddress1"; "")
		If (pvAddress1="")
			pvAddress1:=[Order:3]address1:16
		End if 
		pvCity:=WCapi_GetParameter("pvCity"; "")
		If (pvCity="")
			pvCity:=[Order:3]city:18
		End if 
		pvZip:=WCapi_GetParameter("pvZip"; "")
		If (pvZip="")
			pvZip:=[Order:3]zip:20
		End if 
		//
		If (($payTendered1=0) & ($creditCard#"") & ($cardCVV#""))
			$payTendered1:=[Order:3]total:27
		End if 
		
	End if 
End if 


//  pPayment
//    // pBank:=
//  
//  $found:=Position($cardName;" ")
//  If ($found>0)
//  pvNameFirst:=Substring($cardName;1;$found-1)
//  pvNameLast:=Substring($cardName;$found+1)
//  End if 
//  prntAttn:=Substring($cardName;1;15)
//  
//  pCCDateStr
//  pCreditCard
//  pCCType
//  
//  pvAddress:=
//  pvCity:=
//  pvZip:=
//  pv
//  
//  pCardApprv
//  pCkNum
//  pvProcessorTransID