//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-03-28T00:00:00, 15:57:12
// ----------------------------------------------------
// Method: PaymentsiLo
// Description
// Modified: 03/28/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($ptLastTable)
C_BOOLEAN:C305($fillFromPrevious; $doMore; $cancelOnLoad)
C_LONGINT:C283($formEvent; $currentRecord; currentRecord)
$formEvent:=Form event code:C388
$currentRecord:=Record number:C243([Payment:28])
If ($formEvent=On Load:K2:1)
	If (UserInPassWordGroup("MakePayment"))
		pCreditCardLast4:=""
		If (vHere>1)  //coming from another table's input layout
			If (Is new record:C668([Payment:28]))
				$ptLastTable:=ptCurTable
				$fillFromPrevious:=True:C214
				If ((vHere>2) & (Is new record:C668([Payment:28])))
					jAlertMessage(9204)
					CANCEL:C270
					$cancelOnLoad:=True:C214
				End if 
			End if 
		End if 
	End if 
End if 
If ($cancelOnLoad)
	// drop out
Else 
	If ($formEvent=On Unload:K2:2)
		UNLOAD RECORD:C212(ptCurTable->)  //set the record so it can be opened by others
		READ WRITE:C146(ptCurTable->)
		$cancelOnLoad:=False:C215
	Else 
		If ($formEvent=On Load:K2:1)
			If (process_o.tableParent#Null:C1517)
				Case of 
					: (process_o.tableParent="Order")
						QUERY:C277([Order:3]; [Order:3]id:139=process_o.idParent)
						QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
						
					: (process_o.tableParent="Invoice")
						QUERY:C277([Invoice:26]; [Invoice:26]id:103=process_o.idParent)
						QUERY:C277([Order:3]; [Order:3]idNum:2=[Invoice:26]idNumOrder:1)
						QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
				End case 
				If (Is new record:C668([Payment:28]))
					Case of 
						: (process_o.tableParent="Order")
							[Payment:28]amount:1:=[Order:3]balanceDueEstimated:107
							[Payment:28]amountAvailable:19:=[Order:3]balanceDueEstimated:107
							[Payment:28]tendered:44:=[Order:3]balanceDueEstimated:107
						: (process_o.tableParent="Invoice")
							[Payment:28]amount:1:=[Invoice:26]balanceDue:44
							[Payment:28]amountAvailable:19:=[Invoice:26]balanceDue:44
							[Payment:28]tendered:44:=[Invoice:26]balanceDue:44
					End case 
					[Payment:28]idNumOrder:2:=[Order:3]idNum:2
					[Payment:28]customerPO:33:=[Order:3]customerPO:3
					[Payment:28]salesTax:32:=[Order:3]salesTax:28
					[Payment:28]customerID:4:=[Customer:2]customerID:1
					[Payment:28]address1:36:=[Customer:2]address1:4
					[Payment:28]address2:37:=[Customer:2]address2:5
					[Payment:28]city:38:=[Customer:2]city:6
					[Payment:28]zip:40:=[Customer:2]zip:8
					[Payment:28]checkNum:12:=[Customer:2]zip:8
					[Payment:28]bankFrom:9:=[Customer:2]address1:4
					[Payment:28]dateDocument:10:=Current date:C33
					[Payment:28]timeReceived:52:=Current time:C178
					
					// Modified by: Bill James (2016-11-30T00:00:00) force an entry
					
					[Payment:28]status:46:="Hold"
				End if 
			Else 
				If (vHere>1)  //coming from another table's input layout
					If (Is new record:C668([Payment:28]))
						$ptLastTable:=ptCurTable
						$fillFromPrevious:=True:C214
					End if 
				End if 
			End if 
		End if 
		C_LONGINT:C283($formEvent)
		$formEvent:=iLoProcedure(->[Payment:28])
		//
		$doMore:=False:C215
		Case of 
			: (iLoRecordNew)  //set in iLoProcedure only once, new record
				
				$doMore:=True:C214
			: (iLoRecordChange)  //set in iLoProcedure only once, existing record
				pCreditCardLast4:=""
				If (Length:C16([Payment:28]creditCardNum:13)>1)
					If ([Payment:28]creditCardNum:13[[2]]#"x")
						$savedResult:=CC_ReturnXedOutCardNum([Payment:28]creditCardNum:13)
						$encryptResult:=CC_EncodeDecode(1; [Payment:28]creditCardNum:13; ->[Payment:28]creditCardBlob:53)  //save card encrypted
						[Payment:28]creditCardNum:13:=$savedResult
						pCreditCardLast4:=$savedResult
					End if 
				End if 
				$doMore:=True:C214
		End case 
		If ($doMore)  //action for the form regardless of new or existing record
			
			If ([Payment:28]status:46="Hold@")
				_O_OBJECT SET COLOR:C271([Payment:28]status:46; -(Black:K11:16+(256*Yellow:K11:2)))  //SET COLOR (bInfo;  (vForeground + (256 * vBackground)))
			Else 
				_O_OBJECT SET COLOR:C271([Payment:28]status:46; -(Black:K11:16+(256*White:K11:1)))
			End if 
			// confirm 20170419  changing from all devices
			// all choices should be values in a single array if such is necessary
			//If ((<>tcCcDevice#<>ciCCDevMaSu) & (<>tcCcDevice#<>ciCCDevMaMu) & (<>tcCcDevice#<>ciCCDevAuthNet) & (<>tcCcDevice#<>ciCCDevChase))
			If (<>tcCcDevice<1)
				OBJECT SET ENABLED:C1123(bAppCC; False:C215)
			End if 
			OBJECT SET ENABLED:C1123(bApply; False:C215)
			DISABLE MENU ITEM:C150(2; 1)
			DISABLE MENU ITEM:C150(2; 2)
			//Format_CreditCd (->[Payment]CreditCardNum)
			REDUCE SELECTION:C351([DCash:62]; 0)
			If ([Payment:28]cardApproval:15="")  //dan 9/20/02
				[Payment:28]cardApproval:15:="Pend"
			End if 
			If (([Payment:28]amount:1=0) & ([Payment:28]amountAvailable:19=0))
				OBJECT SET ENTERABLE:C238([Payment:28]amount:1; True:C214)
				//   SET ENTERABLE([Payment]AmntNOTApplied;True)
				OBJECT SET ENTERABLE:C238([Payment:28]typePayment:6; True:C214)
				OBJECT SET ENTERABLE:C238([Payment:28]dateDocument:10; True:C214)
			Else 
				OBJECT SET ENTERABLE:C238([Payment:28]amount:1; False:C215)
				OBJECT SET ENTERABLE:C238([Payment:28]amountAvailable:19; False:C215)
				OBJECT SET ENTERABLE:C238([Payment:28]typePayment:6; False:C215)
				OBJECT SET ENTERABLE:C238([Payment:28]dateDocument:10; False:C215)
				pPayment:=[Payment:28]amountAvailable:19
			End if 
			pCCDateStr:=String:C10(Month of:C24([Payment:28]dateExpires:14); "00")+Substring:C12(String:C10(Year of:C25([Payment:28]dateExpires:14); "0000"); 3; 2)
			C_LONGINT:C283($i; $k; $a)
			booAccept:=(([Payment:28]customerID:4#"") & ([Payment:28]dateDocument:10#!00-00-00!))  //(([Payment]Amount#0)|([Payment]AmountAvailable#0))&    
			
			// gkgkgk
			QUERY:C277([DCash:62]; [DCash:62]docApply:3=[Payment:28]idNum:8; *)
			QUERY:C277([DCash:62];  & [DCash:62]tableApply:2=Table:C252(->[Payment:28]))
			CREATE SET:C116([DCash:62]; "Current")
			
			QUERY:C277([DCash:62]; [DCash:62]dtDocument:4=[Payment:28]idNum:8; *)
			QUERY:C277([DCash:62];  & [DCash:62]tableReceive:8=Table:C252(->[Payment:28]))
			ADD TO SET:C119([DCash:62]; "Current")
			USE SET:C118("Current")
			CLEAR SET:C117("Current")
			
			//  Put  the formating in the form  jFormatPhone(->[Customer]phone)
			Case of 
				: ([Payment:28]customerID:4#"")
					If ([Payment:28]customerID:4#[Customer:2]customerID:1)
						QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Payment:28]customerID:4)
					End if 
					srCustomer:=[Customer:2]company:2
					srPhone:=[Customer:2]phone:13
					srAcct:=[Customer:2]customerID:1
					srZip:=[Customer:2]zip:8
				Else 
					REDUCE SELECTION:C351([Customer:2]; 0)
					srCustomer:=""
					srPhone:=""
					srAcct:=""
					srZip:=""
			End case 
			//  should we care -- //  CHOPPED DivD_SetFieldColor(->[Customer]division)
			//  should we care -- //  CHOPPED DivD_SetFieldColor(->[Customer]customerID)
			If (([Payment:28]exchangeAmount:26=0) & ([Payment:28]currency:22#"") & ([Payment:28]exchangeRate:21#1) | ([Payment:28]exchangeRate:21#0))
				$error:=Exch_GetCurr([Payment:28]currency:22)  //sets viExConPrec, viExDisPrec  
				[Payment:28]exchangeAmount:26:=Round:C94([Payment:28]exchangeRate:21*[Payment:28]amount:1; viExDisPrec)
				FixNAN(->[Payment:28]exchangeAmount:26)
			End if 
			OBJECT SET ENABLED:C1123(b16; False:C215)
			If (<>aPayAction>1)  //must be set to a value or cleared to force selection before processing credit transactions
				pvCardAction:=<>aPayAction{<>aPayAction}
			Else 
				pvCardAction:=""
			End if 
			C_TEXT:C284($encryptResult)
			If (BLOB size:C605([Payment:28]creditCardBlob:53)>0)  //&([Payment]CreditCardNum#"")&([Payment]CreditCardNum#"x@"))//BJ 6/12/10 
				//$encryptResult:=CC_EncodeDecode (1;[Payment]CreditCardNum;->[Payment]CreditCardBlob)//save card encrypted//BJ 6/12/10 
				$encryptResult:=CC_EncodeDecode(0; [Payment:28]creditCardEncode:50; ->[Payment:28]creditCardBlob:53)  //BJ 6/12/10 
			Else 
				
			End if 
			If (UserInPassWordGroup("CreditCardView"))
				pCreditCardLast4:=$encryptResult
				If ($encryptResult="")
					pCreditCardLast4:=[Payment:28]creditCardNum:13
				End if 
			Else 
				pCreditCardLast4:=[Payment:28]creditCardNum:13
			End if 
			Before_New(ptCurTable)  //last thing to do
		End if 
		//every cycle
		If ([Payment:28]complete:17)
			Case of 
				: (Modified:C32([Payment:28]amountAvailable:19))
					[Payment:28]amountAvailable:19:=Old:C35([Payment:28]amountAvailable:19)
					$message:=True:C214
				: (Modified:C32([Payment:28]amount:1))
					[Payment:28]amount:1:=Old:C35([Payment:28]amount:1)
					$message:=True:C214
				: (Modified:C32([Payment:28]idNumOrder:2))
					[Payment:28]idNumOrder:2:=Old:C35([Payment:28]idNumOrder:2)
					$message:=True:C214
				: (Modified:C32([Payment:28]idNumInvoice:3))
					[Payment:28]idNumInvoice:3:=Old:C35([Payment:28]idNumInvoice:3)
					$message:=True:C214
				: (Modified:C32([Payment:28]customerID:4))
					[Payment:28]customerID:4:=Old:C35([Payment:28]customerID:4)
					$message:=True:C214
				: (Modified:C32([Payment:28]bankDeposit:7))
					[Payment:28]bankDeposit:7:=Old:C35([Payment:28]bankDeposit:7)
					$message:=True:C214
				: (Modified:C32([Payment:28]obSync:20))
					[Payment:28]obSync:20:=Old:C35([Payment:28]obSync:20)
					$message:=True:C214
			End case 
			If ($message)
				jAlertMessage(10010)
				$message:=True:C214
			End if 
		End if 
		booAccept:=(([Payment:28]customerID:4#"") & ([Payment:28]dateDocument:10#!00-00-00!))
	End if 
End if 
