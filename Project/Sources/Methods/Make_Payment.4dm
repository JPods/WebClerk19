//%attributes = {"publishedWeb":true}



// 333Http_PayAdd


// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/28/11, 22:04:18
// ----------------------------------------------------
// Method: 333Http_PayAdd
// Description
// 
//
// Parameters
// ----------------------------------------------------


//Method: 333Http_PayAdd
C_LONGINT:C283($1)
C_POINTER:C301($2)
//Dan; Arkware (10/23/01)
C_BOOLEAN:C305($3; $checkAuth)
If (Count parameters:C259>2)
	$checkAuth:=$3
Else 
	$checkAuth:=True:C214
End if 

//see WC_StartUpShutDownFlip for definitions
//If (<>tcCCNameRefNum="")
//<>tcCCNameRefNum:="RefNum"
//End if 
//If (<>tcCCNameAuthNum="")
//<>tcCCNameAuthNum:="approval"
//End if 
//If (<>tcCCNameDocID="")
//<>tcCCNameDocID:="ordernumber"
//End if 
//If (<>tcCCNameTotal="")
//<>tcCCNameTotal:="fulltotal"
//End if 
//If (<>tcCCNameAVS="")
//<>tcCCNameAVS:="AVS"
//End if 
//If (<>tcCCNamePayType="")
//<>tcCCNamePayType:="payType"
//End if 
//If (<>tcCCNameAction="")
//<>tcCCNameAction:="payAction"
//End if 
//
C_BOOLEAN:C305($doPay1)  // Added Matt Hartzler; Arkware (8/23/01) 
C_TEXT:C284($chargeType; $errorMessage)  //Dan; Arkware (10/23/01)
C_BOOLEAN:C305($ccIsValid)

$doPay1:=True:C214  // set to false if payment record should not be saved

$ordVal:=Num:C11(WCapi_GetParameter(<>tcCCNameTotal; ""))
$refNum:=WCapi_GetParameter(<>tcCCNameRefNum; "")
$approval:=WCapi_GetParameter(<>tcCCNameAuthNum; "")
$chargeType:=WCapi_GetParameter(<>tcCCNamePayType; "")  //Dan; Arkware (10/23/01)
$myAction:=WCapi_GetParameter(<>tcCCNameAction; "")
//$creditCard:=String(Num($creditCard))
//TRACE
//Dan; Arkware (10/25/01)
If (False:C215)
	$errorMessage:=""
	If ($cardType="")
		$ccType:=CC_GetCCTypeConst($creditCard)
		$cardType:=CC_GetCCTypeString($ccType)
	End if 
	If (($ccType=<>ciCCIUnknwn) | ($ccType=<>ciCCIOther))
		$ccIsValid:=False:C215
		$errorMessage:="Unknown card!"
	Else 
		If (CC_IsValidCC($creditCard))
			$ccIsValid:=True:C214
		Else 
			$cardType:=""
			$ccIsValid:=False:C215
			$errorMessage:="Failed checksum!"
		End if 
	End if 
End if 





