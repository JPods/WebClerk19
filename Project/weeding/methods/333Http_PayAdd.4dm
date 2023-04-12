//%attributes = {"publishedWeb":true}
//// ----------------------------------------------------
//// User name (OS): williamjames
//// Date and time: 04/28/11, 22:04:18
//// ----------------------------------------------------
//// Method: 333Http_PayAdd
//// Description
//// 
////
//// Parameters
//// ----------------------------------------------------


////Method: 333Http_PayAdd
//C_LONGINT($1)
//C_POINTER($2)
////Dan; Arkware (10/23/01)
//C_BOOLEAN($3; $checkAuth)
//If (Count parameters>2)
//$checkAuth:=$3
//Else 
//$checkAuth:=True
//End if 

////see WC_StartUpShutDownFlip for definitions
////If (<>tcCCNameRefNum="")
////<>tcCCNameRefNum:="RefNum"
////End if 
////If (<>tcCCNameAuthNum="")
////<>tcCCNameAuthNum:="approval"
////End if 
////If (<>tcCCNameDocID="")
////<>tcCCNameDocID:="ordernumber"
////End if 
////If (<>tcCCNameTotal="")
////<>tcCCNameTotal:="fulltotal"
////End if 
////If (<>tcCCNameAVS="")
////<>tcCCNameAVS:="AVS"
////End if 
////If (<>tcCCNamePayType="")
////<>tcCCNamePayType:="payType"
////End if 
////If (<>tcCCNameAction="")
////<>tcCCNameAction:="payAction"
////End if 
////
//C_BOOLEAN($doPay1)  // Added Matt Hartzler; Arkware (8/23/01) 
//C_TEXT($chargeType; $errorMessage)  //Dan; Arkware (10/23/01)
//C_BOOLEAN($ccIsValid)

//$doPay1:=True  // set to false if payment record should not be saved

//$ordVal:=Num(WCapi_GetParameter(<>tcCCNameTotal; ""))
//$refNum:=WCapi_GetParameter(<>tcCCNameRefNum; "")
//$approval:=WCapi_GetParameter(<>tcCCNameAuthNum; "")
//$chargeType:=WCapi_GetParameter(<>tcCCNamePayType; "")  //Dan; Arkware (10/23/01)
//$myAction:=WCapi_GetParameter(<>tcCCNameAction; "")
////$creditCard:=String(Num($creditCard))
////TRACE
////Dan; Arkware (10/25/01)
//If (False)
//$errorMessage:=""
//If ($cardType="")
//$ccType:=CC_GetCCTypeConst($creditCard)
//$cardType:=CC_GetCCTypeString($ccType)
//End if 
//If (($ccType=<>ciCCIUnknwn) | ($ccType=<>ciCCIOther))
//$ccIsValid:=False
//$errorMessage:="Unknown card!"
//Else 
//If (CC_IsValidCC($creditCard))
//$ccIsValid:=True
//Else 
//$cardType:=""
//$ccIsValid:=False
//$errorMessage:="Failed checksum!"
//End if 
//End if 
//End if 





////
//$exDate:=WCapi_GetParameter("ccExpires"; "")

//$cvv:=WCapi_GetParameter("ccCVV"; "")
//$cardType:=WCapi_GetParameter("ccType"; "")  //Dan; Arkware (10/23/01)
////
//If ($exDate#"")
//$ccDate:=Date_GoFigure($exDate)
//Else 
//$ccDate:=!00-00-00!
//End if 
////
//C_TEXT(vCCTag)
//vCCTag:=""
////
//$creditCard:=WCapi_GetParameter("PayCCNumber1"; "")
//$payAmount1:=Num(WCapi_GetParameter("PayAmount1"; ""))
//If ($payAmount1=0)
//$payAmount1:=Num(WCapi_GetParameter("PayAmount"; ""))
//If (($payAmount1=0) & ($creditCard#""))
//$payAmount1:=[Order]total
//End if 
//End if 

