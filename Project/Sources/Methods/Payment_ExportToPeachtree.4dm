//%attributes = {}
// ----------------------------------------------------
// User name (OS): jmedlen
// Date and time: 03/22/15, 21:43:34
// ----------------------------------------------------
// Method: Payment_ExportToPeachtree
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (False:C215)
	// KennyBCookies_mb_v100
	//2/8/2008.nwd - Edits so that product returns end up in 106 not 110 and have a + sign instead of neg.
	//Also lumped discover into visa/mc
	// KBC_nwd_v110
	//5/15/08.nwd - I1140:changed from InvoiceNum to OrderNum on the export.
	// KBC_mb_v111
	//7/1/2008.mb
	//Changed cut-off time from 9PM to 11PM
	//issue number 1140
End if 

aaaDecUserVars  // declare the variables we need to use

C_TEXT:C284($paypal; $productReturn; $comma; $lineBreak; $paypalCashAcctNo; $generalCashAcctNo; $customerID; $distributionCode; $standardGLAcctNo; $AR_GLAcctNo; $productReturnGLAcctNo)
$paypal:="Paypal"  // string to identify paypal in TypePayment field
$productReturn:="Product Returns"  // TypePayment for returns
$comma:=","  // field break char char(9) is tab
$lineBreak:=Char:C90(13)  //line break char
$paypalCashAcctNo:="105"  //paypal CashAcct
$generalCashAcctNo:="106"  // general cashAcct
$financingCostAcctNo:="622"  // Financing cost accounts//
$customerID:="W"  //customer ID
$distributionCode:="1"  //Distribution
$standardGLAcctNo:="110"  //Accountgl standard
$AR_GLAcctNo:="416"  //Accountgl AR
$productReturnGLAcctNo:="120"  //Accountgl Product Return
$badDebtGLAcctNo:="619"  //Bad Debt GL Account Number

C_DATE:C307($someDayLastMonth)
If (Day of:C23(Current date:C33)>15)
	$someDayLastMonth:=Current date:C33-32
Else 
	$someDayLastMonth:=Current date:C33-27
End if 
jBetweenDates("Payment Export Date Range."; Date_ThisMon($someDayLastMonth; 0); Date_ThisMon($someDayLastMonth; 1))

