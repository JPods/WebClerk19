//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i; $k; $itemRec)
C_REAL:C285($curtTime; $billTime; $maintTime)
CONFIRM:C162("Process tech support service records into invoices?")
TRACE:C157
If (OK=1)
	C_BOOLEAN:C305($blockEDI)
	$blockEDI:=allowAlerts_boo
	allowAlerts_boo:=False:C215
	MESSAGES OFF:C175
	READ WRITE:C146([TallyResult:73])
	QUERY:C277([Service:6]; [Service:6]complete:17=False:C215; *)
	QUERY:C277([Service:6];  & [Service:6]noteType:21="TS@")
	ORDER BY:C49([Service:6]; [Service:6]customerID:1; [Service:6]dtBegin:15; [Service:6]dtDocument:16)
	$i:=0
	C_TEXT:C284($thisAcct)
	$k:=Records in selection:C76([Service:6])
	FIRST RECORD:C50([Service:6])
	QUERY:C277([Item:4]; [Item:4]itemNum:1="TechSupport")
	Case of 
		: ($k=0)
			ALERT:C41("There are no applicable records.")
		: (Records in selection:C76([Item:4])#1)
			ALERT:C41("There is not an item number 'TechSupport'!")
		Else 
			CREATE EMPTY SET:C140([Invoice:26]; "Current")
			$itemRec:=Record number:C243([Item:4])
			
			//    ThermoInitExit ("Tally tech support to invoices";$k;True)
			$viProgressID:=Progress New
			
			While ($i<$k)
				$maintTime:=0
				$billTime:=0
				$curtTime:=0
				$thisAcct:=[Service:6]customerID:1
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Service:6]customerID:1)
				If (Records in selection:C76([Customer:2])=1)
					QUERY:C277([TallyResult:73]; [TallyResult:73]customerID:30=[Customer:2]customerID:1; *)
					QUERY:C277([TallyResult:73];  & [TallyResult:73]dtReport:12=DateTime_Enter([Customer:2]dateService:63; ?00:00:00?); *)
					QUERY:C277([TallyResult:73];  & [TallyResult:73]purpose:2="Service Contract")
					If (Records in selection:C76([TallyResult:73])=0)
						CREATE RECORD:C68([TallyResult:73])
						
						[TallyResult:73]customerID:30:=[Customer:2]customerID:1
						[TallyResult:73]dtReport:12:=DateTime_Enter([Customer:2]dateService:63; ?00:00:00?)
						[TallyResult:73]purpose:2:="Service Contract"
					End if 
					CREATE RECORD:C68([Invoice:26])
					[Invoice:26]idNum:2:=CounterNew(->[Invoice:26])
					[Invoice:26]idNumOrder:1:=1
					[Invoice:26]profile1:53:="Tech Support"
					[Invoice:26]dateShipped:4:=Current date:C33
					IvcLnFillRays(0)  //no lines at this time
					LoadCustomersInvoices
					[Invoice:26]shipVia:5:="Tech Support"
					KeyModifierCurrent
					If (CapKey=1)
						[Invoice:26]terms:24:="DOR"
					End if 
					viInvcLnCnt:=0
					$totTime:=0
					Repeat 
						$i:=$i+1
						//Thermo_Update ($i)
						ProgressUpdate($viProgressID; $i; $k; "Tally tech support to invoices")
						If (<>ThermoAbort)
							$i:=$k
						End if 
						QUERY:C277([Item:4]; [Item:4]itemNum:1="TS-"+[Service:6]actionBy:12)
						If (Records in selection:C76([Item:4])#1)
							GOTO RECORD:C242([Item:4]; $itemRec)
							pPartNum:="TechSupport"
						Else 
							pPartNum:="TS-"+[Service:6]actionBy:12
						End if 
						C_REAL:C285($roundTime)
						If (Num:C11([Item:4]unitOfMeasure:11)>0.1)
							$minInc:=Num:C11([Item:4]unitOfMeasure:11)
							$roundTime:=$minInc-0.1
						Else 
							C_LONGINT:C283($minInc)
							$minInc:=10
							$roundTime:=4.9
						End if 
						If ([Service:6]timer:34#0)
							aiLineAction:=Size of array:C274(aiLineAction)+1
							//viInvcLnCnt:=viInvcLnCnt+1
							IvcLnAdd(aiLineAction; 1; False:C215)
							$time:=Round:C94((([Service:6]timer:34+$minInc-0.1)\$minInc)*($minInc/60); 2)
							//
							If ([Service:6]pricePointService:46#"")
								pPricePt:=[Service:6]pricePointService:46
								vUseBase:=SetPricePoint(pPricePt)
								aiPricePt{aiLineAction}:=pPricePt
								OrdSetPrice(->pUnitPrice; ->pDiscnt; pQtyOrd; ->pComm)
								pUnitPrice:=Round:C94(pUnitPrice; 2)
								aiUnitPrice{aiLineAction}:=pUnitPrice
								aiDiscnt{aiLineAction}:=pDiscnt
							End if 
							aiQtyOrder{aiLineAction}:=$time
							aiQtyRemain{aiLineAction}:=$time  //maintain as original, zero for new
							aiQtyShip{aiLineAction}:=$time
							aiProdBy{aiLineAction}:=[Service:6]actionBy:12
							aiAltItem{aiLineAction}:=jDateTimeRBoth([Service:6]dtAction:35)
							aiDescpt{aiLineAction}:=[Service:6]action:20+"; "+Substring:C12([Service:6]process:4+"; "+[Service:6]attribute:5+"; "+[Service:6]cause:7; 1; 18-Length:C16([Service:6]action:20))
							aiProfile1{aiLineAction}:=[Service:6]reference:37
							aiProfile3{aiLineAction}:=String:C10([Service:6]idNum:26)
							aiSerialNm{aiLineAction}:=[Service:6]reference:37
							QUERY:C277([ItemSerial:47]; [ItemSerial:47]serialNum:4=[Service:6]reference:37)
							If (Records in selection:C76([ItemSerial:47])=1)
								aiSerialRc{aiLineAction}:=-[ItemSerial:47]idNum:18
								UNLOAD RECORD:C212([ItemSerial:47])
							End if 
							Case of 
								: ([Service:6]noteType:21#"TS-Bi@")
									aiDiscnt{aiLineAction}:=100
									If ([Service:6]noteType:21="TS-Ma@")
										$maintTime:=$maintTime+$time
									Else 
										$curtTime:=$curtTime+$time
									End if 
									[Invoice:26]profile2:66:=Substring:C12([Service:6]noteType:21; 1; 24)
								: (([Service:6]costToCustomer:8>0) & ([Service:6]costToCustomer:8<=100))
									aiDiscnt{aiLineAction}:=[Service:6]costToCustomer:8
									aiProfile2{aiLineAction}:="Discounted"
									$curtTime:=$curtTime+Round:C94($time*[Service:6]costToCustomer:8*0.01; 1)
									$billTime:=$billTime+Round:C94($time*(100-[Service:6]costToCustomer:8)*0.01; 1)
									//: (([Customer]DateService>!00/00/00!)&([Customers
									//]DateService>Current date))
									//aiDiscnt{aiLineAction}:=100
									//$maintTime:=$maintTime+$time
									//aiProfile2{aiLineAction}:="TS-Maint"
									//[Service]NoteType:="TS-Maint"
								Else 
									$billTime:=$billTime+$time
							End case 
							IvcLnExtend(aiLineAction)
						End if 
						//            
						If ([Service:6]travelTime:44#0)
							aiLineAction:=Size of array:C274(aiLineAction)+1
							viInvcLnCnt:=viInvcLnCnt+1
							IvcLnAdd(aiLineAction; 1; False:C215)
							$time:=Round:C94((([Service:6]travelTime:44+$minInc-0.1)\$minInc)*($minInc/60); 2)
							//
							If ([Service:6]pricePointTravel:45#"")
								pPricePt:=[Service:6]pricePointTravel:45
								vUseBase:=SetPricePoint(pPricePt)
								aiPricePt{aiLineAction}:=pPricePt
								OrdSetPrice(->pUnitPrice; ->pDiscnt; pQtyOrd; ->pComm)
								pUnitPrice:=Round:C94(pUnitPrice; 2)
								aiUnitPrice{aiLineAction}:=pUnitPrice
								aiDiscnt{aiLineAction}:=pDiscnt
							End if 
							aiQtyOrder{aiLineAction}:=$time
							aiQtyRemain{aiLineAction}:=$time  //maintain as original, zero for new
							aiQtyShip{aiLineAction}:=$time
							aiProdBy{aiLineAction}:=[Service:6]actionBy:12
							aiAltItem{aiLineAction}:=jDateTimeRBoth([Service:6]dtAction:35)
							aiDescpt{aiLineAction}:="Travel Time "+String:C10([Service:6]idNum:26; "0000-0000")
							aiProfile1{aiLineAction}:=[Service:6]reference:37
							aiProfile3{aiLineAction}:=String:C10([Service:6]idNum:26)
							aiSerialNm{aiLineAction}:=[Service:6]reference:37
							QUERY:C277([ItemSerial:47]; [ItemSerial:47]serialNum:4=[Service:6]reference:37)
							If (Records in selection:C76([ItemSerial:47])=1)
								aiSerialRc{aiLineAction}:=-[ItemSerial:47]idNum:18
								UNLOAD RECORD:C212([ItemSerial:47])
							End if 
							Case of 
								: ([Service:6]noteType:21#"TS-Bi@")
									aiDiscnt{aiLineAction}:=100
									If ([Service:6]noteType:21="TS-Ma@")
										$maintTime:=$maintTime+$time
									Else 
										$curtTime:=$curtTime+$time
									End if 
									[Invoice:26]profile2:66:=Substring:C12([Service:6]noteType:21; 1; 24)
								: (([Service:6]costToCustomer:8>0) & ([Service:6]costToCustomer:8<=100))
									aiDiscnt{aiLineAction}:=[Service:6]costToCustomer:8
									aiProfile2{aiLineAction}:="Discounted"
									$curtTime:=$curtTime+Round:C94($time*[Service:6]costToCustomer:8*0.01; 1)
									$billTime:=$billTime+Round:C94($time*(100-[Service:6]costToCustomer:8)*0.01; 1)
									//: (([Customer]DateService>!00/00/00!)&([Customers
									//]DateService>Current date))
									//aiDiscnt{aiLineAction}:=100
									//$maintTime:=$maintTime+$time
									//aiProfile2{aiLineAction}:="TS-Maint"
									//[Service]NoteType:="TS-Maint"
								Else 
									$billTime:=$billTime+$time
							End case 
							IvcLnExtend(aiLineAction)
						End if 
						//            
						If ([Service:6]miles:41#0)
							QUERY:C277([Item:4]; [Item:4]itemNum:1="TS-Milage")
							pPartNum:="TS-Milage"
							aiLineAction:=Size of array:C274(aiLineAction)+1
							viInvcLnCnt:=viInvcLnCnt+1
							IvcLnAdd(aiLineAction; 1; False:C215)
							If ([Service:6]pricePointTravel:45#"")  //automatically manged by InvLnAdd if empty
								pPricePt:=[Service:6]pricePointTravel:45
								vUseBase:=SetPricePoint(pPricePt)
								aiPricePt{aiLineAction}:=pPricePt
								OrdSetPrice(->pUnitPrice; ->pDiscnt; pQtyOrd; ->pComm)
								pUnitPrice:=Round:C94(pUnitPrice; 2)
								aiUnitPrice{aiLineAction}:=pUnitPrice
								aiDiscnt{aiLineAction}:=pDiscnt
							End if 
							aiQtyOrder{aiLineAction}:=[Service:6]miles:41
							aiQtyRemain{aiLineAction}:=0  //maintain as original, zero for new
							aiQtyShip{aiLineAction}:=[Service:6]miles:41
							aiProdBy{aiLineAction}:=[Service:6]actionBy:12
							aiAltItem{aiLineAction}:=jDateTimeRBoth([Service:6]dtAction:35)
							aiDescpt{aiLineAction}:="Milage for: "+String:C10([Service:6]idNum:26)
							aiProfile1{aiLineAction}:=[Service:6]reference:37
							aiProfile3{aiLineAction}:=String:C10([Service:6]idNum:26)
							aiSerialNm{aiLineAction}:=[Service:6]reference:37
							IvcLnExtend(aiLineAction)
						End if 
						If ([Service:6]expenses:42#0)
							QUERY:C277([Item:4]; [Item:4]itemNum:1="TS-Expense")
							pPartNum:="TS-Expense"
							aiLineAction:=Size of array:C274(aiLineAction)+1
							viInvcLnCnt:=viInvcLnCnt+1
							IvcLnAdd(aiLineAction; 1; False:C215)
							aiQtyOrder{aiLineAction}:=1
							aiQtyRemain{aiLineAction}:=0  //maintain as original, zero for new
							aiQtyShip{aiLineAction}:=1
							pUnitPrice:=[Service:6]expenses:42
							aiUnitPrice{aiLineAction}:=pUnitPrice
							aiProdBy{aiLineAction}:=[Service:6]actionBy:12
							aiAltItem{aiLineAction}:=jDateTimeRBoth([Service:6]dtAction:35)
							aiDescpt{aiLineAction}:=Substring:C12([Service:6]expenseDescription:43; 1; 80)
							aiProfile1{aiLineAction}:=[Service:6]reference:37
							aiProfile3{aiLineAction}:=String:C10([Service:6]idNum:26)
							aiSerialNm{aiLineAction}:=[Service:6]reference:37
							IvcLnExtend(aiLineAction)
						End if 
						[Service:6]complete:17:=True:C214
						[Service:6]idNumInvoice:23:=[Invoice:26]idNum:2
						SAVE RECORD:C53([Service:6])
						NEXT RECORD:C51([Service:6])
					Until (($i>=$k) | ($thisacct#[Service:6]customerID:1))
					
					If ($maintTime#0)
						[Customer:2]serviceHrAvail:82:=[Customer:2]serviceHrAvail:82-$maintTime
						SAVE RECORD:C53([Customer:2])
					End if 
					[TallyResult:73]real2:14:=[TallyResult:73]real2:14-$maintTime
					[TallyResult:73]real3:15:=[TallyResult:73]real3:15+$billTime
					[TallyResult:73]real4:16:=[TallyResult:73]real4:16+$curtTime
					SAVE RECORD:C53([TallyResult:73])
					vMod:=True:C214
					acceptInvoice(True:C214)
					ADD TO SET:C119([Invoice:26]; "Current")
				Else 
					BEEP:C151
					$i:=$i+1
					NEXT RECORD:C51([Service:6])
				End if 
			End while 
			//Thermo_Close 
			Progress QUIT($viProgressID)
			
			USE SET:C118("Current")
			CLEAR SET:C117("Current")
			ProcessTableOpen(->[Invoice:26])
	End case 
	UNLOAD RECORD:C212([Service:6])
	UNLOAD RECORD:C212([Customer:2])
	UNLOAD RECORD:C212([Invoice:26])
	UNLOAD RECORD:C212([TallyResult:73])
	MESSAGES ON:C181
	jCancelButton(False:C215)
	allowAlerts_boo:=True:C214
End if 
READ ONLY:C145([TallyResult:73])