//If ($payAmount1>0)
//$creditCard:=WCapi_GetParameter("PayCCNumber1"; "")
//$cardName:=WCapi_GetParameter("PayccName1"; "")
//$cardNameLast:=WCapi_GetParameter("PayccNameLast1"; "")
//$cardZip:=WCapi_GetParameter("PayccZip1"; "")
//$cardType:=WCapi_GetParameter("PayccType1"; "")
//$cardExpire:=WCapi_GetParameter("PayCCExpire1"; "")
//$cardCVV:=WCapi_GetParameter("PayCCCVV1"; "")
//$payTendered1:=Num(WCapi_GetParameter("PayccTendered1"; ""))
//pvAddress1:=WCapi_GetParameter("pvAddress1"; "")
//If (pvAddress1="")
//pvAddress1:=[Order]address1
//End if 
//pvCity:=WCapi_GetParameter("pvCity"; "")
//If (pvCity="")
//pvCity:=[Order]city
//End if 
//pvZip:=WCapi_GetParameter("pvZip"; "")
//If (pvZip="")
//pvZip:=[Order]zip
//End if 
////
//If (($payTendered1=0) & ($creditCard#"") & ($cardCVV#""))
//$payTendered1:=[Order]total
//End if 

//CREATE RECORD([Payment])

//If ($payAmount1>0)
//[Payment]amount:=$payAmount1
//[Payment]amountAvailable:=$payAmount1
//[Payment]tendered:=$payAmount1
//Else 
//[Payment]amount:=[Order]total
//[Payment]amountAvailable:=[Order]total
//[Payment]tendered:=[Order]total
//End if 
//If ([Payment]tendered>[Payment]amount)
//[Payment]change:=Round([Payment]tendered-[Payment]amount; <>tcDecimalTt)
//$payChange1:=[Payment]change
//End if 
//[Payment]idNumOrder:=[Order]idNum
//[Payment]customerID:=[Customer]customerID
//[Payment]customerPO:=[Order]customerPO
//[Payment]salesTax:=[Order]salesTax
//[Payment]address1:=[Customer]address1
//[Payment]address2:=[Customer]address2
//[Payment]city:=[Customer]city
//[Payment]zip:=[Customer]zip
//[Payment]checkNum:=[Customer]zip
//[Payment]bankFrom:=[Customer]address1
//[Payment]dateDocument:=Current date
//[Payment]timeReceived:=Current time
//[Payment]creditCardEncode:=CC_EncodeDecode(1; $creditCard; ->[Payment]creditCardBlob)  //pCreditCard zzzBJ 06/12/10 This is ##xxxxx## cc number
//[Payment]creditCardNum:=CC_ReturnXedOutCardNum($creditCard)
//[Payment]nameOnAcct:=$cardName
//[Payment]zip:=$cardZip
//[Payment]typePayment:=$cardType

//// Modified by: Bill James (2016-11-30T00:00:00) force an entry

//If (([Payment]typePayment="") & ($creditCard#""))
//[Payment]typePayment:="Credit Card"
//End if 
//$ccDate:=Date_GoFigure($cardExpire)
//[Payment]dateExpires:=$ccDate
//[Payment]creditCardCVV:=$cardCVV
//[Payment]status:="Hold_WebBased"
//$doPay1:=True

//C_BOOLEAN($doPay1)
//If (Not($ccIsValid))
//[Payment]comment:=[Payment]comment+" Credit card error: "+$errorMessage+Storage.char.crlf
//End if 
//C_REAL($payChange1; $payChange2; $payChange3; pPayChange)
//C_REAL($payAmount1; $payAmount2; $payAmount3)
//C_REAL($payTendered1; $payTendered2; $payTendered3)

//If (False)  // Modified by: williamjames (110428)

//Case of 
//: ((vWccSecurity>0) & ($payAmount1#0))  //(([Order]Terms="InStore")&
//$doPay1:=True
//CREATE RECORD([Payment])

