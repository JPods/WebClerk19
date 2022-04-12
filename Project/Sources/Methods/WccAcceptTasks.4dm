//%attributes = {"publishedWeb":true}
If (False:C215)
	
	//Method: WccAcceptTasks 
	//Date: 07/01/02
	//Who: Bill
	//Description: manage record saving from the web
End if 
// ### jwm ### 20160406_1121 modified RemoteUser_Create and WCCSetEventLog2Cust for only special conditions

C_POINTER:C301($1; ptCurTable; $4)
C_BOOLEAN:C305($2; $newRecord)
C_BOOLEAN:C305($3; $doSave)
C_LONGINT:C283($i; $w)
$newRecord:=$2
ptCurTable:=$1
$doSave:=$3
booAccept:=True:C214
TRACE:C157
// NEVER_FROM_CLASSIC Bill James (2022-01-28T06:00:00Z)
If (False:C215)
	//TRACE
	If ($doSave)
		C_LONGINT:C283($viDocNum)
		Case of   //Must not reset to 0 is Accept button is selected.  6 allows the flow to continue
			: (ptCurTable=(->[OrderLine:49]))  //OrdLines
				$viDocNum:=ParseOrderLines
				// -11 if record was locked
				If ($viDocNum>0)
					ParseOrderRecord($viDocNum)
				End if 
				
			: (ptCurTable=(->[POLine:40]))  //must account for dInventory
				ParsePoLines
				
			: (ptCurTable=(->[InvoiceLine:54]))  //[InvoiceLine]
				$viDocNum:=ParseInvoiceLines
				// -11 if record was locked
				If ($viDocNum>0)
					ParseInvoiceRecord($viDocNum)
				End if 
			: (ptCurTable=(->[ProposalLine:43]))  //[InvoiceLine]
				$viDocNum:=ParseProposalLines
				// -11 if record was locked
				If ($viDocNum>0)
					ParseProposalRecord($viDocNum)
				End if 
				
			: (ptCurTable=(->[Order:3]))  //Orders
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerID:1)
				QUERY:C277([LoadTag:88]; [LoadTag:88]idNumOrder:29=[Order:3]idNum:2)
				OrderCalcArrays(-3000)
				
				
			: (ptCurTable=(->[Invoice:26]))  //Invoices
				READ WRITE:C146([Customer:2])
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerID:3)
				If ([Invoice:26]idNumOrder:1>1)
					QUERY:C277([Order:3]; [Order:3]idNum:2=[Invoice:26]idNumOrder:1)
				End if 
				If ([Invoice:26]idNumOrder:1>1)
					QUERY:C277([Order:3]; [Order:3]idNum:2=[Invoice:26]idNumOrder:1)
					QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
					FIRST RECORD:C50([Order:3])
					$k:=Records in selection:C76([OrderLine:49])
					C_LONGINT:C283($lnTest)
					$lnTest:=0
					For ($i; 1; $k)
						$lnTest:=MaxValueReturn($lnTest; [OrderLine:49]lineNum:3)
						NEXT RECORD:C51([OrderLine:49])
					End for 
					OrdLnFillRays
				End if 
				//
				
				IvcLnFillRays  //vLineCnt set if no order
				//
				acceptInvoice
				SAVE RECORD:C53([Invoice:26])
				Ledger_InvSave
				If ([Customer:2]customerID:1#[Payment:28]customerID:4)
					READ WRITE:C146([Customer:2])
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Payment:28]customerID:4)
				End if 
				LOAD RECORD:C52([Customer:2])
				C_LONGINT:C283($curRecord)
				$curRecord:=Record number:C243([Invoice:26])
				//Ledger_TallyBal(False; False)
				SAVE RECORD:C53([Customer:2])
				
				GOTO RECORD:C242([Invoice:26]; $curRecord)
				//qqq
			: (ptCurTable=(->[Payment:28]))  //Invoices
				If ([Customer:2]customerID:1#[Payment:28]customerID:4)
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Payment:28]customerID:4)
				End if 
				If (Not:C34(Is new record:C668([Payment:28])))
					If (Old:C35([Payment:28]amount:1)#[Payment:28]amount:1)
						C_REAL:C285($paymentChange)
						$paymentChange:=Old:C35([Payment:28]amount:1)-[Payment:28]amount:1
						[Payment:28]amountAvailable:19:=[Payment:28]amountAvailable:19+[Payment:28]amount:1-Old:C35([Payment:28]amount:1)
						[Payment:28]tendered:44:=[Payment:28]amount:1
						[Payment:28]change:45:=0
						[Payment:28]comment:5:=[Payment:28]comment:5+"\r"+String:C10(Current date:C33)+"; "+String:C10(Current time:C178)+"; Payment Changed by "+String:C10($paymentChange)+", "+[EventLog:75]idPrimary:30
					End if 
				End if 
				SAVE RECORD:C53([Payment:28])
				READ WRITE:C146([Customer:2])
				If ([Payment:28]creditCardNum:13#"")
					
					//[Payment]CCAction:="AUTH_CAPTURE"  must have a valid value
					
					If (([Payment:28]amount:1#0) & ([Payment:28]ccAction:54#"") & (([Payment:28]cardApproval:15="") | ([Payment:28]cardApproval:15="Pend@") | ([Payment:28]cardApproval:15="Fail@")))
						C_LONGINT:C283($foundRay)
						If (Find in array:C230(<>aPayAction; [Payment:28]ccAction:54)>1)
							pvCardAction:=[Payment:28]ccAction:54
							[Payment:28]status:46:="CCWebPaid"
							If (Length:C16([Payment:28]creditCardNum:13)>0)
								[Payment:28]typePayment:6:=("Visa"*Num:C11([Payment:28]creditCardNum:13[[1]]="4"))+("MC"*Num:C11([Payment:28]creditCardNum:13[[1]]="5"))+("AmEx"*Num:C11([Payment:28]creditCardNum:13[[1]]="3"))+("Disc"*Num:C11([Payment:28]creditCardNum:13[[1]]="6"))
								<>aPayTypes:=Find in array:C230(<>aPayTypes; [Payment:28]typePayment:6)
							Else 
								<>aPayTypes:=0
							End if 
							// Modified by: williamjames (130406)  error is possible if data is not set up correctly
							
							If (<>aPayTypes>0)
								[Payment:28]tenderClass:34:=<>aTndClass{<>aPayTypes}
							Else 
								[Payment:28]tenderClass:34:=-1
							End if 
							If (([Payment:28]ccAction:54="CAPTURE_ONLY") | ([Payment:28]ccAction:54="AUTH_CAPTURE") | ([Payment:28]ccAction:54="AUTH_ONLY") | ([Payment:28]ccAction:54="PRIOR_AUTH_CAPTURE") | ([Payment:28]ccAction:54="CREDIT") | ([Payment:28]status:46="VOID"))
								PayProcessCreditCard
							Else 
								pCreditCard:=CC_EncodeDecode(1; [Payment:28]creditCardNum:13; ->[Payment:28]creditCardBlob:53)
							End if 
						End if 
					End if 
					//pCreditCard:=CC_SaveData ([Payment]CreditCardNum)//set fields in customer record
				End if 
				SAVE RECORD:C53([Payment:28])
				If (([Payment:28]idNumOrder:2<9) & ([Payment:28]idNumInvoice:3>9))
					QUERY:C277([Invoice:26]; [Invoice:26]idNum:2=[Payment:28]idNumInvoice:3)
					If (Not:C34(Locked:C147([Invoice:26])))
						PayApplyOneInvoice
					End if 
				Else 
					Ledger_PaySave
				End if 
				
				
				If ([Customer:2]customerID:1#[Payment:28]customerID:4)
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Payment:28]customerID:4)
				End if 
				LOAD RECORD:C52([Customer:2])
				C_LONGINT:C283($curRecord; $ordNum)
				$ordNum:=[Payment:28]idNumOrder:2
				$curRecord:=Record number:C243([Payment:28])
				Ledger_TallyBal(process_o.cur)
				SAVE RECORD:C53([Customer:2])
				pPayAmount:=0
				pBalance:=0
				If ($ordNum>0)
					QUERY:C277([Order:3]; [Order:3]idNum:2=$ordNum)
					QUERY:C277([Payment:28]; [Payment:28]idNumOrder:2=$ordNum)
					PaymentFillVariables
					[Order:3]balanceDueEstimated:107:=[Order:3]total:27-pPayAmount
					SAVE RECORD:C53([Order:3])
					pBalance:=[Order:3]balanceDueEstimated:107
				End if 
				
				GOTO RECORD:C242([Payment:28]; $curRecord)
				
			: (ptCurTable=(->[Item:4]))  //Items
				Item_GetSpec(0)  //###wdj### 070707
				If (Record number:C243([ItemSpec:31])>-1)
					WC_Parse(Table:C252(->[ItemSpec:31]); ->vText11)
					SAVE RECORD:C53([ItemSpec:31])
				End if 
				$actionKeyword:=WCapi_GetParameter("ActionKeywords"; "")
				If ($actionKeyword="MakeKeyWords")
					
					SAVE RECORD:C53([Item:4])
					
				End if 
			: (ptCurTable=(->[Service:6]))
				
				acceptFilePt($unLoad; ->[Service:6]; ->[Customer:2]; ->[OrderLine:49]; ->[Order:3]; ->[Invoice:26]; ->[Proposal:42]; ->[InvoiceLine:54])
				newService:=False:C215
			: (ptCurTable=(->[Customer:2]))
				If ($newRecord)
					TallyCreate(Table:C252(->[AdSource:35]); Field:C253(->[AdSource:35]newResponces:28); [Customer:2]adSource:62; 0; 1)
				End if 
				
				
				Data_ArchiveOld
				
				If ([Customer:2]dateRetired:111#Old:C35([Customer:2]dateRetired:111))
					AcceptContactsRetired
				End if 
				
				acceptFilePt($unLoad; ->[Customer:2]; ->[Contact:13]; ->[Service:6]; ->[Reference:7]; ->[CallReport:34])  // ### jwm ### 20171207_1050 why is [Customer] saved here and below
				acceptFilePt($unLoad; ->[OrderLine:49]; ->[Order:3]; ->[Invoice:26]; ->[Proposal:42]; ->[InvoiceLine:54])
				If (([Customer:2]zip:8#"") & ($newRecord))
					Find Ship Zone(->[Customer:2]zip:8; ->[Customer:2]zone:57; ->[Customer:2]shipVia:12; ->[Customer:2]country:9; ->[Customer:2]siteID:106)
					Tt_FindByZip(->[Customer:2]zip:8; ->[Customer:2]salesNameID:59; ->[Customer:2]repID:58)
					Zip_LoadCitySt_New(->[Customer:2]zip:8; ->[Customer:2]city:6; ->[Customer:2]state:7; True:C214)
				End if 
				If (($newRecord) & (Records in selection:C76([RemoteUser:57])=0))
					RemoteUser_Create((->[Customer:2]); [Customer:2]customerID:1; [Customer:2]zip:8; 1)
					// ### jwm ### 20160406_1106 moved inside if statement from below
					WCCSetEventLog2Cust(Table:C252(->[Customer:2]); Record number:C243([Customer:2]))
				End if 
				If (Find in array:C230(<>aTerms; [Customer:2]terms:33)<1)
					[Customer:2]terms:33:=Storage:C1525.default.terms
					//DBCustomer_init 
				End if 
				<>aLastRecNum{2}:=Record number:C243([Customer:2])
				SAVE RECORD:C53(ptCurTable->)
			: (ptCurTable=(->[Proposal:42]))
				
				
				
			: (ptCurTable=(->[POLine:40]))
				SAVE RECORD:C53(ptCurTable->)  // Look at ParseOrderLines to double check requirements.
				vMod:=True:C214
				booAccept:=True:C214
				
				// fill POLine Array
				QUERY:C277([PO:39]; [PO:39]idNum:5=[POLine:40]idNumPO:1)
				QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[POLine:40]vendorID:24)
				QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
				PoLnFillRays(Records in selection:C76([POLine:40]))
				
				acceptPO  //transactions are in accept Procedure    
			: (ptCurTable=(->[PO:39]))
				vMod:=True:C214
				booAccept:=True:C214
				QUERY:C277([Vendor:38]; [Vendor:38]vendorID:1=[PO:39]vendorID:1)
				QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[PO:39]idNum:5)
				PoLnFillRays(Records in selection:C76([POLine:40]))
				
				acceptPO  //transactions are in accept Procedure    
				
			: (ptCurTable=(->[InventoryStack:29]))
				SAVE RECORD:C53([InventoryStack:29])
				READ ONLY:C145([InventoryStack:29])
			: (ptCurTable=(->[UserReport:46]))
				URpt_Accept
			: (ptCurTable=(->[Contact:13]))
				
				SAVE RECORD:C53(ptCurTable->)
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Contact:13]customerID:1)
				// ### jwm ### 20160406_1111 copied conditional statement from customers
				If (($newRecord) & (Records in selection:C76([RemoteUser:57])=0))
					RemoteUser_Create((->[Contact:13]); String:C10([Contact:13]idNum:28); [Contact:13]zip:11; 1)
					WCCSetEventLog2Cust(Table:C252(->[Customer:2]); Record number:C243([Customer:2]))
				End if 
				
			: (ptCurTable=(->[Default:15]))
				SAVE RECORD:C53(ptCurTable->)
				Storage_Default
			: (ptCurTable=(->[PopUp:23]))
				QUERY:C277([PopupChoice:134]; [PopupChoice:134]arrayName:1=[PopUp:23]arrayName:3)
				DELETE SELECTION:C66([PopupChoice:134])
				For ($i; 1; Size of array:C274(a1Text))
					CREATE RECORD:C68([PopupChoice:134])
					//notation for a passed parameter, refered by number
					[PopupChoice:134]arrayName:1:=[PopUp:23]arrayName:3
					[PopupChoice:134]choice:3:=a1Text{$i}
					[PopupChoice:134]alternate:4:=aText2{$i}
					SAVE RECORD:C53([PopupChoice:134])
				End for 
				SAVE RECORD:C53([PopUp:23])
				// jsetChPopups 
			: (ptCurTable=(->[SpecialDiscount:44]))
				
				SAVE RECORD:C53([SpecialDiscount:44])
				Disc_ArraysDo(-5)
				// setTypeSalePopu 
			: (ptCurTable=(->[OrderComment:27]))
				SAVE RECORD:C53(ptCurTable->)
				//setChOrdCom 
			: (ptCurTable=(->[Process:16]))
				SAVE RECORD:C53(ptCurTable->)
				//  jsetChProcesses 
			: (ptCurTable=(->[Employee:19]))
				SAVE RECORD:C53(ptCurTable->)
				Default_Employee
			: (ptCurTable=(->[Script:12]))
				SAVE RECORD:C53(ptCurTable->)
				// jsetChScript 
			: (ptCurTable=(->[Carrier:11]))
				SAVE RECORD:C53([Carrier:11])
				//  setChShip 
			: (ptCurTable=(->[AdSource:35]))
				SAVE RECORD:C53(ptCurTable->)
				// setChAds 
			: (ptCurTable=(->[TaxJurisdiction:14]))
				[TaxJurisdiction:14]dateTimeSync:6:=DateTime_Enter
				SAVE RECORD:C53([TaxJurisdiction:14])
				//  setChTax 
			: (ptCurTable=(->[Letter:20]))
				//[Letter]LetterPict:=  //**WR O Save to picture (eLetterArea)
				SAVE RECORD:C53(ptCurTable->)
			: (ptCurTable=(->[Rep:8]))
				[Rep:8]dateTimeSync:16:=DateTime_Enter
				SAVE RECORD:C53([Rep:8])
				//   setChReps 
			: (ptCurTable=(->[ItemSpec:31]))
				
				SAVE RECORD:C53([ItemSpec:31])
			: (ptCurTable=(->[ItemSerial:47]))
				If ((vMod) | (Modified record:C314([ItemSerial:47])))
					vMod:=False:C215
					If (Not:C34(Modified record:C314([ItemSerial:47])))
						READ WRITE:C146([ItemSerial:47])
						LOAD RECORD:C52([ItemSerial:47])
						[ItemSerial:47]comments:23:=vText1
						$doLock:=True:C214
					End if 
					SAVE RECORD:C53([ItemSerial:47])
					If ($doLock)
						READ ONLY:C145([ItemSerial:47])
					End if 
				End if 
			: (ptCurTable=(->[Term:37]))
				SAVE RECORD:C53(ptCurTable->)
				//   setChTerms 
			: (ptCurTable=(->[DefaultAccount:32]))
				SAVE RECORD:C53([DefaultAccount:32])
				jSetPayTypes
			: (ptCurTable=(->[Currency:61]))
				SAVE RECORD:C53([Currency:61])
				//  setCurrencyRay 
			: (ptCurTable=(->[RemoteUser:57]))
				SAVE RECORD:C53([RemoteUser:57])
				
			: (ptCurTable=(->[DialingInfo:81]))
				Dial_AcceptDI
			: (ptCurTable=(->[CronJob:82]))
				SAVE RECORD:C53([CronJob:82])
			: (ptCurTable=(->[WebTempRec:101]))
				If ([WebTempRec:101]idEventLog:1="")  //"")
					[WebTempRec:101]idEventLog:1:=[EventLog:75]id:54
				End if 
				//
				[WebTempRec:101]extendedPrice:12:=Round:C94([WebTempRec:101]discountedPrice:10*[WebTempRec:101]qtyOrdered:4; 2)
				SAVE RECORD:C53(ptCurTable->)
			: (Records in selection:C76(ptCurTable->)=1)
				SAVE RECORD:C53(ptCurTable->)
		End case 
		If (Modified record:C314(ptCurTable->))
			SAVE RECORD:C53(ptCurTable->)
		End if 
		
		RP_SaveRecordtoSyncRecord(ptCurTable)
		
		//TRACE for debug of a specific case
		//[Payment]AmountAvailable:=[Payment]Amount
		//[Payment]DateReceived:=Current date
		//[Payment]NameOnAcct:=[Payment]Comment
		//SAVE RECORD([Payment])
		//CREATE RECORD([SalesIDTrack])
		//
		//[SalesIDTrack]TableNum:=2
		//[SalesIDTrack]FieldChanged:=42
		//[SalesIDTrack]ValueWas:=String(Old([Payment]Amount))
		//[SalesIDTrack]ValueChanged:=String([Payment]Amount)
		//[SalesIDTrack]ChangedBy:=[Payment]Comment
		//[SalesIDTrack]DocID:=[Payment]customerID
		//[SalesIDTrack]DTCreated:=DateTime_Enter 
		//SAVE RECORD([SalesIDTrack])
		//QUERY([Customer];[Customer]customerID=[Payment]customerID)
		//LOAD RECORD([Customer])
		//If ((Records in selection([Customer])=1)&(Not(Locked([Customer]))))
		//[Customer]BalanceDue:=[Customer]BalanceCurrent+[Payments
		//]AmountAvailable
		//[Payment]AmountAvailable:=0
		//SAVE RECORD([Payment])
		//SAVE RECORD([Customer])
		//End if 
		
		QUERY:C277([TallyMaster:60]; [TallyMaster:60]tableNum:1=Table:C252(ptCurTable); *)
		//QUERY([TallyMaster]; & [TallyMaster]FieldNum=vWccSecurity;*) // ### AZM ### 2019-02-18 FIELDNUM IS NOT USED TO STORE SECURITY LEVEL
		//fix this.  Should this work if vWccSecurity level is equal to zero?
		QUERY:C277([TallyMaster:60];  & [TallyMaster:60]purpose:3="WccSave")
		If ((Records in selection:C76([TallyMaster:60])=1) & ([TallyMaster:60]script:9#""))
			ExecuteText(0; [TallyMaster:60]script:9)
		End if 
		UNLOAD RECORD:C212([TallyMaster:60])
		If (<>doFlushBuffers)
			FLUSH CACHE:C297
		End if 
	End if 
	
	//ConsoleMessage ("TEST: End if")
	
	//[Payment]AmountAvailable:=[Payment]Amount
	//[Payment]DateReceived:=Current date
	//[Payment]NameOnAcct:=[Payment]Comment
	//SAVE RECORD([Payment])
	//CREATE RECORD([SalesIDTrack])
	//
	//[SalesIDTrack]TableNum:=2
	//[SalesIDTrack]FieldChanged:=42
	//[SalesIDTrack]ValueWas:=0
	//[SalesIDTrack]ValueChanged:=String([Payment]Amount)
	//[SalesIDTrack]ChangedBy:=[Payment]Comment
	//[SalesIDTrack]DocID:=[Payment]customerID
	//[SalesIDTrack]DTCreated:=DateTime_Enter 
	//SAVE RECORD([SalesIDTrack])
	//QUERY([Customer];[Customer]customerID=[Payment]customerID)
	//LOAD RECORD([Customer])
	//If ((Records in selection([Customer])=1)&(Not(Locked([Customer]))))
	//[Customer]BalanceDue:=[Customer]BalanceCurrent+[Payments
	//]AmountAvailable
	//[Payment]AmountAvailable:=0
	//SAVE RECORD([Payment])
	//SAVE RECORD([Customer])
	//End if 
	//
	//
	//QUERY([Payment];[Payment]AmountAvailable#0)
	//vi2:=Records in selection([Payment])
	//FIRST RECORD([Payment])
	//For (vi1;1;vi2)
	//LOAD RECORD([Payment])
	//If (Not(Locked([Payment])))
	//QUERY([Customer];[Customer]customerID=[Payment]customerID)
	//LOAD RECORD([Customer])
	//If ((Records in selection([Customer])=1)&(Not(Locked([Customer])
	//)))
	//[Customer]BalanceDue:=[Customer]BalanceCurrent+[Payments
	//]AmountAvailable
	//[Payment]AmountAvailable:=0
	//SAVE RECORD([Payment])
	//SAVE RECORD([Customer])
	//End if 
	//UNLOAD RECORD([Payment])
	//UNLOAD RECORD([Customer])
	//End if 
	//End for 
	
End if 

