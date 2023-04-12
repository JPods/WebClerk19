//%attributes = {"publishedWeb":true}


// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 06:42:22
// ----------------------------------------------------
// Method: PaymentCreate
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("MakePayment"))
	
	C_LONGINT:C283($payInvoice; $i)
	C_POINTER:C301($1)
	C_LONGINT:C283($2; $testWindow)
	$testWindow:=0
	If (Count parameters:C259=2)
		$testWindow:=$2
	End if 
	C_REAL:C285($total)
	pvPayResponseCode:=-1
	Case of 
		: ($1=(->[Invoice:26]))
			$doPay:=False:C215
			Case of 
				: (Locked:C147([Invoice:26]))
					CONFIRM:C162("Invoice is locked, create unapplied payment.")
					If (OK=1)
						vMod:=calcInvoice(True:C214)
						$doPay:=True:C214
					Else 
						$doPay:=False:C215
					End if 
				: ((Record number:C243([Invoice:26])<0) | (Modified record:C314([Invoice:26])))
					//CONFIRM("Save this Invoice and create a payment.")
					//If (OK=1)
					//    SET CHANNEL(31;27658)//9600 8N1 DTR port 1 (drawer)
					//    SEND PACKET(Char(247))//247= 0F7H,  drawer dip 
					//                    settings= 00001000 1= on 0= off
					vMod:=True:C214
					
					
					acceptInvoice(vMod)
					If ((([Invoice:26]exchangeRate:61#0) | ([Invoice:26]exchangeRate:61#1)) & ([Invoice:26]currency:62#""))
						Exch_FillRays
						vMod:=calcInvoice(vMod)
					End if 
					$doPay:=True:C214
					//End if 
				Else 
					$doPay:=True:C214
			End case 
			If ($doPay)
				//
				If ([Invoice]shipAuto)
					[Invoice]shipAuto:=False:C215
					SAVE RECORD:C53([Invoice:26])
				End if 
				//
				pTotal:=Round:C94([Invoice:26]balanceDue:44; <>tcDecimalTt)
				vInvNum:=[Invoice:26]idNum:2
				vOrdNum:=[Invoice:26]idNumOrder:1
				prntAcct:=[Invoice:26]customerID:3
				C_TEXT:C284(sExchCurr)
				C_REAL:C285(rExchRate)
				IvcLnFillRays  //vLineCnt set if no order
				//sExchCurr:=[Invoice]Currency
				//rOExchRate:=[Invoice]ExchangeRate
				Pay_Add(1; 2; [Invoice:26]exchangeRate:61; [Invoice:26]currency:62)  //$payInvoice:=0     //$typeRayAd:=2
				sExchCurr:=<>tcMONEYCHAR
				rExchRate:=[Invoice:26]exchangeRate:61
				Pay_InvoiceSrch
				PayLoadShow(Records in selection:C76([Payment:28]))
				//If ($doExch)
				//Exch_FillRays 
				//calcInvoice (vMod)
				//End if 
				//   IvcLnFillVar(aiLineAction)
			End if 
		: ($1=(->[Order:3]))
			C_LONGINT:C283($i)
			vMod:=True:C214
			QUERY:C277([Payment:28]; [Payment:28]idNumOrder:2=[Order:3]idNum:2)
			If ((strCurrency=[Order:3]currency:69) & ([Order:3]currency:69#""))
				vMod:=calcOrder(True:C214)
				pTotal:=[Order:3]total:27
			Else 
				acceptOrders(vMod)
				FIRST RECORD:C50([Payment:28])
				For ($i; 1; Records in selection:C76([Payment:28]))
					$total:=$total+[Payment:28]amount:1
					NEXT RECORD:C51([Payment:28])
				End for 
				pTotal:=[Order:3]total:27-$total
			End if 
			vInvNum:=0
			$total:=0
			vOrdNum:=[Order:3]idNum:2
			Pay_Add(0; 2; [Order:3]exchangeRate:68; [Order:3]currency:69; $testWindow)  //$payInvoice:=0     //$typeRayAd:=2
			sExchCurr:=<>tcMONEYCHAR
			rExchRate:=[Order:3]exchangeRate:68
			QUERY:C277([Payment:28]; [Payment:28]idNumOrder:2=[Order:3]idNum:2)
			PayLoadShow(Records in selection:C76([Payment:28]))
			Ln_FillVar(aoLineAction; ->aOItemNum; ->aODescpt; 0; aOQtyOrder{aoLineAction}; aOQtyBL{aoLineAction}; aOUnitPrice{aoLineAction}; aODiscnt{aoLineAction}; aOExtPrice{aoLineAction}; aOPricePt{aoLineAction})
			
		: ($1=(->[Payment:28]))
			doSearch:=20  //set parameters for new payment
			C_LONGINT:C283($payInvoice; $typeRayAd)
			sExchCurr:=<>tcMONEYCHAR  //Change to add currency capability some day
			rExchRate:=1
			rOExchRate:=1
			$doPay:=True:C214
			If (aInvoices>0)
				$payInvoice:=1
				If (Locked:C147([Invoice:26]))
					CONFIRM:C162("Invoice is locked, create unapplied payment.")
					If (OK=1)
						$payInvoice:=0
					Else 
						$doPay:=False:C215
					End if 
				End if 
				TRACE:C157
				If ($doPay)
					
					IvcLnFillRays  //vLineCnt set if no order        
					If (([Invoice:26]currency:62#"") & (([Invoice:26]exchangeRate:61#0) | ([Invoice:26]exchangeRate:61#1)))
						strCurrency:=""
						//ptCurFile:=([Invoice])//so invoice exchange
						Exch_FillRays
						vMod:=calcInvoice(True:C214)
						// ptCurFile:=([Control])
					End if 
					If (myCycle=22)  // coming from applypay window so use the total selected
						pTotal:=viLoR1
					Else 
						pTotal:=Round:C94([Invoice:26]balanceDue:44; <>tcDecimalTt)
					End if 
					sExchCurr:=[Invoice:26]currency:62
					rOExchRate:=[Invoice:26]exchangeRate:61
					vInvNum:=[Invoice:26]idNum:2
					vOrdNum:=[Invoice:26]idNumOrder:1
					prntAcct:=[Invoice:26]customerID:3
				End if 
			Else 
				vInvNum:=0
				vOrdNum:=0
				pTotal:=0
				pPaidAmount:=0
				$payInvoice:=0
			End if 
			If ($doPay)
				// ptCurFile:=([Invoice])
				strCurrency:=sExchCurr
				Pay_Add($payInvoice; 1; rOExchRate; sExchCurr)
				// ptCurFile:=([Control])
			End if 
			aPayInvs:=0
			vi5:=0
			vi6:=0
			aInvoices:=0
			pTotal:=0
			pPayment:=0
			pDiff:=0
			pDiffCurr:=0
			sExchCurr:=<>tcMONEYCHAR
			rOExchRate:=1
			rExchRate:=1
			//$k:=Size of array(aPayments)+1
			//INSERT ELEMENT(aPayments;$k)
			//INSERT ELEMENT(aPayOrds;$k)
			//INSERT ELEMENT(aPayInvs;$k)
			//INSERT ELEMENT(aPayOrig;$k)
			//INSERT ELEMENT(aPayCom;$k)
			//INSERT ELEMENT(aPayRecs;$k)
			//INSERT ELEMENT(aPayCust;$k)
			//aPayments{$k}:=[Payment]AmountAvailable
			//aPayOrds{$k}:=[Payment]OrderKey
			//aPayInvs{$k}:=[Payment]InvoiceKey
			//aPayOrig{$k}:=[Payment]Amount
			//aPayCom{$k}:=[Payment]Comment
			//aPayRecs{$k}:=Record number([Payment])
			//aPayCust{$k}:=[Payment]CustomerKey
			//  --  CHOPPED  AL_UpdateArrays(ePay2App; -2)  //-2
			OBJECT SET ENABLED:C1123(bCancelB; False:C215)
	End case 
	SET TIMEOUT:C268(0)
	//ON SERIAL PORT CALL("")
End if 