//If ($payTendered1>0)
//[Payment]amount:=$payTendered1
//[Payment]amountAvailable:=$payTendered1
//[Payment]tendered:=$payTendered1
//Else 
//[Payment]amount:=[Order]total
//[Payment]amountAvailable:=[Order]total
//[Payment]tendered:=[Order]total
//End if 
//If ([Payment]tendered>[Payment]amount)
//[Payment]change:=Round([Payment]tendered-[Payment]amount; <>tcDecimalTt)
//$payChange1:=[Payment]change
//End if 
//[Payment]idNumOrder:=[Order]idNum
//[Payment]customerID:=[Customer]customerID
//[Payment]customerPO:=[Order]customerPO
//[Payment]salesTax:=[Order]salesTax
//[Payment]address1:=[Customer]address1
//[Payment]address2:=[Customer]address2
//[Payment]city:=[Customer]city
//[Payment]zip:=[Customer]zip
//[Payment]checkNum:=[Customer]zip
//[Payment]bankFrom:=[Customer]address1
//[Payment]dateDocument:=Current date
//[Payment]creditCardEncode:=CC_EncodeDecode(1; $creditCard; ->[Payment]creditCardBlob)  //pCreditCard zzzBJ 06/12/10 This is ##xxxxx## cc number
//[Payment]creditCardNum:=CC_ReturnXedOutCardNum($creditCard)
//[Payment]nameOnAcct:=$cardName
//[Payment]zip:=$cardZip
//[Payment]typePayment:=$cardType
//$ccDate:=Date_GoFigure($cardExpire)
//[Payment]dateExpires:=$ccDate
//[Payment]creditCardCVV:=$cardCVV
//[Payment]status:="Hold_WebBased"

//: ([Customer]terms="CC_Secure")
//[Payment]creditCardNum:=String(vleventID)
//[Payment]cardApproval:="Web"
//[Payment]nameOnAcct:=$approval
//vCCTag:=$approval
//If ($ordVal#[Order]total)
//[Payment]comment:=[Payment]comment+"Alert:"+String($ordVal)
//End if 
//: ([Customer]terms="CC_SSLSecure")

//vCCTag:=CC_ReturnXedOutCardNum($creditCard)
//If (<>tcCCNumStoreLast4Only)
//[Payment]creditCardNum:=vCCTag
//[Payment]creditCardEncode:=""
//Else 
//[Payment]creditCardEncode:=CC_EncodeDecode(1; $creditCard; ->[Payment]creditCardBlob)  //pCreditCard zzzBJ 06/12/10 This is ##xxxxx## cc number
//[Payment]creditCardNum:=vCCTag
//End if 
//C_TEXT(vCCAuth)
//C_TEXT(vCCAuthError)
//C_TEXT(vCCExpDate)
//C_TEXT(vCCNumber)
//C_TEXT(vCCTransID)
//C_LONGINT(vCCStatus)
//C_REAL(vCCTotal)
//vCCTotal:=$ordVal
//vCCExpDate:=Util_FormatDate($ccDate; "MMYY")
//vCCNumber:=$creditCard
//If ($checkAuth=True)  //Dan; Arkware (10/23/01)
//CC_Authorize(<>ciATAuthCap; ->[Payment]amount; ->vCCNumber; ->vCCExpDate; ->vCCStatus; ->vsDLState; ->vsTrack1; ->vsTrack2; ->vCCAuth; ->vsReferNum; ->vCCAuthError; ->viCardType; ->viCardIssue; ->vText1; ->vText2; ->[Payment]idNumOrder; ->[Payment]customerID; ->vCCTransID; ->[Payment]salesTax; ->[Payment]customerPO; ->$approval)
//If (vCCStatus#<>ciTASAuthed)
//$doPay1:=False
//[Payment]comment:=[Payment]comment+Storage.char.crlf+vCCAuthError
//End if 
//Else 
//vCCAuth:="Pend"
//End if 
//[Payment]cardApproval:=vCCAuth  //used to be "SSLi"   
//[Payment]dateExpires:=$ccDate
//[Payment]processorTransid:=vCCTransID
//If ($cardName#"")
//[Payment]nameOnAcct:=$cardName
//End if 
//If ($refNum#"")
//[Payment]checkNum:=$refNum
//End if 
//If ($approval#"")
//[Payment]bankFrom:=$approval
//End if 
//Else 
//[Payment]cardApproval:="Err"
//End case 
//End if 

