//%attributes = {"publishedWeb":true}
// Auth_AuthorizeNet
// Matt Hartzler 20010813

//01/31/03.prf
//Was Authorize.net type: ADC Direct Response, changed to
//Authorize.net type: Advanced Integration Method (AIM)

//http://www.authorize.net/support/online_documentation.pdf

// Settings
//Device:    6
//Host:      secure.authorize.net
//URL:/gateway/transact.dll
//Port:      443

//Test Visa Number: 4007000000027
//370000000000002 American Express 
//6011000000000012 Discover 
//5424000000000015 MasterCard 
//4007000000027 Visa
//Error card Number: 4222222222222
//   (set transaction amount = to desired error code)
C_LONGINT:C283($pos; $pos2; $error)
If (pvCardAction="Trap@")
	pDescript:="Trapped for processing at order shipment."
Else 
	C_TEXT:C284($0)  // any warning message
	$0:=""
	
	C_LONGINT:C283($1; $TransactionType)  //transaction type
	
	If ((<>AuthNetTestMode=True:C214) & (Is compiled mode:C492))
		ALERT:C41("Authorize Net is in test mode!!!")
	End if 
	
	C_TEXT:C284($curName)
	C_TEXT:C284($firstName; $lastName)
	//pos1 = used in loop, pos2 = postion before lastName
	$pos:=0
	$pos2:=0
	$curName:=prntAttn
	
	Repeat 
		$pos2:=$pos2+$pos  //position before last found space
		$pos:=Position:C15(" "; $curName)
		$curName:=Substring:C12($curName; $pos+1)
	Until ($pos=0)
	$lastName:=$curName
	If ($pos2>0)  // trim the last space off
		$pos2:=$pos2-1
	End if 
	$firstName:=Substring:C12(prntAttn; 0; $pos2)
	
	viAuthStat:=<>ciTASError
	
	pvPayHistory:=""
	C_LONGINT:C283(pvPayResponseCode)
	pvPayResponseCode:=0
	QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="CreditCards@"; *)
	QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8="Authorize.net")
	If (Records in selection:C76([TallyMaster:60])=1)
		C_TEXT:C284($beforeScript; $afterScript; $thePath)
		$beforeScript:=[TallyMaster:60]script:9
		$afterScript:=[TallyMaster:60]after:7
		vText4:=[TallyMaster:60]build:6
		$thePath:=[TallyMaster:60]path:28
		If ($beforeScript#"")
			ExecuteText(0; $beforeScript)
		End if 
		vText4:=TagsToText(vText4)
		$requestText:=vText4
		vText4:=""
	Else 
		C_TEXT:C284($requestText; $requestText)
		$requestText:="x_login="+<>tcCCVerUserName
		If (<>tcCCVerTranID#"")
			$requestText:=$requestText+"&x_tran_key="+<>tcCCVerTranID
		Else 
			If (allowAlerts_boo)
				ALERT:C41("Get from Authorized.Net a TransactionID.  Put in Defaults.")
			End if 
			$requestText:=$requestText+"&x_password="+<>tcCCVerPassword
		End if 
		//If (pCVV="")
		//$requestText:=$requestText+"&x_version=3.0"//no CVV code 3.0
		//Else 
		$requestText:=$requestText+"&x_version=3.1"  //no CVV code 3.0
		//End if 
		//$requestText:=$requestText+"&x_ADC_URL=FALSE"
		//$requestText:=$requestText+"&x_ADC_Delim_Data=TRUE"
		//$requestText:=$requestText+"&x_ADC_Delim_Data=TRUE"
		$requestText:=$requestText+"&x_delim_data=TRUE"
		$requestText:=$requestText+"&x_delim_char=,"
		$requestText:=$requestText+"&x_relay_response=FALSE"
		
		If (vInvNum>0)
			vlInvoiceNum:=vInvNum
		Else 
			vlInvoiceNum:=vOrdNum
		End if 
		//If (False)
		
		$requestText:=$requestText+"&x_company="+NTKString2HTML([Payment:28]company:48)
		$requestText:=$requestText+"&x_description="+NTKString2HTML([Order:3]mfrID:52+" - "+[Order:3]remoteRecordID:132+" - "+[Order:3]mfrName:91+" - "+String:C10([Order:3]idNum:2))
		
		$requestText:=$requestText+"&x_first_name="+NTKString2HTML($firstName)
		$requestText:=$requestText+"&x_last_name="+NTKString2HTML($lastName)
		//$requestText:=$requestText+"&x_company="+NTKString2HTML ($lastName)
		$requestText:=$requestText+"&x_address="+NTKString2HTML(pvAddress1)
		$requestText:=$requestText+"&x_city="+NTKString2HTML(pvCity)
		$requestText:=$requestText+"&x_state="+NTKString2HTML(pvState)
		$requestText:=$requestText+"&x_zip="+NTKString2HTML(pvZip)
		$requestText:=$requestText+"&x_country="+NTKString2HTML(pvCountry)
		$requestText:=$requestText+"&x_phone="+NTKString2HTML(pvPhone)  //format (123)123-4567
		$requestText:=$requestText+"&x_email="+NTKString2HTML(pvEmail)  //format (123)123-4567
		Case of 
			: (Not:C34(allowAlerts_boo))
				$requestText:=$requestText+"&x_freight="+NTKString2HTML(String:C10([Order:3]totalCost:42))
			: (ptCurTable=(->[Order:3]))
				$requestText:=$requestText+"&x_freight="+NTKString2HTML(String:C10([Order:3]totalCost:42))
			: (ptCurTable=(->[Invoice:26]))
				$requestText:=$requestText+"&x_freight="+NTKString2HTML(String:C10([Invoice:26]totalCost:37))
			Else 
				$requestText:=$requestText+"&x_freight="+NTKString2HTML(String:C10([Order:3]totalCost:42))
		End case 
		//$requestText:=$requestText+"&x_fax="+NTKString2HTML (pvFax)
		
		//
		$requestText:=$requestText+"&x_method=CC"  //add ECHECK some time add conditional statements
		
		//End if 
		$requestText:=$requestText+"&x_cust_id="+NTKString2HTML(vscustomerID)
		$requestText:=$requestText+"&x_invoice_num="+String:C10(vlInvoiceNum)
		
		If (pvCardAction="Credit@")
			$requestText:=$requestText+"&x_amount="+String:C10(-vrAuthAmt)
		Else 
			$requestText:=$requestText+"&x_amount="+String:C10(vrAuthAmt)
		End if 
		Case of 
			: (pvCardAction="Auth_Only@")  //hold for 30 days
				$requestText:=$requestText+"&x_type=AUTH_ONLY"
				//$requestText:=$requestText+"&x_authentication_indicator="  //cardholder authentication program only
				//$requestText:=$requestText+"&x_cardholder_authentication_value="  //cardholder authentication program only
			: (pvCardAction="Prior_Auth_Capture@")  //settle Auth_Only transaction
				$requestText:=$requestText+"&x_type=PRIOR_AUTH_CAPTURE"
				$requestText:=$requestText+"&x_trans_id="+pvProcessorTransID
			: (pvCardAction="Credit@")  //refund
				$requestText:=$requestText+"&x_type=CREDIT"
				$requestText:=$requestText+"&x_trans_id="+pvProcessorTransID
			: (pvCardAction="Void@")
				$requestText:=$requestText+"&x_type=VOID"
				$requestText:=$requestText+"&x_trans_id="+pvProcessorTransID
			: (pvCardAction="Capture_Only@")
				$requestText:=$requestText+"&x_type=CAPTURE_ONLY"
				$requestText:=$requestText+"&x_auth_code="+pvProcessorTransID
			: (pvCardAction="Auth_Capture@")  //normally default for retail sales
				$requestText:=$requestText+"&x_type=AUTH_CAPTURE"
				//$requestText:=$requestText+"&x_trans_id="+pvProcessorTransID
				//$requestText:=$requestText+"&x_authentication_indicator="  //cardholder authentication program only
				//$requestText:=$requestText+"&x_cardholder_authentication_value="  //cardholder authentication program only
			: (pvCardAction="Auth_Capture@")
				$requestText:=$requestText+"&x_type=AUTH_CAPTURE"
			Else 
				$requestText:=$requestText+"&x_type="+pvCardAction
		End case 
		$requestText:=$requestText+"&x_card_num="+NTKString2HTML(pCreditCard)
		$requestText:=$requestText+"&x_exp_date="+NTKString2HTML(vsAuthDate)
		If (pCVV="")
			//$requestText:=$requestText+"&x_card_code="+NTKString2HTML (pCVV)  //skipped to allow no vcc code
		Else 
			$requestText:=$requestText+"&x_card_code="+NTKString2HTML(pCVV)
		End if 
		$requestText:=$requestText+"&x_po_num="+NTKString2HTML(vsCustPONum)
		$requestText:=$requestText+"&x_tax="+String:C10(vrSalesTax)
		
		If (<>AuthNetTestMode=True:C214)
			$requestText:=$requestText+"&x_test_request=TRUE"
		End if 
		$requestText:=$requestText
	End if 
	iloText11:=$requestText
	//
	If (Not:C34(Is compiled mode:C492))
		KeyModifierCurrent
		[Payment:28]history:23:=[Payment:28]history:23+"\r"+"\r"+"/////////  Sending Begin "+String:C10(Current time:C178)+"   ///////////"+"\r"+$requestText+"\r"+"/////////  Sending End   ///////////"+"\r"
		If (capkey=1)
			SET TEXT TO PASTEBOARD:C523($requestText)
		End if 
	End if 
	
	
	// Make ITK connection, send post, and get results
	C_TEXT:C284($response)
	$response:=""
	C_TEXT:C284($response2)
	$response2:=""
	C_TEXT:C284($content)
	$content:=""
	C_TEXT:C284($content2)
	$content2:=""
	//
	SET BLOB SIZE:C606(HTTP_BlobSendData; 0)
	TEXT TO BLOB:C554($requestText; HTTP_BlobSendData; UTF8 text without length:K22:17)  //put the message into a blob
	// Make the connection
	
	C_BLOB:C604(HTTP_BlobReceive)
	
	C_TEXT:C284(HTTP_URL; HTTP_Protocol; HTTP_Host; HTTP_Path)
	C_LONGINT:C283(HTTP_Port; HTTP_TimeOut)
	C_BLOB:C604(HTTP_BlobSendData)
	//$url:="/gateway/transact.dll"
	//$host:="secure.authorize.net"
	//$port:=443
	//key variables to be defined
	//HTTPTestMode:=1 set in test mode	
	HTTP_TestMode:=0  //set in test mode
	HTTP_TimeOut:=10  //seconds
	HTTP_Protocol:="https"  //process as SSL
	HTTP_Method:="POST"  //method of sending
	HTTP_Path:=<>tcCCVerURL  //Server command
	HTTP_Host:=<>tcCCVerHost  //Server manchine
	HTTP_Port:=<>tcCCVerPort  //the Port
	
	
	// UpdateWithResources by: Bill James (2023-01-03T06:00:00Z)
	//$error:=B2B_Exchange
	
	$response:=BLOB to text:C555(HTTP_BlobReceive; UTF8 text without length:K22:17)  //convert returning message from blob to text
	//If (HTTPTestMode=1)
	//SET TEXT TO CLIPBOARD($response)
	//End if 
	
	If (Not:C34(Is compiled mode:C492))
		//[Payment]History:=[Payment]History+"\r"+"\r"+"/////////  Receive Begin "+String(Current time)+"   ///////////"+"\r"+$response+"\r"+"/////////  Sending End   /// ////////"+"\r"
		//SET TEXT TO CLIPBOARD($requestText)
	End if 
	
	
	
	Repeat 
		$p:=Position:C15(Storage:C1525.char.crlf+Storage:C1525.char.crlf; $response)
		If ($p>0)
			$response:=Substring:C12($response; $p+4)
		End if 
	Until ($p<1)
	
	If ($error=-1)  //&(Position("200 OK";$response)<1))// invalid  HTTP 200 OK Response
		If (Size of array:C274(aPayAuthFields)>0)
			viAuthStat:=Num:C11(aPayAuthFields{1})  //<>ciTASHideError//hide next error message, error reported here
		Else 
			viAuthStat:=0
		End if 
		$avsMessage:="Authorize.net did not respond (timed out).  Please try again."
		If ($avsMessage#"")  //&(<>doCCAlert))
			ALERT:C41($avsMessage)
		End if 
		pDescript:=$avsMessage
		ELog_NewRecord(-1; $response+"Auth.net"; "Receive timeout. Response = "+$response)
	Else 
		ELog_NewRecord(0; $requestText+"Auth.net"; $response)
		pvPayHistory:=$response+"\r"+Current user:C182
		C_LONGINT:C283($MaxElements)
		C_TEXT:C284($delim)
		C_LONGINT:C283($count)
		$maxElements:=100
		$delim:=","
		$count:=0
		ARRAY TEXT:C222(aPayAuthFields; 0)  // Array to hold the returned fields from authize.net
		var $c : Collection
		$c:=Split string:C1554($response; ";")
		COLLECTION TO ARRAY:C1562($c; aPayAuthFields)
		
		
		//aPayAuthFields  values
		//{1}  1=Approved, 2=Declined, 3=Error
		//{2}  internal to Auth.net
		//{3}  Reason Code
		//{4}  Reason Text
		//{5}  Approval Code, six digits
		//{6}  AVS Result Code, Address Verification System
		//{7}  TransactionID, used to track and make modifications
		//{8 - 37}  Echoed values
		//{39}  Card Code Varification, M=match, N=No Match, P=Not Processed, S=Should have been present, U=Issuer unable to process request
		//{40}  Cardholder Authentication, 0-7 = failed, 8=pass, 9=fail,  A-B = passed validation
		pvProcessorTransID:=aPayAuthFields{7}
		pvStatus:=aPayAuthFields{12}
		// Adress Verification results
		C_TEXT:C284($avsCode)
		C_TEXT:C284($avsMessage)
		pvPayResponseCode:=Num:C11(aPayAuthFields{1})
		$avsCode:=aPayAuthFields{6}
		Case of 
			: ($avsCode="A")
				$avsMessage:="ZIP does not match, Address (Street) does."
			: ($avsCode="E")
				$avsMessage:="Address verification system error."
			: ($avsCode="N")
				$avsMessage:="No match on Address (Street) or ZIP."
				//: ($avsCode="P")
				//$avsMessage:="Address verificatiion not applicable to this
				// transaction."
				
			: ($avsCode="R")
				$avsMessage:="Address verification system is unavailable."
			: ($avsCode="S")
				$avsMessage:="Address verification system not supported by issuer."
			: ($avsCode="U")
				$avsMessage:="Address information is unavailable, therefore could not be verified."
			: ($avsCode="W")
				$avsMessage:="Address (Street) does not match, 9 digit ZIP does."
			: ($avsCode="X")
				$avsMessage:="Address was matched exactly"
			: ($avsCode="Y")
				$avsMessage:="Address (Street) and 5 digit ZIP match"
			: ($avsCode="Z")
				$avsMessage:="5 digit ZIP matches, Address (Street) does not"
			: ($avsCode="B")
				$avsMessage:="No Address specified"
			: ($avsCode="G")
				$avsMessage:="Non U.S. Card Issuing Bank"
			Else 
				$avsMessage:=""
		End case 
		Case of 
			: (pvPayResponseCode=1)
				$avsMessage:="1-Approved"+"\r"+$avsMessage
			: (pvPayResponseCode=2)
				$avsMessage:="2-Dispproved"+"\r"+$avsMessage
			: (pvPayResponseCode=1)
				$avsMessage:="3-Error"+"\r"+$avsMessage
		End case 
		
		//CVV Responses
		//M Card code matches
		//N Card Code does not match
		//P Card Code was not processed
		//S Card Code should be on card b
		//U Issuer was not certified for Card Code
		
		
		
		
		
		pvError:=$avsCode
		
		// Grab values from parsed fields array
		Case of   // Map from authorize.net code to theCustomer code
			: (Num:C11(aPayAuthFields{1})=1)
				viAuthStat:=<>ciTASAuthed  //1
				//2/26/02 Dan - Moved Authorization and TransID to only be displayed when authed
				
				pCardApprv:=aPayAuthFields{5}
				pvProcessorTransID:=aPayAuthFields{7}
				$0:=$avsMessage  // return any warning message (card still authed)
				
				If (($avsMessage#"") & (<>doCCAlert))
					ALERT:C41($avsMessage)
				End if 
				//: (Num(aPayAuthFields{1})=2)
				//  viAuthStat:=<>ciTASDeclin
			: ((Num:C11(aPayAuthFields{1})=3) | (Num:C11(aPayAuthFields{1})=2))
				viAuthStat:=Num:C11(aPayAuthFields{1})  //<>ciTASHideError//hide next error message, error reported here
				C_TEXT:C284($errorText)
				Case of 
						//: (Num(aPayAuthFields{3})=1)
					: (Num:C11(aPayAuthFields{3})=2)
						$errorText:="This transaction has been declined.  General transaction decline."
					: (Num:C11(aPayAuthFields{3})=3)
						$errorText:="This transaction has been declined.  Voice referral decline."
					: (Num:C11(aPayAuthFields{3})=4)
						$errorText:="This transaction has been declined.  Card needs to be picked up."
					: (Num:C11(aPayAuthFields{3})=6)
						$errorText:="Invalid credit card number."
					: (Num:C11(aPayAuthFields{3})=8)
						$errorText:="Credit card has expired."
					: (Num:C11(aPayAuthFields{3})=11)
						$errorText:="Duplicate transaction has been submitted."
					: (Num:C11(aPayAuthFields{3})=19)
						$errorText:="Error occured during processing.  Try again in 5 minutes."
					: (Num:C11(aPayAuthFields{3})=27)
						$errorText:="AVS mismatch.  Address provided does not match billing address of cardholder."
					Else 
						QUERY:C277([zzzGenericChild2:91]; [zzzGenericChild2:91]lI01:6=Num:C11(aPayAuthFields{3}); *)
						QUERY:C277([zzzGenericChild2:91];  & [zzzGenericChild2:91]name:3="AIM_CC_ResponseCodes")
						If (Records in selection:C76([zzzGenericChild2:91])=1)
							$errorText:="("+aPayAuthFields{3}+") "+[zzzGenericChild2:91]t01:32+"\r"+[zzzGenericChild2:91]t02:33
						Else 
							$errorText:="status message returned ("+aPayAuthFields{3}+")"
						End if 
						REDUCE SELECTION:C351([zzzGenericChild2:91]; 0)
				End case 
				$avsMessage:=$avsMessage+"\r"+$errorText
				If (($avsMessage#"") & (<>doCCAlert) & (allowAlerts_boo))
					ALERT:C41($avsMessage)
				End if 
			Else 
				viAuthStat:=Num:C11(aPayAuthFields{1})  //<>ciTASHideError//hide next error message, error reported here
				$avsMessage:="Unknown status message returned: "+aPayAuthFields{4}
				If (($avsMessage#"") & (<>doCCAlert) & (allowAlerts_boo))
					ALERT:C41($avsMessage)
				End if 
		End case 
		pDescript:=$avsMessage+": "+aPayAuthFields{4}
		vsRspnText:=aPayAuthFields{4}  // display this when error or not?
	End if 
End if 