//
$exDate:=WCapi_GetParameter("ccExpires"; "")

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
	
	CREATE RECORD:C68([Payment:28])
	
	If ($payAmount1>0)
		[Payment:28]amount:1:=$payAmount1
		[Payment:28]amountAvailable:19:=$payAmount1
		[Payment:28]tendered:44:=$payAmount1
	Else 
		[Payment:28]amount:1:=[Order:3]total:27
		[Payment:28]amountAvailable:19:=[Order:3]total:27
		[Payment:28]tendered:44:=[Order:3]total:27
	End if 
	If ([Payment:28]tendered:44>[Payment:28]amount:1)
		[Payment:28]change:45:=Round:C94([Payment:28]tendered:44-[Payment:28]amount:1; <>tcDecimalTt)
		$payChange1:=[Payment:28]change:45
	End if 
	[Payment:28]idNumOrder:2:=[Order:3]idNum:2
	[Payment:28]customerID:4:=[Customer:2]customerID:1
	[Payment:28]customerPO:33:=[Order:3]customerPO:3
	[Payment:28]salesTax:32:=[Order:3]salesTax:28
	[Payment:28]address1:36:=[Customer:2]address1:4
	[Payment:28]address2:37:=[Customer:2]address2:5
	[Payment:28]city:38:=[Customer:2]city:6
	[Payment:28]zip:40:=[Customer:2]zip:8
	[Payment:28]checkNum:12:=[Customer:2]zip:8
	[Payment:28]bankFrom:9:=[Customer:2]address1:4
	[Payment:28]dateDocument:10:=Current date:C33
	[Payment:28]timeReceived:52:=Current time:C178
	[Payment:28]creditCardEncode:50:=CC_EncodeDecode(1; $creditCard; ->[Payment:28]creditCardBlob:53)  //pCreditCard zzzBJ 06/12/10 This is ##xxxxx## cc number
	[Payment:28]creditCardNum:13:=CC_ReturnXedOutCardNum($creditCard)
	[Payment:28]nameOnAcct:11:=$cardName
	[Payment:28]zip:40:=$cardZip
	[Payment:28]typePayment:6:=$cardType
	
	// Modified by: Bill James (2016-11-30T00:00:00) force an entry
	
	If (([Payment:28]typePayment:6="") & ($creditCard#""))
		[Payment:28]typePayment:6:="Credit Card"
	End if 
	$ccDate:=Date_GoFigure($cardExpire)
	[Payment:28]dateExpires:14:=$ccDate
	[Payment:28]creditCardCVV:35:=$cardCVV
	[Payment:28]status:46:="Hold_WebBased"
	$doPay1:=True:C214
	
	C_BOOLEAN:C305($doPay1)
	If (Not:C34($ccIsValid))
		[Payment:28]comment:5:=[Payment:28]comment:5+" Credit card error: "+$errorMessage+Storage:C1525.char.crlf
	End if 
	C_REAL:C285($payChange1; $payChange2; $payChange3; pPayChange)
	C_REAL:C285($payAmount1; $payAmount2; $payAmount3)
	C_REAL:C285($payTendered1; $payTendered2; $payTendered3)
	
	If (False:C215)  // Modified by: williamjames (110428)
		
		Case of 
			: ((vWccSecurity>0) & ($payAmount1#0))  //(([Order]Terms="InStore")&
				$doPay1:=True:C214
				CREATE RECORD:C68([Payment:28])
				
				If ($payTendered1>0)
					[Payment:28]amount:1:=$payTendered1
					[Payment:28]amountAvailable:19:=$payTendered1
					[Payment:28]tendered:44:=$payTendered1
				Else 
					[Payment:28]amount:1:=[Order:3]total:27
					[Payment:28]amountAvailable:19:=[Order:3]total:27
					[Payment:28]tendered:44:=[Order:3]total:27
				End if 
				If ([Payment:28]tendered:44>[Payment:28]amount:1)
					[Payment:28]change:45:=Round:C94([Payment:28]tendered:44-[Payment:28]amount:1; <>tcDecimalTt)
					$payChange1:=[Payment:28]change:45
				End if 
				[Payment:28]idNumOrder:2:=[Order:3]idNum:2
				[Payment:28]customerID:4:=[Customer:2]customerID:1
				[Payment:28]customerPO:33:=[Order:3]customerPO:3
				[Payment:28]salesTax:32:=[Order:3]salesTax:28
				[Payment:28]address1:36:=[Customer:2]address1:4
				[Payment:28]address2:37:=[Customer:2]address2:5
				[Payment:28]city:38:=[Customer:2]city:6
				[Payment:28]zip:40:=[Customer:2]zip:8
				[Payment:28]checkNum:12:=[Customer:2]zip:8
				[Payment:28]bankFrom:9:=[Customer:2]address1:4
				[Payment:28]dateDocument:10:=Current date:C33
				[Payment:28]creditCardEncode:50:=CC_EncodeDecode(1; $creditCard; ->[Payment:28]creditCardBlob:53)  //pCreditCard zzzBJ 06/12/10 This is ##xxxxx## cc number
				[Payment:28]creditCardNum:13:=CC_ReturnXedOutCardNum($creditCard)
				[Payment:28]nameOnAcct:11:=$cardName
				[Payment:28]zip:40:=$cardZip
				[Payment:28]typePayment:6:=$cardType
				$ccDate:=Date_GoFigure($cardExpire)
				[Payment:28]dateExpires:14:=$ccDate
				[Payment:28]creditCardCVV:35:=$cardCVV
				[Payment:28]status:46:="Hold_WebBased"
				
			: ([Customer:2]terms:33="CC_Secure")
				[Payment:28]creditCardNum:13:=String:C10(vleventID)
				[Payment:28]cardApproval:15:="Web"
				[Payment:28]nameOnAcct:11:=$approval
				vCCTag:=$approval
				If ($ordVal#[Order:3]total:27)
					[Payment:28]comment:5:=[Payment:28]comment:5+"Alert:"+String:C10($ordVal)
				End if 
			: ([Customer:2]terms:33="CC_SSLSecure")
				
				vCCTag:=CC_ReturnXedOutCardNum($creditCard)
				If (<>tcCCNumStoreLast4Only)
					[Payment:28]creditCardNum:13:=vCCTag
					[Payment:28]creditCardEncode:50:=""
				Else 
					[Payment:28]creditCardEncode:50:=CC_EncodeDecode(1; $creditCard; ->[Payment:28]creditCardBlob:53)  //pCreditCard zzzBJ 06/12/10 This is ##xxxxx## cc number
					[Payment:28]creditCardNum:13:=vCCTag
				End if 
				C_TEXT:C284(vCCAuth)
				C_TEXT:C284(vCCAuthError)
				C_TEXT:C284(vCCExpDate)
				C_TEXT:C284(vCCNumber)
				C_TEXT:C284(vCCTransID)
				C_LONGINT:C283(vCCStatus)
				C_REAL:C285(vCCTotal)
				vCCTotal:=$ordVal
				vCCExpDate:=Util_FormatDate($ccDate; "MMYY")
				vCCNumber:=$creditCard
				If ($checkAuth=True:C214)  //Dan; Arkware (10/23/01)
					CC_Authorize(<>ciATAuthCap; ->[Payment:28]amount:1; ->vCCNumber; ->vCCExpDate; ->vCCStatus; ->vsDLState; ->vsTrack1; ->vsTrack2; ->vCCAuth; ->vsReferNum; ->vCCAuthError; ->viCardType; ->viCardIssue; ->vText1; ->vText2; ->[Payment:28]idNumOrder:2; ->[Payment:28]customerID:4; ->vCCTransID; ->[Payment:28]salesTax:32; ->[Payment:28]customerPO:33; ->$approval)
					If (vCCStatus#<>ciTASAuthed)
						$doPay1:=False:C215
						[Payment:28]comment:5:=[Payment:28]comment:5+Storage:C1525.char.crlf+vCCAuthError
					End if 
				Else 
					vCCAuth:="Pend"
				End if 
				[Payment:28]cardApproval:15:=vCCAuth  //used to be "SSLi"   
				[Payment:28]dateExpires:14:=$ccDate
				[Payment:28]processorTransid:31:=vCCTransID
				If ($cardName#"")
					[Payment:28]nameOnAcct:11:=$cardName
				End if 
				If ($refNum#"")
					[Payment:28]checkNum:12:=$refNum
				End if 
				If ($approval#"")
					[Payment:28]bankFrom:9:=$approval
				End if 
			Else 
				[Payment:28]cardApproval:15:="Err"
		End case 
	End if 
	
	If (<>vWebCustBalMaxOrd>0)
		[Payment:28]amountAvailable:19:=0
		[Payment:28]comment:5:="Paid with Points"
		[Payment:28]typePayment:6:="PaidByPoints"
	End if 
	pCreditCard:=[Payment:28]creditCardNum:13  //xxed out
	[Customer:2]creditCardNum:53:=[Payment:28]creditCardNum:13  //xxed out
	If (Record number:C243([Payment:28])>-1)
		COPY BLOB:C558([Payment:28]creditCardBlob:53; [Customer:2]creditCardBlob:117; 0; 0; BLOB size:C605([Payment:28]creditCardBlob:53))
	End if 
	[Customer:2]creditCardCVV:114:=[Payment:28]creditCardCVV:35
	[Customer:2]creditCardExpir:54:=[Payment:28]dateExpires:14
	SAVE RECORD:C53([Customer:2])
	//End if 
	
	If ($doPay1)  // this is all part of Payment#1
		SAVE RECORD:C53([Payment:28])
		Ledger_PaySave
	End if 
	//
	//TRACE
	$payAmount2:=Num:C11(WCapi_GetParameter("PayAmount2"; ""))
	$cardType2:=WCapi_GetParameter("PayType2"; "")
	If (($payAmount2>0) & ($cardType2#""))
		$payTendered2:=Num:C11(WCapi_GetParameter("PayTendered2"; ""))
		$payChange2:=Num:C11(WCapi_GetParameter("PayChange2"; ""))
		//
		$payCC:=WCapi_GetParameter("PayCCNumber2"; "")
		$cardName:=WCapi_GetParameter("PayccName2"; "")
		$cardZip:=WCapi_GetParameter("PayccZip2"; "")
		$cardType:=WCapi_GetParameter("PayType2"; "")
		$cardExpire:=WCapi_GetParameter("PayCCExpire2"; "")
		$cardCVV:=WCapi_GetParameter("PayCCCVV2"; "")
		
		$reportPurpose:=WCapi_GetParameter("Purpose"; "")
		$reportName:=WCapi_GetParameter("Name"; "")
		
		
		CREATE RECORD:C68([Payment:28])
		
		[Payment:28]amount:1:=$payAmount2
		[Payment:28]amountAvailable:19:=$payAmount2
		[Payment:28]tendered:44:=$payAmount2
		If (False:C215)  //// Modified by: williamjames (4/28/11)
			If ([Payment:28]tendered:44>[Payment:28]amount:1)
				[Payment:28]change:45:=Round:C94([Payment:28]tendered:44-[Payment:28]amount:1; <>tcDecimalTt)
				$payChange1:=[Payment:28]change:45
			End if 
		End if 
		[Payment:28]idNumOrder:2:=[Order:3]idNum:2
		[Payment:28]customerID:4:=[Customer:2]customerID:1
		[Payment:28]customerPO:33:=[Order:3]customerPO:3
		[Payment:28]salesTax:32:=[Order:3]salesTax:28
		[Payment:28]address1:36:=[Customer:2]address1:4
		[Payment:28]address2:37:=[Customer:2]address2:5
		[Payment:28]city:38:=[Customer:2]city:6
		[Payment:28]zip:40:=[Customer:2]zip:8
		[Payment:28]checkNum:12:=[Customer:2]zip:8
		[Payment:28]bankFrom:9:=[Customer:2]address1:4
		[Payment:28]dateDocument:10:=Current date:C33
		[Payment:28]dtCC:58:=DateTime_DTTo
		[Payment:28]creditCardEncode:50:=CC_EncodeDecode(1; $creditCard; ->[Payment:28]creditCardBlob:53)  //pCreditCard zzzBJ 06/12/10 This is ##xxxxx## cc number
		[Payment:28]creditCardNum:13:=CC_ReturnXedOutCardNum($creditCard)
		[Payment:28]nameOnAcct:11:=$cardName
		[Payment:28]zip:40:=$cardZip
		[Payment:28]typePayment:6:=$cardType
		$ccDate:=Date_GoFigure($cardExpire)
		[Payment:28]dateExpires:14:=$ccDate
		[Payment:28]creditCardCVV:35:=$cardCVV
		[Payment:28]status:46:="Hold_WebBased"
		$doPay1:=True:C214
		If (False:C215)  //// Modified by: williamjames (4/28/11)
			If ([Payment:28]tendered:44>[Payment:28]amount:1)
				[Payment:28]change:45:=Round:C94([Payment:28]tendered:44-[Payment:28]amount:1; <>tcDecimalTt)
				$payChange2:=[Payment:28]change:45
			End if 
		End if 
		SAVE RECORD:C53([Payment:28])
		Ledger_PaySave
		
		If (($reportPurpose#"") & ($reportName#""))
			Execute_TallyMaster($reportName; $reportPurpose)
		End if 
		
	Else 
		$payAmount2:=0
	End if 
	//
	$payAmount3:=Num:C11(WCapi_GetParameter("PayAmount3"; ""))
	$cardType3:=WCapi_GetParameter("PayType3"; "")
	If (($payAmount3>0) & ($cardType3#""))
		$payTendered3:=Num:C11(WCapi_GetParameter("PayTendered3"; ""))
		$payChange3:=Num:C11(WCapi_GetParameter("PayChange3"; ""))
		//
		$payCC:=WCapi_GetParameter("PayCCNumber3"; "")
		$cardName:=WCapi_GetParameter("PayccName3"; "")
		$cardZip:=WCapi_GetParameter("PayccZip3"; "")
		$cardType:=WCapi_GetParameter("PayType3"; "")
		$cardExpire:=WCapi_GetParameter("PayCCExpire3"; "")
		$cardCVV:=WCapi_GetParameter("PayCCCVV3"; "")
		
		CREATE RECORD:C68([Payment:28])
		
		[Payment:28]amount:1:=$payAmount3
		[Payment:28]amountAvailable:19:=$payAmount3
		[Payment:28]tendered:44:=$payAmount3
		If (False:C215)  //// Modified by: williamjames (4/28/11)
			If ([Payment:28]tendered:44>[Payment:28]amount:1)
				[Payment:28]change:45:=Round:C94([Payment:28]tendered:44-[Payment:28]amount:1; <>tcDecimalTt)
				$payChange1:=[Payment:28]change:45
			End if 
		End if 
		[Payment:28]idNumOrder:2:=[Order:3]idNum:2
		[Payment:28]customerID:4:=[Customer:2]customerID:1
		[Payment:28]customerPO:33:=[Order:3]customerPO:3
		[Payment:28]salesTax:32:=[Order:3]salesTax:28
		[Payment:28]address1:36:=[Customer:2]address1:4
		[Payment:28]address2:37:=[Customer:2]address2:5
		[Payment:28]city:38:=[Customer:2]city:6
		[Payment:28]zip:40:=[Customer:2]zip:8
		[Payment:28]checkNum:12:=[Customer:2]zip:8
		[Payment:28]bankFrom:9:=[Customer:2]address1:4
		[Payment:28]dateDocument:10:=Current date:C33
		[Payment:28]creditCardEncode:50:=CC_EncodeDecode(1; $creditCard; ->[Payment:28]creditCardBlob:53)  //pCreditCard zzzBJ 06/12/10 This is ##xxxxx## cc number
		[Payment:28]creditCardNum:13:=CC_ReturnXedOutCardNum($creditCard)
		[Payment:28]nameOnAcct:11:=$cardName
		[Payment:28]zip:40:=$cardZip
		[Payment:28]typePayment:6:=$cardType
		$ccDate:=Date_GoFigure($cardExpire)
		[Payment:28]dateExpires:14:=$ccDate
		[Payment:28]creditCardCVV:35:=$cardCVV
		[Payment:28]status:46:="Hold_WebBased"
		If (False:C215)
			If ([Payment:28]tendered:44>[Payment:28]amount:1)
				[Payment:28]change:45:=Round:C94([Payment:28]tendered:44-[Payment:28]amount:1; <>tcDecimalTt)
				$payChange3:=[Payment:28]change:45
			End if 
		End if 
		SAVE RECORD:C53([Payment:28])
		Ledger_PaySave
	Else 
		$payAmount3:=0
	End if 
	//
	If (<>vWebCustBalMaxOrd>0)
		PUSH RECORD:C176([Order:3])
		//Ledger_TallyBal(False; False)
		SAVE RECORD:C53([Customer:2])
		
		POP RECORD:C177([Order:3])
	End if 
	QUERY:C277([Payment:28]; [Payment:28]idNumOrder:2=[Order:3]idNum:2)
	pPayAmount:=Sum:C1([Payment:28]amount:1)
	pPayTendered:=$payTendered1+$payTendered2+$payTendered3
	pPayChange:=$payChange1+$payChange2+$payChange3
	//TRACE
	pvPayAmount:=String:C10(pPayAmount)
	[Order:3]tendered:113:=pPayTendered
	[Order:3]tenderedChange:114:=pPayChange
	[Order:3]balanceDueEstimated:107:=[Order:3]total:27-pPayAmount
Else 
	$doPay1:=False:C215
End if 
If ([Order:3]idNum:2>0)
	SAVE RECORD:C53([Order:3])
Else 
	[EventLog:75]areYouHuman:36:="zeroOrder"
	EventLogsMessage("Trying to save a zero Order 333Http_PayAdd.")
End if 
pPayBalance:=[Order:3]balanceDueEstimated:107