//If (<>vWebCustBalMaxOrd>0)
//[Payment]amountAvailable:=0
//[Payment]comment:="Paid with Points"
//[Payment]typePayment:="PaidByPoints"
//End if 
//pCreditCard:=[Payment]creditCardNum  //xxed out
//[Customer]creditCardNum:=[Payment]creditCardNum  //xxed out
//If (Record number([Payment])>-1)
//COPY BLOB([Payment]creditCardBlob; [Customer]creditCardBlob; 0; 0; BLOB size([Payment]creditCardBlob))
//End if 
//[Customer]creditCardCVV:=[Payment]creditCardCVV
//[Customer]creditCardExpir:=[Payment]dateExpires
//SAVE RECORD([Customer])
////End if 

//If ($doPay1)  // this is all part of Payment#1
//SAVE RECORD([Payment])
//Ledger_PaySave
//End if 
////
////TRACE
//$payAmount2:=Num(WCapi_GetParameter("PayAmount2"; ""))
//$cardType2:=WCapi_GetParameter("PayType2"; "")
//If (($payAmount2>0) & ($cardType2#""))
//$payTendered2:=Num(WCapi_GetParameter("PayTendered2"; ""))
//$payChange2:=Num(WCapi_GetParameter("PayChange2"; ""))
////
//$payCC:=WCapi_GetParameter("PayCCNumber2"; "")
//$cardName:=WCapi_GetParameter("PayccName2"; "")
//$cardZip:=WCapi_GetParameter("PayccZip2"; "")
//$cardType:=WCapi_GetParameter("PayType2"; "")
//$cardExpire:=WCapi_GetParameter("PayCCExpire2"; "")
//$cardCVV:=WCapi_GetParameter("PayCCCVV2"; "")

//$reportPurpose:=WCapi_GetParameter("Purpose"; "")
//$reportName:=WCapi_GetParameter("Name"; "")


//CREATE RECORD([Payment])

//[Payment]amount:=$payAmount2
//[Payment]amountAvailable:=$payAmount2
//[Payment]tendered:=$payAmount2
//If (False)  //// Modified by: williamjames (4/28/11)
//If ([Payment]tendered>[Payment]amount)
//[Payment]change:=Round([Payment]tendered-[Payment]amount; <>tcDecimalTt)
//$payChange1:=[Payment]change
//End if 
//End if 
//[Payment]idNumOrder:=[Order]idNum
//[Payment]customerID:=[Customer]customerID
//[Payment]customerPO:=[Order]customerPO
//[Payment]salesTax:=[Order]salesTax
//[Payment]address1:=[Customer]address1
//[Payment]address2:=[Customer]address2
//[Payment]city:=[Customer]city
//[Payment]zip:=[Customer]zip
//[Payment]checkNum:=[Customer]zip
//[Payment]bankFrom:=[Customer]address1
//[Payment]dateDocument:=Current date
//[Payment]dtCC:=DateTime_DTTo
//[Payment]creditCardEncode:=CC_EncodeDecode(1; $creditCard; ->[Payment]creditCardBlob)  //pCreditCard zzzBJ 06/12/10 This is ##xxxxx## cc number
//[Payment]creditCardNum:=CC_ReturnXedOutCardNum($creditCard)
//[Payment]nameOnAcct:=$cardName
//[Payment]zip:=$cardZip
//[Payment]typePayment:=$cardType
//$ccDate:=Date_GoFigure($cardExpire)
//[Payment]dateExpires:=$ccDate
//[Payment]creditCardCVV:=$cardCVV
//[Payment]status:="Hold_WebBased"
//$doPay1:=True
//If (False)  //// Modified by: williamjames (4/28/11)
//If ([Payment]tendered>[Payment]amount)
//[Payment]change:=Round([Payment]tendered-[Payment]amount; <>tcDecimalTt)
//$payChange2:=[Payment]change
//End if 
//End if 
//SAVE RECORD([Payment])
//Ledger_PaySave

//If (($reportPurpose#"") & ($reportName#""))
//Execute_TallyMaster($reportName; $reportPurpose)
//End if 