If (OK=1)
	uTime1:=Create document:C266(""; "CSV")  // let user name the export - make the type CSV (comma delimited)
	If (OK=1)
		
		QUERY:C277([Payment:28]; [Payment:28]dateReceived:10>=vdDateBeg; *)
		QUERY:C277([Payment:28];  & ; [Payment:28]dateReceived:10<=vdDateEnd)
		
		SEND PACKET:C103(uTime1; "DateRecieved"+$comma)
		SEND PACKET:C103(uTime1; "Amount"+$comma)
		SEND PACKET:C103(uTime1; "Comment"+$comma)
		SEND PACKET:C103(uTime1; "InvoiceNum"+$comma)
		SEND PACKET:C103(uTime1; "CashAcct"+$comma)
		SEND PACKET:C103(uTime1; "Distribution"+$comma)
		SEND PACKET:C103(uTime1; "InvoicePd"+$comma)
		SEND PACKET:C103(uTime1; "Customer"+$comma)
		SEND PACKET:C103(uTime1; "Accountgl")
		SEND PACKET:C103(uTime1; $lineBreak)
		
		C_LONGINT:C283($depostDateOffset)
		$depostDateOffset:=0  //deposit date offset
		
		C_LONGINT:C283($indexPayments)
		For ($indexPayments; 1; Records in selection:C76([Payment:28]))
			C_TEXT:C284($dateRecvFirstLetterCode)
			$dateRecvFirstLetterCode:=""  // date recieved 1 letter  code - default to blank
			
			QUERY:C277([Order:3]; [Order:3]orderNum:2=[Payment:28]orderNum:2)
			// If no order is found [Order]TimeOrdered should be 0
			//   and [Order]CommentProcess should be and empty string
			
			// ---- Type, Source, and calculate deposit date offset---
			C_TEXT:C284($typePayment)
			$typePayment:=[Payment:28]typePayment:6
			C_LONGINT:C283($payTypeIndex)
			$payTypeIndex:=Find in array:C230(<>aPayTypes; $typePayment)  // try to find typePayment in payment type array
			C_BOOLEAN:C305($isCCPayment)
			If ($payTypeIndex>=0)
				$isCCPayment:=<>aTndClass{$payTypeIndex}=<>ciTCCrdtCrd  // check if type payment is a credit card
			Else 
				$isCCPayment:=False:C215  // payment type not found in payment list (assume not credit card)
			End if 
			If ($isCCPayment=True:C214)  // if credit card
				
				C_TEXT:C284($ccNum)
				$ccNum:=""  //creditCardNum
				C_LONGINT:C283($indexCCDigits)
				For ($indexCCDigits; 1; Length:C16([Payment:28]creditCardNum:13))
					If ((Character code:C91(Substring:C12([Payment:28]creditCardNum:13; $indexCCDigits; 1))>=48) & (Character code:C91(Substring:C12([Payment:28]creditCardNum:13; $indexCCDigits; 1))<=57))
						$ccNum:=$ccNum+Substring:C12([Payment:28]creditCardNum:13; $indexCCDigits; 1)
					End if 
				End for 
				C_LONGINT:C283($ccTypeConst)
				$ccTypeConst:=CC_GetCCTypeConst($ccNum)  // credit card type
				
				C_TEXT:C284($ccTypeCode)
				Case of 
					: ($ccTypeConst=<>ciCCIDiscov)
						//$ccTypeCode:="D"//2/8/08.nwd
						$ccTypeCode:="V"  //2/8/08.nwd - lump together with visa/mc
					: ($ccTypeConst=<>ciCCIAmEx)
						//$ccTypeCode:="A"//### jwm ###_20150322_1646 change this to "V" per Tim Kraft
						$ccTypeCode:="V"
					: ($ccTypeConst=<>ciCCIMstrCd)
						$ccTypeCode:="V"
					: ($ccTypeConst=<>ciCCIVisa)
						$ccTypeCode:="V"
					Else 
						$ccTypeCode:="-"  // some other card or invalid card number or length
				End case 
				
				C_DATE:C307($paymentDateReceived)
				//If ([Payment]TimeReceived>Time("21:00:00"))// greater than 9 pm then call it the next day
				If ([Payment:28]timeReceived:52>Time:C179("23:00:00"))  // greater than 11 pm then call it the next day 7/1/2008.mb.new
					$paymentDateReceived:=[Payment:28]dateReceived:10+1
				Else 
					$paymentDateReceived:=[Payment:28]dateReceived:10
				End if 
				
				// recieved code
				Case of 
					: (Day number:C114($paymentDateReceived)=1)  //sunday
						$dateRecvFirstLetterCode:="u"
					: (Day number:C114($paymentDateReceived)=2)  //mon
						$dateRecvFirstLetterCode:="m"
					: (Day number:C114($paymentDateReceived)=3)  //tue
						$dateRecvFirstLetterCode:="t"
					: (Day number:C114($paymentDateReceived)=4)  //wed
						$dateRecvFirstLetterCode:="w"
					: (Day number:C114($paymentDateReceived)=5)  //thu
						$dateRecvFirstLetterCode:="h"
					: (Day number:C114($paymentDateReceived)=6)  //fri
						$dateRecvFirstLetterCode:="f"
					: (Day number:C114($paymentDateReceived)=7)  //sat
						$dateRecvFirstLetterCode:="s"
				End case 
				
				// added if false 170406 with jim medlen because Tim does not want AMEx on a different date
				If (False:C215)  // ($ccTypeConst=<>ciCCIAmEx)  //american express processing
					Case of 
						: (Day number:C114($paymentDateReceived)=1)  //sunday
							$depostDateOffset:=5  // fri
						: (Day number:C114($paymentDateReceived)=2)  //mon
							$depostDateOffset:=4  // fri
						: (Day number:C114($paymentDateReceived)=3)  //tue
							$depostDateOffset:=6  // mon
						: (Day number:C114($paymentDateReceived)=4)  //wed
							$depostDateOffset:=5  // mon
						: (Day number:C114($paymentDateReceived)=5)  //thu
							$depostDateOffset:=4  // mon
						: (Day number:C114($paymentDateReceived)=6)  //fri
							$depostDateOffset:=4  //tue
						: (Day number:C114($paymentDateReceived)=7)  //sat
							$depostDateOffset:=4  // wed
					End case 
				Else 
					//If ($ccTypeConst=<>ciCCIDiscov)//discover processing
					//Case of 
					//: (Day number($paymentDateReceived)=1)//sunday
					//$depostDateOffset:=3// wed
					//: (Day number($paymentDateReceived)=2)//mon
					//$depostDateOffset:=2// wed
					//: (Day number($paymentDateReceived)=3)//tue
					//$depostDateOffset:=2// thu
					//: (Day number($paymentDateReceived)=4)//wed
					//$depostDateOffset:=2// fri
					//: (Day number($paymentDateReceived)=5)//thu
					//$depostDateOffset:=4// mon
					//: (Day number($paymentDateReceived)=6)//fri
					//$depostDateOffset:=4// tue
					//: (Day number($paymentDateReceived)=7)//sat
					//$depostDateOffset:=4// wed
					//End case 
					//
					//Else // all other credit card processing (visa & mc)
					Case of 
						: (Day number:C114($paymentDateReceived)=1)  //sunday
							$depostDateOffset:=2  // tue
						: (Day number:C114($paymentDateReceived)=2)  //mon
							$depostDateOffset:=2  // wed
						: (Day number:C114($paymentDateReceived)=3)  //tue
							$depostDateOffset:=2  // thu
						: (Day number:C114($paymentDateReceived)=4)  //wed
							$depostDateOffset:=2  // fri
						: (Day number:C114($paymentDateReceived)=5)  //thu
							$depostDateOffset:=4  // mon
						: (Day number:C114($paymentDateReceived)=6)  //fri
							$depostDateOffset:=4  // tue
						: (Day number:C114($paymentDateReceived)=7)  //sat
							$depostDateOffset:=3  // tue
					End case 
					//End if 
				End if 
				
			Else 
				$paymentDateReceived:=[Payment:28]dateReceived:10
				
				If ($typePayment=$paypal)  // paypal
					$ccTypeCode:="P"
					
					Case of 
						: (Day number:C114($paymentDateReceived)=1)  //sunday
							$depostDateOffset:=4  // thur
						: (Day number:C114($paymentDateReceived)=2)  //mon
							$depostDateOffset:=3  // thur
						: (Day number:C114($paymentDateReceived)=3)  //tue
							$depostDateOffset:=3  // fri
						: (Day number:C114($paymentDateReceived)=4)  //wed
							$depostDateOffset:=5  // mon
						: (Day number:C114($paymentDateReceived)=5)  //thu
							$depostDateOffset:=5  // tue
						: (Day number:C114($paymentDateReceived)=6)  //fri
							$depostDateOffset:=5  // wed
						: (Day number:C114($paymentDateReceived)=7)  //sat
							$depostDateOffset:=5  // thu
					End case 
					
				Else 
					If ($typePayment=$productReturn)  // product returns
						$ccTypeCode:="C"
						$depostDateOffset:=0  // 0 offset for deposit date
						
					Else   //cash/checks
						$ccTypeCode:="C"
						$depostDateOffset:=0  // 0 offset for deposit date
					End if 
				End if 
			End if 
			// ---- Deposit Date ---
			C_DATE:C307($depostDate)
			$depostDate:=$paymentDateReceived+$depostDateOffset
			C_TEXT:C284($depostDateString)
			$depostDateString:=String:C10(Month of:C24($depostDate))
			If (Month of:C24($depostDate)<10)
				$depostDateString:="0"+$depostDateString
			End if 
			If (Day of:C23($depostDate)<10)
				$depostDateString:=$depostDateString+"0"+String:C10(Day of:C23($depostDate))
			Else 
				$depostDateString:=$depostDateString+String:C10(Day of:C23($depostDate))
			End if 
			$depostDateString:=$depostDateString+Substring:C12(String:C10(Year of:C25($depostDate)); 3; 2)
			// $depostDateString is now formatted as MMDDYY
			
			//--- Cash Account Number ---
			C_TEXT:C284($cashAcctNo)
			Case of 
				: ($typePayment=$paypal)  // paypal
					$cashAcctNo:=$paypalCashAcctNo
				: ($typePayment=$productReturn)  // product returns
					$cashAcctNo:=$productReturnGLAcctNo
				: ($typePayment="AR Credit")  // AR Credit
					$cashAcctNo:=$AR_GLAcctNo
				: ($typePayment="Bad Debt")  // bad debt
					$cashAcctNo:=$badDebtGLAcctNo
				: ($typePayment="Sales Allowances")  // sales allowances
					$cashAcctNo:=$financingCostAcctNo
				Else 
					$cashAcctNo:=$generalCashAcctNo  // standard gl account
			End case 
			
			SEND PACKET:C103(uTime1; String:C10([Payment:28]dateReceived:10)+$comma)
			If ($typePayment=$productReturn)  // product returns
				SEND PACKET:C103(uTime1; String:C10([Payment:28]amount:1)+$comma)
			Else 
				SEND PACKET:C103(uTime1; String:C10(-[Payment:28]amount:1)+$comma)
			End if 
			SEND PACKET:C103(uTime1; $ccTypeCode+$depostDateString+$dateRecvFirstLetterCode+$comma)  // type / deposit / recieved day     (TMMDDYYR) 
			//SEND PACKET(uTime1;String([Payment]InvoiceNum)+$comma)//InvoiceNum
			SEND PACKET:C103(uTime1; String:C10([Payment:28]orderNum:2)+$comma)  //OrderNum  5/15/08.nwd - change export to OrderNum as that is what Nova gets and references.
			SEND PACKET:C103(uTime1; $cashAcctNo+$comma)  //CashAcct
			SEND PACKET:C103(uTime1; $distributionCode+$comma)  //Distribution
			SEND PACKET:C103(uTime1; ""+$comma)  //InvoicePd
			SEND PACKET:C103(uTime1; $customerID+$comma)  //Customer
			If ($typePayment=$productReturn)  // product returns
				SEND PACKET:C103(uTime1; $generalCashAcctNo)  //general cashAcct
			Else 
				SEND PACKET:C103(uTime1; $standardGLAcctNo)  //Accountgl
			End if 
			SEND PACKET:C103(uTime1; $lineBreak)
			
			// set comment to show type, deposit date, and source
			If ([Payment:28]comment:5#"")
				[Payment:28]comment:5:=[Payment:28]comment:5+$lineBreak  // add a line break after existing comment
			End if 
			[Payment:28]comment:5:=[Payment:28]comment:5+"Date Exported: "+String:C10(Current date:C33)+$lineBreak+"Comment Code: "+$ccTypeCode+$depostDateString+$dateRecvFirstLetterCode
			SAVE RECORD:C53([Payment:28])
			
			NEXT RECORD:C51([Payment:28])
		End for 
		CLOSE DOCUMENT:C267(uTime1)  // close export doc
	End if 
End if 

ALERT:C41("Done exporting "+String:C10(Records in selection:C76([Payment:28]))+" payments.")

