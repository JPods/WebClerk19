//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-01-23T00:00:00, 23:36:30
// ----------------------------------------------------
// Method: Auth_PrepMacAth
// Description
// Modified: 01/23/17
// 
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284(pPayAction; pPayType)
//Procedure: Auth_PrepMacAth
//February 25, 1998
C_BOOLEAN:C305($1)  //run silent
C_REAL:C285(vrTendTtl)
C_TEXT:C284(pCreditCard)
C_TEXT:C284(vsAuthDate)
C_TEXT:C284($DateString)
C_REAL:C285(vrAuthAmt)
//Status type: pending=0; authed=1; declined=2
//referal=3, error=4,voided=5,other=6,pick-up=7
C_LONGINT:C283(viAuthStat)
C_TEXT:C284(pCardApprv)
C_TEXT:C284(vsReferNum)
C_TEXT:C284(vsDLState)
C_TEXT:C284(vsRspnText)  //authorization attempt response Text
C_LONGINT:C283(viCardIssue)
C_LONGINT:C283(viCardType)
C_LONGINT:C283(viCardType; viCardIssue)
C_LONGINT:C283(vlInvoiceNum)
C_TEXT:C284(vscustomerID)
C_TEXT:C284(pProcessorTransID)
C_REAL:C285(vrSalesTax)
C_TEXT:C284(vsCustPONum)
C_LONGINT:C283($TransType)
C_TEXT:C284(pvEmail)
//TRACE
If ((<>aTndClass{<>aPayTypes}=<>ciTCCheck) | (<>aTndClass{<>aPayTypes}=<>ciTCCrdtCrd))
	vsTrack1:=""
	vsTrack2:=""
	vrAuthAmt:=Round:C94(pPayment; 2)
	//$DateString:=String(pDateExpire;4)
	//Case of 
	//: (Length(pDateExpire)=6)
	//pDateExpire:=Substring(
	//: (Length(pDateExpire)=10)//mm/dd/yyyy --> mm/dd/yy
	//pDateExpire:=Substring(pDateExpire;1;6)+Substring(pDateExpire;9;2)
	//End case   
	Case of 
		: (<>aTndClass{<>aPayTypes}=<>ciTCCheck)  //Check tendered
			//$DateString:=pDateRcd
			//If (Length(pDateExpire)=10)//mm/dd/yyyy --> mm/dd/yy
			//pDateExpire:=Substring(pDateRcd;1;6)+Substring(pDateRcd;9;2)
			//End if 
			$DateString:=String:C10(pDateRcd)
			vsAuthDate:=Substring:C12($DateString; 1; 2)+Substring:C12($DateString; 4; 2)+Substring:C12($DateString; 7; 2)
			If (True:C214)  //need default (MICR vs DL Check Guarantee)
				viCardType:=<>ciACTCkMICR
			Else 
				viCardType:=<>ciACTChckDL
			End if 
		: (<>aTndClass{<>aPayTypes}=<>ciTCCrdtCrd)  //credit card tendered
			//TRACE
			vsAuthDate:=pCCDateStr
			viCardType:=<>ciACTCredit
	End case 
	C_LONGINT:C283($TransType)
	If (vrAuthAmt<0)  //Negitive so its a void or credit
		C_TEXT:C284($encodeCreditCard)
		$encodeCreditCard:=CC_EncodeDecode(1; pCreditCard; ->[Payment:28]creditCardBlob:53)
		//huntThis
		C_LONGINT:C283($ris)
		//testThis
		Case of 
			: ((ptCurTable=(->[Payment:28])) & (vHere>1))
				//have the record in hand
			: (Record number:C243([Payment:28])>-1)
				//
			Else 
				SET QUERY DESTINATION:C396(Into variable:K19:4; $ris)
				QUERY:C277([Payment:28]; [Payment:28]customerID:4=prntAcct; *)
				QUERY:C277([Payment:28];  & [Payment:28]typePayment:6=<>aPayTypes{<>aPayTypes}; *)
				QUERY:C277([Payment:28];  & [Payment:28]creditCardEncode:50=$encodeCreditCard; *)
				QUERY:C277([Payment:28];  & [Payment:28]dateDocument:10=Current date:C33(*); *)
				QUERY:C277([Payment:28];  & [Payment:28]amount:1=-vrAuthAmt)
				If ($ris=1)
					$TransType:=<>ciATVoid
				Else 
					$TransType:=<>ciATCredit
				End if 
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
		End case 
		
	Else 
		$TransType:=<>ciATAuthCap
	End if 
	C_LONGINT:C283(<>ciCCDevSyncRelations; authorizePayMode)
	$authMode:=<>tcCcDevice  // set in the Defaults record page needs to change based on web selection
	// 
	// testing
	// authorizePayMode:=9
	
	C_TEXT:C284($beforeScript; $eachScript; $afterScript)
	
	
	Case of 
		: ($authMode=<>ciCCDevSyncRelations)  //  = 9 
			READ ONLY:C145([SyncRelation:103])
			QUERY:C277([SyncRelation:103]; [SyncRelation:103]partner1Accountid:36=<>tcCCPartner)  //  <>tcCCPartner is set in Storage_Defaults Line 419
			HTTPClient_URL:=[SyncRelation:103]partner2URL:33
			$beforeScript:=[SyncRelation:103]scriptBefore:7
			$eachScript:=[SyncRelation:103]scriptData:28
			$afterScript:=[SyncRelation:103]scriptAfter:11
			HTTPSendText:=[SyncRelation:103]template:39
			HTTP_ContentType:=[SyncRelation:103]contentType:44
			
			//  pPayAction
			//  pPayType
			//  pCardApprv:=
			//  pvProcessorTransID
			//  pPayTendered:=Num($strAmount)
			//  pCreditCard
			//  pCCDateStr
			//  pCVV
			//  prntAttn
			//  pvAddress1
			//  pvZip
			//  pvCountry
			//  
			//  pvCountry
			
			
			
			If ($eachScript#"")
				ExecuteText(0; $eachScript)
			End if 
			
			// Modified by: Bill James (2016-12-06T00:00:00) Cludge for Converge max length of 15 characters
			C_LONGINT:C283($foundSpace)
			If (False:C215)  //Record number([Payment])=No current record)
				$payAmount3:=Num:C11(WCapi_GetParameter("PayAmount3"; ""))
				$cardType3:=WCapi_GetParameter("PayType3"; "")
				$payTendered3:=Num:C11(WCapi_GetParameter("PayTendered3"; ""))
				$payChange3:=Num:C11(WCapi_GetParameter("PayChange3"; ""))
				//
				$payCC:=WCapi_GetParameter("PayCCNumber3"; "")
				$cardName:=WCapi_GetParameter("PayccName3"; "")
				$cardZip:=WCapi_GetParameter("PayccZip3"; "")
				$cardType:=WCapi_GetParameter("PayType3"; "")
				$cardExpire:=WCapi_GetParameter("PayCCExpire3"; "")
				$cardCVV:=WCapi_GetParameter("PayCCCVV3"; "")
			End if 
			
			If (Records in selection:C76([Payment:28])=0)  // 170101: card is rejected if more than 15 characters
				If (Length:C16(prntAttn)>15)
					$foundSpace:=Position:C15(prntAttn; " ")
					If (($foundSpace>3) & ($foundSpace<16))
						prntAttn:=Substring:C12(prntAttn; 1; $foundSpace-1)
					Else 
						prntAttn:=Substring:C12(prntAttn; 1; 15)
					End if 
				End if 
			Else 
				$foundSpace:=Position:C15([Payment:28]nameOnAcct:11; " ")
				If ($foundSpace>0)
					[Payment:28]nameOnAcct:11:=Substring:C12([Payment:28]nameOnAcct:11; 1; $foundSpace-1)
					[Payment:28]nameLast:60:=Substring:C12([Payment:28]nameOnAcct:11; $foundSpace+1)
				End if 
				If (Length:C16([Payment:28]nameOnAcct:11)>15)
					[Payment:28]nameOnAcct:11:=Substring:C12([Payment:28]nameOnAcct:11; 1; 15)
				End if 
				prntAttn:=[Payment:28]nameOnAcct:11
			End if 
			
			pvZip:=Substring:C12(pvZip; 1; 5)
			
			//
			HTTPSendText:=TagsToText(HTTPSendText)
			REDUCE SELECTION:C351([SyncRelation:103]; 0)
			READ WRITE:C146([SyncRelation:103])
			
			NTK_SetURL(HTTPClient_URL)
			SET BLOB SIZE:C606(HTTP_Data; 0)
			HTTP_TimeOut:=10  //seconds
			SET BLOB SIZE:C606(HTTP_Data; 0)
			TEXT TO BLOB:C554(HTTPSendText; HTTP_Data; UTF8 text without length:K22:17; *)
			$error:=WC_Request("POST")
			HTTPClient_Response:=BLOB to text:C555(HTTP_IncomingBlob; UTF8 text without length:K22:17)
			
			If (Length:C16(HTTPClient_Response)>0)
				XMLParseTags(HTTPClient_Response)
				// execute text $afterScript
				// CREATE RECORD([GenericChild1])
				//  [GenericChild1]TableNum:=Table(->[Payment])
				//  [GenericChild1]LI01:=[WebTempRec]
				If (Record number:C243([Payment:28])>-1)
					[Payment:28]history:23:=HTTPClient_Response+"\r"+"\r"+[Payment:28]history:23
				Else 
					CREATE RECORD:C68([GenericChild1:90])
					[GenericChild1:90]tableNum:55:=Table:C252(->[Payment:28])
					[GenericChild1:90]lI01:6:=-1
					[GenericChild1:90]t01:44:=HTTPClient_Response
					SAVE RECORD:C53([GenericChild1:90])
					REDUCE SELECTION:C351([GenericChild1:90]; 0)
				End if 
				vsRspnText:=XMLReturnTagValue("ssl_result_message")
				pvProcessorTransID:=XMLReturnTagValue("ssl_txn_id")
				pvStatus:=XMLReturnTagValue("ssl_transaction_type")
				pvError:=XMLReturnTagValue("ssl_avs_response")
				pCardApprv:=XMLReturnTagValue("ssl_approval_code")
				vrAuthAmt:=Num:C11(XMLReturnTagValue("ssl_amount"))
				// pCardApprv:=XMLReturnTagValue ("ssl_issue_points")
				$DateString:=XMLReturnTagValue("ssl_txn_time")
				$pvCardType:=XMLReturnTagValue("ssl_card_type")
				$loyaltyBalance:=XMLReturnTagValue("ssl_loyalty_account_balance")
				$strAmount:=XMLReturnTagValue("ssl_amount")
				$cardString:=XMLReturnTagValue("ssl_card_number")
				
				
				
				
				If ((pvStatus="sale@") | (vsRspnText="appro@"))
					myOK:=1
					viPayAddWin:=0
					<>aPayTypes:=Find in array:C230(<>aPayTypes; "Credit Card")
					//  Used in PayMain to set [Payment]TypePayment line 37
					viAuthStat:=1  // must be set to one to update a record
					pvPayResponseCode:=1  // set at -1 before the dialog window to cancel all transactions
				Else 
					
				End if 
				
			End if 
			
			// execute text $afterScript
			
			SET BLOB SIZE:C606(HTTP_Data; 0)
			SET BLOB SIZE:C606(HTTP_IncomingBlob; 0)
		: ($authMode=<>ciCCDevSOAP)  //CHASE merchant services      
			TRACE:C157
			If (<>vSoapTrack=3)
				CREATE RECORD:C68([EventLog:75])
				
				[EventLog:75]dtEvent:1:=DateTime_Enter
				[EventLog:75]groupid:3:="WebCreditCard"
			End if 
			QUERY:C277([TallyMaster:60]; [TallyMaster:60]purpose:3="SOAP@"; *)
			QUERY:C277([TallyMaster:60];  & [TallyMaster:60]name:8="SOAP_Credit")
			Case of 
				: (Records in selection:C76([TallyMaster:60])=0)
					pvError:="no TallyMaster SOAP_Credit Record"
				: (Records in selection:C76([TallyMaster:60])>1)
					pvError:="multiple TallyMaster SOAP_Credit Record"
				Else   //        (Records in selection([TallyMaster])=1)
					If (<>vSoapTrack=3)
						EventLogsMessage([TallyMaster:60]script:9)
					End if 
					C_TEXT:C284($beforeScript; $afterScript)
					$beforeScript:=[TallyMaster:60]build:6
					$afterScript:=[TallyMaster:60]after:7
					vText4:=[TallyMaster:60]script:9
					$thePath:=[TallyMaster:60]path:28
					If ($beforeScript#"")
						ExecuteText(1; $beforeScript)
					End if 
					UNLOAD RECORD:C212([TallyMaster:60])
					C_LONGINT:C283($err)
					Case of 
						: (pvCountry="")
							pvCountry:="US"
						: (pvCountry="USA")
							pvCountry:="US"
					End case 
					
					pvCardExpire:=Substring:C12(pCCDateStr; 1; 2)+"/"+String:C10(2000+Num:C11(Substring:C12(pCCDateStr; 3; 2)))
					pvTransDate:=String:C10(Month of:C24(Current date:C33); "00")+"/"+String:C10(Year of:C25(Current date:C33); "0000")
					pvTransDateTime:=String:C10(Year of:C25(Current date:C33); "0000")+"-"+String:C10(Month of:C24(Current date:C33); "00")+"-"+String:C10(Day of:C23(Current date:C33); "00")+"T"+String:C10(Current time:C178; 1)+".981Z"
					
					TRACE:C157
					
					// ////////////////
					//If (False)//for testing only, see below
					// //////////////// 
					
					If (<>aPayAction{<>aPayAction}="Credit")  //switch payment value to positive
						pPayment:=-pPayment
					End if 
					
					vText4:=TagsToText(vText4)
					
					If (<>aPayAction{<>aPayAction}="Credit")  //switch back to negative payment
						pPayment:=-pPayment
					End if 
					
					If (<>vSoapTrack=3)
						EventLogsMessage(UtilFillMarkerLine("Converted Input")+vText4)
						iLoText2:=vText4
					End if 
					SoapProcess($thePath; vText4)
					If (<>vSoapTrack=3)
						EventLogsMessage(UtilFillMarkerLine("Service Return")+vText4)
						iLoText3:=vText4
					End if 
					
					
					// ////////////////
					//Else //for testing only
					//TRACE
					//TRACE
					//sumDoc:=Open document(pvZip0)
					//If (OK=1)
					//pvZip0:=document
					//RECEIVE PACKET(sumDoc;$theText;32000)
					//CLOSE DOCUMENT(sumDoc)
					//End if 
					////pvCardAction:="Auth"          
					//XMLParseTags ($theText)          
					//End if 
					// ////////////////
					
					If ($afterScript#"")
						If (Position:C15("_jit_Hard codedjj"; $afterScript)>0)
							// this was an empty procedure to be used for testing
							// it may be useful but this whole section needs to be rewritten
							// my guess is 
							// ### bj ### 20181205_0141
							// myTest5 
						Else 
							ExecuteText(1; $afterScript)
						End if 
					Else 
						C_TEXT:C284(pvExpiration)
						vsRspnText:=XMLReturnTagValue("info")
						pvProcessorTransID:=XMLReturnTagValue("reference")
						pvStatus:=XMLReturnTagValue("status")
						pvError:=XMLReturnTagValue("code")
						pCardApprv:=XMLReturnTagValue("controlNumber")
						
						
						//for testing:  //pvStatus:="success"
						
						
						If (((pvError="") | (pvError="0")) & (pvStatus="success"))  // (pvCardAction="Auth@")  //for tests
							myOK:=1
							viPayAddWin:=0
							Case of 
								: (pvCardAction="Auth@")
									pvExpiration:=XMLReturnTagValue("expiration")
									pDescript:="Authorized: "+String:C10(pPayment; "###,###,##0.00")+"\r"+pvExpiration
									pPayment:=0
									pPayRecordAuth:=1  //override the no payment record with pPayment=0
								: ((pvCardAction="Sale@") | (pvCardAction="Credit@"))
									// close window and save payment                
									
							End case 
						Else 
							pCardApprv:="PendErr "+pvError
							pDescript:=vsRspnText+", Err: "+pvError+("\r"*(Num:C11(pDescript#"")))+pDescript
						End if 
					End if 
			End case 
			If (<>vSoapTrack=3)
				SAVE RECORD:C53([EventLog:75])
				ProcessTableOpen(Table:C252(->[EventLog:75]))
			End if 
			
		: ($authMode=<>ciCCDevAuthNet)  //Authorize.net
			ARRAY TEXT:C222(aPayAuthFields; 0)
			$WarningMessage:=Auth_AuthorizeNet
			
			
		: ($authMode=<>ciCCDevVerisign)  //Authorize.net
			ARRAY TEXT:C222(aPayAuthFields; 0)
			$WarningMessage:=Auth_Verisign
			
			
		Else 
			CC_Authorize($TransType; ->vrAuthAmt; ->pCreditCard; ->vsAuthDate; ->viAuthStat; ->vsDLState; ->vsTrack1; ->vsTrack2; ->pCardApprv; ->pReferNum; ->vsRspnText; ->viCardType; ->viCardIssue; ->pvAddress1; ->pvZip; ->vlInvoiceNum; ->vscustomerID; ->pvProcessorTransID; ->vrSalesTax; ->vsCustPONum; ->prntAttn; ->pDescript)
			If (($TransType=<>ciATVoid) & (viAuthStat#<>ciTASAuthed))  //void not voided
				
				CC_Authorize(<>ciATCredit; ->vrAuthAmt; ->pCreditCard; ->vsAuthDate; ->viAuthStat; ->vsDLState; ->vsTrack1; ->vsTrack2; ->pCardApprv; ->pReferNum; ->vsRspnText; ->viCardType; ->viCardIssue; ->pvAddress1; ->pvZip; ->vlInvoiceNum; ->vscustomerID; ->pvProcessorTransID; ->vrSalesTax; ->vsCustPONum; ->prntAttn; ->pDescript)
			End if 
	End case 
	
	
	
	If ((Not:C34($1)) & (allowAlerts_boo))
		Case of 
			: (viAuthStat=<>ciTASAuthed)
			: (viAuthStat=<>ciTASDeclin)
				BEEP:C151
				BEEP:C151
				ALERT:C41("Transaction Declined!!!")
			: (viAuthStat=<>ciTASPhone)
				ALERT:C41("Call in to bank.")
			: (viAuthStat=<>ciTASError)
				ALERT:C41("Error in transaction.")
			: (viAuthStat=<>ciTASVoided)
				ALERT:C41("Transaction Voided.")
			: (viAuthStat=<>ciTASOther)
				ALERT:C41("Error Type: Other.")
			: (viAuthStat=<>ciTASPickUp)
				BEEP:C151
				BEEP:C151
				ALERT:C41("Pick-Up Card!!!")
			: (viAuthStat=<>ciTASHideError)
				//do nothing error reported elsewhere        
		End case 
	End if 
Else 
	If ((Not:C34($1)) & (allowAlerts_boo))
		ALERT:C41("This pay type can not be authorized.")
	End if 
End if 