//Else 
//$payAmount2:=0
//End if 
////
//$payAmount3:=Num(WCapi_GetParameter("PayAmount3"; ""))
//$cardType3:=WCapi_GetParameter("PayType3"; "")
//If (($payAmount3>0) & ($cardType3#""))
//$payTendered3:=Num(WCapi_GetParameter("PayTendered3"; ""))
//$payChange3:=Num(WCapi_GetParameter("PayChange3"; ""))
////
//$payCC:=WCapi_GetParameter("PayCCNumber3"; "")
//$cardName:=WCapi_GetParameter("PayccName3"; "")
//$cardZip:=WCapi_GetParameter("PayccZip3"; "")
//$cardType:=WCapi_GetParameter("PayType3"; "")
//$cardExpire:=WCapi_GetParameter("PayCCExpire3"; "")
//$cardCVV:=WCapi_GetParameter("PayCCCVV3"; "")

//CREATE RECORD([Payment])

//[Payment]amount:=$payAmount3
//[Payment]amountAvailable:=$payAmount3
//[Payment]tendered:=$payAmount3
//If (False)  //// Modified by: williamjames (4/28/11)
//If ([Payment]tendered>[Payment]amount)
//[Payment]change:=Round([Payment]tendered-[Payment]amount; <>tcDecimalTt)
//$payChange1:=[Payment]change
//End if 
//End if 
//[Payment]idNumOrder:=[Order]idNum
//[Payment]customerID:=[Customer]customerID
//[Payment]customerPO:=[Order]customerPO
//[Payment]salesTax:=[Order]salesTax
//[Payment]address1:=[Customer]address1
//[Payment]address2:=[Customer]address2
//[Payment]city:=[Customer]city
//[Payment]zip:=[Customer]zip
//[Payment]checkNum:=[Customer]zip
//[Payment]bankFrom:=[Customer]address1
//[Payment]dateDocument:=Current date
//[Payment]creditCardEncode:=CC_EncodeDecode(1; $creditCard; ->[Payment]creditCardBlob)  //pCreditCard zzzBJ 06/12/10 This is ##xxxxx## cc number
//[Payment]creditCardNum:=CC_ReturnXedOutCardNum($creditCard)
//[Payment]nameOnAcct:=$cardName
//[Payment]zip:=$cardZip
//[Payment]typePayment:=$cardType
//$ccDate:=Date_GoFigure($cardExpire)
//[Payment]dateExpires:=$ccDate
//[Payment]creditCardCVV:=$cardCVV
//[Payment]status:="Hold_WebBased"
//If (False)
//If ([Payment]tendered>[Payment]amount)
//[Payment]change:=Round([Payment]tendered-[Payment]amount; <>tcDecimalTt)
//$payChange3:=[Payment]change
//End if 
//End if 
//SAVE RECORD([Payment])
//Ledger_PaySave
//Else 
//$payAmount3:=0
//End if 
////
//If (<>vWebCustBalMaxOrd>0)
//PUSH RECORD([Order])
//Ledger_TallyBal(False; False)
//SAVE RECORD([Customer])
////  //  CHOPPED FillInvArrays(0; 0; 0; 0)
//POP RECORD([Order])
//End if 
//QUERY([Payment]; [Payment]idNumOrder=[Order]idNum)
//pPayAmount:=Sum([Payment]amount)
//pPayTendered:=$payTendered1+$payTendered2+$payTendered3
//pPayChange:=$payChange1+$payChange2+$payChange3
////TRACE
//pvPayAmount:=String(pPayAmount)
//[Order]tendered:=pPayTendered
//[Order]tenderedChange:=pPayChange
//[Order]balanceDueEstimated:=[Order]total-pPayAmount
//Else 
//$doPay1:=False
//End if 
//If ([Order]idNum>0)
//SAVE RECORD([Order])
//Else 
//[EventLog]areYouHuman:="zeroOrder"
//EventLogsMessage("Trying to save a zero Order 333Http_PayAdd.")
//End if 
//pPayBalance:=[Order]balanceDueEstimated