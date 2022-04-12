//%attributes = {"publishedWeb":true}
//October 6, 1995
//Procedure: Auth_BatchLoop
If (False:C215)
	//02/10/03.prf
	//removed plugin S7P
	//TCStrong_prf_v144
	TCStrong_prf_v144_S7P
End if 

ALERT:C41("Method AE_BatchLoop disabled")

//commented out just the S7P calls

If (False:C215)
	
	C_LONGINT:C283($index; $NumDelay)
	C_BOOLEAN:C305(allowAlerts_boo; $allowAlert; $endThisLoop)
	$endThisLoop:=False:C215
	$allowAlert:=allowAlerts_boo
	allowAlerts_boo:=False:C215
	If (Is macOS:C1572)
		C_LONGINT:C283($timeOutDelay; $NumDelay)
		$NumDelay:=30
		$timeOutDelay:=120
		$cntLoops:=0
		CREATE SET:C116([Payment:28]; "OrigOrders")
		Repeat 
			CREATE EMPTY SET:C140([Payment:28]; "Current")
			C_LONGINT:C283($payIndex; $ris)
			$ris:=Records in selection:C76([Payment:28])
			FIRST RECORD:C50([Payment:28])
			For ($payIndex; 1; $ris)
				KeyModifierCurrent
				If (CmdKey=1)
					$timeOutDelay:=Num:C11(Request:C163("How many seconds for timeout?"; String:C10($timeOutDelay\60)))
				End if 
				//SetTimeout ($timeOutDelay)//02/10/03.prf
				If (OptKey=1)
					$NumDelay:=Num:C11(Request:C163("How many seconds between Authorizations?"; String:C10($NumDelay)))*60
				End if 
				If (ShftKey=1)
					$endThisLoop:=True:C214
					$payIndex:=$ris
				End if 
				If (([Payment:28]cardApproval:15="Pend") | ([Payment:28]cardApproval:15="SSLi") | ([Payment:28]cardApproval:15="Fail@"))
					If ([Payment:28]typePayment:6="")
						C_TEXT:C284($creditCardNum)
						$creditCardNum:=CC_EncodeDecode(0; ""; ->[Payment:28]creditCardBlob:53)
						[Payment:28]typePayment:6:=CC_ReturnCardType($creditCardNum)
					End if 
					<>aPayTypes:=Find in array:C230(<>aPayTypes; [Payment:28]typePayment:6)
					If ((<>aTndClass{<>aPayTypes}=<>ciTCCheck) | (<>aTndClass{<>aPayTypes}=<>ciTCCrdtCrd))
						pPayment:=[Payment:28]amount:1
						prntAcct:=[Payment:28]customerID:4
						pCreditCard:=CC_EncodeDecode(0; ""; ->[Payment:28]creditCardBlob:53)
						pDateExpire:=[Payment:28]dateExpires:14
						If (([Payment:28]bankFrom:9="") | ([Payment:28]checkNum:12=""))
							If ([Customer:2]customerID:1#[Payment:28]customerID:4)
								QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Payment:28]customerID:4)
							End if 
							[Payment:28]bankFrom:9:=[Customer:2]address1:4
							[Payment:28]checkNum:12:=[Customer:2]zip:8
							SAVE RECORD:C53([Customer:2])
						End if 
						pBank:=[Payment:28]bankFrom:9
						pCkNum:=[Payment:28]checkNum:12
						If ([Payment:28]invoiceNum:3>0)
							vlInvoiceNum:=[Payment:28]invoiceNum:3
						Else 
							vlInvoiceNum:=[Payment:28]orderNum:2
						End if 
						vscustomerID:=[Payment:28]customerID:4
						//    
						MESSAGE:C88("Posting: "+String:C10([Payment:28]idNum:8)+": "+String:C10([Payment:28]amount:1; "###,###,##0.00")+": "+[Payment:28]typePayment:6)
						Auth_PrepMacAth(True:C214)
						//
						MESSAGE:C88("Delay: "+String:C10(viAuthStat)+": "+String:C10([Payment:28]idNum:8)+": "+String:C10([Payment:28]amount:1; "###,###,##0.00")+": "+[Payment:28]typePayment:6)
						If ($payIndex#$ris)  //skip delay after the last record
							Tic_Delay($NumDelay)
						End if 
						//
						Case of 
							: (viAuthStat=<>ciTASAuthed)
								If ((vHere=1) & ([Order:3]orderNum:2#[Payment:28]orderNum:2))
									QUERY:C277([Order:3]; [Order:3]orderNum:2=[Payment:28]orderNum:2)
									[Order:3]status:59:="Pay_CC_OK"
									SAVE RECORD:C53([Order:3])
								End if 
								[Payment:28]dateReceived:10:=Current date:C33
								[Payment:28]cardApproval:15:=pCardApprv
								[Payment:28]referenceid:24:=pReferNum
								[Payment:28]creditCardNum:13:=CC_ReturnXedOutCardNum(pCreditCard)
								[Payment:28]creditCardEncode:50:=CC_EncodeDecode(1; pCreditCard; ->[Payment:28]creditCardBlob:53)
								[Payment:28]dateExpires:14:=pDateExpire
								$errStr:="Authorized "+String:C10(Current date:C33; 1)+" - "+String:C10(Current time:C178; 5)
							: (viAuthStat=<>ciTASDeclin)
								$errStr:="Transaction Declined!!!"
								[Payment:28]cardApproval:15:="Declined"
							: (viAuthStat=<>ciTASPhone)
								$errStr:="Call in to bank."
								[Payment:28]cardApproval:15:="Call"
							: (viAuthStat=<>ciTASError)
								$errStr:="Error in transaction."
								[Payment:28]cardApproval:15:="Fail_Error"
								ADD TO SET:C119([Payment:28]; "Current")
							: (viAuthStat=<>ciTASVoided)
								$errStr:="Transaction Voided."
								[Payment:28]cardApproval:15:="Voided"
							: (viAuthStat=<>ciTASOther)
								$errStr:="Error Type: Other."
								[Payment:28]cardApproval:15:="Fail_Other"
								ADD TO SET:C119([Payment:28]; "Current")
							: (viAuthStat=<>ciTASPickUp)
								$errStr:="Pick-Up Card!!!"
								[Payment:28]cardApproval:15:="Pickup Card"
							Else 
								$errStr:=""
								[Payment:28]cardApproval:15:="Fail_UNK"
								ADD TO SET:C119([Payment:28]; "Current")
						End case 
						MESSAGE:C88($errStr+": "+String:C10([Payment:28]idNum:8)+": "+String:C10([Payment:28]amount:1; "###,###,##0.00")+": "+[Payment:28]typePayment:6)
						If ($errStr#"")
							[Payment:28]history:23:=[Payment:28]history:23+("\r"*Num:C11([Payment:28]history:23#""))+$errStr+": "+String:C10($timeOutDelay\60)+": "+String:C10($NumDelay)
						End if 
						If (Modified record:C314([Payment:28]))
							SAVE RECORD:C53([Payment:28])
							Ledger_PaySave
						End if 
					End if 
				End if 
				If (Records in selection:C76([Payment:28])>1)
					NEXT RECORD:C51([Payment:28])
				End if 
			End for 
			USE SET:C118("Current")
			CLEAR SET:C117("Current")
			$cntLoops:=$cntLoops+1
			
		Until (($cntLoops>10) | ($endThisLoop))
		If (Records in selection:C76([Payment:28])>1)
			UNLOAD RECORD:C212([Payment:28])
		End if 
		//SetTimeout (-1)//02/10/03.prf
		USE SET:C118("OrigOrders")
		CLEAR SET:C117("OrigOrders")
	Else   //  If (Is macOS)
		jAlertMessage(18000)
	End if 
	allowAlerts_boo:=$allowAlert
	
End if 