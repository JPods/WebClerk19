//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 02/09/12, 22:22:47
// ----------------------------------------------------
// Method: CMAComplexProcess
// Description
// 
//
// Parameters
// ----------------------------------------------------
CREATE EMPTY SET:C140([Order:3]; "CurrentOrders")
//QUERY([Order];[Order]OrderNum=549225)
CREATE EMPTY SET:C140([Invoice:26]; "CurrentInvoices")
READ WRITE:C146([OrderLine:49])
vText5:=""  //clear the orderNum
$lastInvoice:=""  //first invoice number is empty

//read in a line. 
//If it is not the first line then process the list of items into OrderLines. 
//If it is the first line of a new order, create the order and customer and add the line items to the array of line times to be processed.  aLsItemNum
$closeAll:=False:C215
$incImport:=0
Repeat 
	$runFinal:=False:C215
	$doAll:=False:C215
	RECEIVE PACKET:C104(myDoc; vText2; "\r")
	If ((OK=0) | (Length:C16(vText2)<100))
		OK:=0  //drop out
		$runFinal:=True:C214
	Else 
		$doAll:=True:C214
		$incImport:=$incImport+1
		jMessageWindow("Processing Line: "+String:C10($incImport); 0.2)
	End if 
	$thisInvoice:="l238ds(@#$^&*()"
	
	
	
	If (Length:C16(vText2)>100)
		ARRAY TEXT:C222(aText2; 0)
		TextToArray(vText2; ->aText2)
		If (Size of array:C274(aText2)>32)
			COPY ARRAY:C226(aText2; aText3)
			ARRAY TEXT:C222(aText3; 27)
			vText2:=""
			$cntNewRay:=Size of array:C274(aText3)-1
			C_LONGINT:C283($incNewRay; $cntNewRay)
			For ($incNewRay; 1; $cntNewRay)
				vText2:=vText2+aText3{$incNewRay}+"\t"
			End for 
			vText2:=vText2+aText3{$cntNewRay+1}
			aText2{7}:=Parse_UnWanted(aText2{7})
			vi8:=vi8+1
			If (Mod:C98(vi8; 50)=0)
				GOTO XY:C161(200; 200)
				MESSAGE:C88("Processing record #"+String:C10(vi8))
				KeyModifierCurrent
				If (CapKey=1)
					TRACE:C157
				End if 
			End if 
			If (aText2{3}#iLo35String3)
				iLo35String3:=aText2{3}
				Case of 
					: (aText2{3}="PCH@")
						vText3:="PineConeHi"
					: (aText2{3}="DA@")
						vText3:="DashandAl"
					Else 
				End case 
				If ([Customer:2]customerID:1#vText3)
					QUERY:C277([Customer:2]; [Customer:2]customerID:1=vText3)
				End if 
				iLoText5:=[Customer:2]company:2
				iLoLongInt1:=Record number:C243([Customer:2])
				iLoLongInt2:=[Customer:2]mfrLocationid:67
				QUERY:C277([ManufacturerTerm:111]; [ManufacturerTerm:111]customerID:1=vText3)
			End if 
			$thisInvoice:=aText2{1}
		End if 
	End if 
	If (($lastInvoice#$thisInvoice) & (vi8>1))  // new MFR Invoice line but  not first line
		//aText2{1}  goes into [Order]Profile2   faulting on existing order
		//aText2{5}  goes into [Order]Profile1   faulting on existing order
		//aText2{5}  goes into [Order]MfgOrderNum   faulting on existing order
		//process the order lines, save the Order and Invoice, then process the current array element
		//$lastInvoice:=aText2{1}//happens at end of all action
		QUERY:C277([Item:4]; [Item:4]itemNum:1="Com"+vText3+"@")
		FIRST RECORD:C50([Item:4])
		//OrdLnFillRays //get existing line arrays
		$createLine:=False:C215
		$createOrder:=False:C215
		C_LONGINT:C283($lineNum)
		If (Locked:C147([Order:3]))
			SEND PACKET:C103(sumDoc; vText2+"\t"+String:C10([Order:3]idNum:2)+"\t"+aText2{3}+"LOCKED"+"\t"+""+"\r")
		Else 
			
			If (Not:C34(Is new record:C668([Order:3])))
				SEND PACKET:C103(sumDoc; vText2+"\t"+String:C10([Order:3]idNum:2)+"\t"+aText2{3}+"\t"+String:C10([Invoice:26]idNum:2)+"\t"+""+"\t"+""+"\r")
				//already set for bulk commissions
				QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[Order:3]idNum:2)
				
				FIRST RECORD:C50([OrderLine:49])
				$cntLines:=Records in selection:C76([OrderLine:49])
				$lineNum:=500
				$isModified:=False:C215
				For ($incLines; 1; $cntLines)  //redundant clearing of existing lines.
					If ([OrderLine:49]lineNum:3>$lineNum)
						$lineNum:=[OrderLine:49]lineNum:3
					End if 
					If ([OrderLine:49]backOrdAmount:26#0)
						$isModified:=True:C214
					End if 
					If ([OrderLine:49]qtyBackLogged:8#0)
						$isModified:=True:C214
					End if 
					If ($isModified)
						[OrderLine:49]qtyShipped:7:=[OrderLine:49]qty:6
						[OrderLine:49]qtyBackLogged:8:=0
						[OrderLine:49]backOrdAmount:26:=0
						[OrderLine:49]complete:48:=True:C214
						SAVE RECORD:C53([OrderLine:49])
					End if 
					NEXT RECORD:C51([OrderLine:49])
				End for 
			End if 
			
			[Order:3]flow:134:=3
			vi2:=Size of array:C274(aLsItemNum)
			//OrderAddLineToExistingOrder
			C_REAL:C285($bulkValue)
			$valueInvoiced:=0
			For (vi1; 1; vi2)
				$valueInvoiced:=$valueInvoiced+aLsPrice{vi1}
			End for 
			$createLine:=True:C214
			$createOrder:=False:C215
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=vText3)
			//aoLineAction:=$lineNum+1
			$lineNum:=$lineNum+1
			If ($createLine)
				CREATE RECORD:C68([OrderLine:49])
				
				[OrderLine:49]lineNum:3:=[OrderLine:49]idNum:50
				[OrderLine:49]seq:30:=[OrderLine:49]lineNum:3
				
				[OrderLine:49]idNumOrder:1:=[Order:3]idNum:2
				
				[OrderLine:49]lineNum:3:=$lineNum
				[OrderLine:49]itemNum:4:="Com"+vText3+"1"
				[OrderLine:49]commRateRep:18:=6
				[OrderLine:49]commRateSales:29:=9
				[OrderLine:49]commRep:16:=Round:C94($valueInvoiced*6*0.01; 2)
				[OrderLine:49]commSales:17:=Round:C94($valueInvoiced*9*0.01; 2)
				[OrderLine:49]dateRequired:23:=Date:C102($lastDate)
				[OrderLine:49]dateShipOn:38:=[OrderLine:49]dateRequired:23
				[OrderLine:49]dateShipped:39:=[OrderLine:49]dateRequired:23
				[OrderLine:49]description:5:=$lastInvoice+" BulkCom "+$lastDate
				
				
				[OrderLine:49]unitWt:20:=[Item:4]weightAverage:8
				[OrderLine:49]location:22:=[Item:4]location:9
				
				Case of 
					: ([Order:3]customerID:1="")  //it is a new, unassigned order
						[OrderLine:49]qty:6:=$valueInvoiced
						[OrderLine:49]unitPrice:9:=1
						[OrderLine:49]extendedPrice:11:=$valueInvoiced
						[OrderLine:49]qtyShipped:7:=0
						[OrderLine:49]qtyBackLogged:8:=$valueInvoiced
					: (($valueInvoiced<0) & ($backlog=0))
						[OrderLine:49]qty:6:=$valueInvoiced
						[OrderLine:49]unitPrice:9:=1
						[OrderLine:49]extendedPrice:11:=$valueInvoiced
						If ($createInvoice)
							[OrderLine:49]qtyShipped:7:=$valueInvoiced
							[OrderLine:49]qtyBackLogged:8:=0
						Else 
							[OrderLine:49]qtyShipped:7:=0
							[OrderLine:49]qtyBackLogged:8:=$valueInvoiced
						End if 
					: ($backlog<0)
						[OrderLine:49]unitPrice:9:=1
						[OrderLine:49]qty:6:=$backlog
						[OrderLine:49]qtyShipped:7:=$backlog
						[OrderLine:49]extendedPrice:11:=[OrderLine:49]qtyShipped:7*[OrderLine:49]unitPrice:9
						[OrderLine:49]qtyBackLogged:8:=0
					: (($valueInvoiced>0) & ($backlog=0))
						[OrderLine:49]unitPrice:9:=1
						[OrderLine:49]qty:6:=$valueInvoiced
						[OrderLine:49]qtyShipped:7:=$valueInvoiced
						[OrderLine:49]extendedPrice:11:=$valueInvoiced
						[OrderLine:49]qtyBackLogged:8:=0
					: (($valueInvoiced<$backlog) & ($backlog>0))
						[OrderLine:49]unitPrice:9:=1
						[OrderLine:49]qty:6:=$backlog
						[OrderLine:49]qtyShipped:7:=$valueInvoiced
						[OrderLine:49]extendedPrice:11:=[OrderLine:49]qty:6*[OrderLine:49]unitPrice:9
						[OrderLine:49]qtyBackLogged:8:=$backlog-$valueInvoiced
					: (($valueInvoiced>$backlog) & ($backlog>0))
						[OrderLine:49]unitPrice:9:=1
						[OrderLine:49]qty:6:=$valueInvoiced
						[OrderLine:49]qtyShipped:7:=$valueInvoiced
						[OrderLine:49]extendedPrice:11:=[OrderLine:49]qty:6*[OrderLine:49]unitPrice:9
						[OrderLine:49]qtyBackLogged:8:=0
					Else 
						[OrderLine:49]unitPrice:9:=1
						[OrderLine:49]qty:6:=$backlog
						[OrderLine:49]qtyShipped:7:=$valueInvoiced
						[OrderLine:49]extendedPrice:11:=[OrderLine:49]qtyShipped:7*[OrderLine:49]unitPrice:9
						[OrderLine:49]qtyBackLogged:8:=$backlog-$valueInvoiced
				End case 
				
				[OrderLine:49]unitCost:12:=[Item:4]costAverage:13
				[OrderLine:49]extendedCost:13:=[OrderLine:49]unitCost:12*[OrderLine:49]qty:6
				[OrderLine:49]qtyCancelled:51:=0
				[OrderLine:49]typeSale:28:=[Order:3]typeSale:22
				[OrderLine:49]unitofMeasure:19:="Com"
				[OrderLine:49]itemNum:4:="Com"+vText3
				[OrderLine:49]location:22:=iLoLongInt2
				[OrderLine:49]unitofMeasure:19:=[Item:4]unitOfMeasure:11
				
				If ($createInvoice)  //process invoice on this line
					srOrd:=[Order:3]idNum:2
					CMAComInvoiceOneLine(2; [OrderLine:49]commRep:16+[OrderLine:49]commSales:17; 9; 6; $lastInvoice+" BulkCom "+$lastCriteria+": "+String:C10($dateInvoiced); $dateInvoiced)
				End if 
				
				
				
				SAVE RECORD:C53([OrderLine:49])
				
				If (Not:C34(Is new record:C668([Order:3])))
					CREATE RECORD:C68([OrderLine:49])
					
					[OrderLine:49]location:22:=[Item:4]location:9
					[OrderLine:49]lineNum:3:=$lineNum+1
					[OrderLine:49]itemNum:4:="Com"+vText3
					[OrderLine:49]commRateRep:18:=6
					[OrderLine:49]commRateSales:29:=9
					[OrderLine:49]commRep:16:=Round:C94($valueInvoiced*6*0.01; 2)
					[OrderLine:49]commSales:17:=Round:C94($valueInvoiced*9*0.01; 2)
					[OrderLine:49]dateRequired:23:=Date:C102($lastDate)
					[OrderLine:49]dateShipOn:38:=[OrderLine:49]dateRequired:23
					[OrderLine:49]dateShipped:39:=[OrderLine:49]dateRequired:23
					[OrderLine:49]description:5:=$lastInvoice+" BackLogOffset "+$lastCriteria
					[OrderLine:49]seq:30:=[OrderLine:49]lineNum:3
					[OrderLine:49]unitWt:20:=[Item:4]weightAverage:8
					[OrderLine:49]location:22:=[ManufacturerTerm:111]locationid:2
					[OrderLine:49]unitofMeasure:19:=[Item:4]unitOfMeasure:11
					
					[OrderLine:49]unitPrice:9:=-$backlog
					[OrderLine:49]qty:6:=1
					[OrderLine:49]qtyShipped:7:=1
					[OrderLine:49]extendedPrice:11:=-$backlog
					[OrderLine:49]qtyBackLogged:8:=0
					
					
					[OrderLine:49]unitCost:12:=[Item:4]costAverage:13
					[OrderLine:49]extendedCost:13:=[OrderLine:49]unitCost:12*[OrderLine:49]qty:6
					[OrderLine:49]qtyCancelled:51:=0
					[OrderLine:49]typeSale:28:=[Order:3]typeSale:22
					[OrderLine:49]unitofMeasure:19:="Com"
					[OrderLine:49]itemNum:4:="Com"+vText3
					[OrderLine:49]location:22:=[ManufacturerTerm:111]locationid:2
					
					SAVE RECORD:C53([OrderLine:49])
				End if 
				[Order:3]remoteRecordID:132:=aText2{5}
				[Order:3]remotecustomerID:133:=aText2{6}
				[Order:3]amountBackLog:54:=$backlog-$valueInvoiced
				[Order:3]dateNeeded:5:=Date:C102(aText2{4})
				[Order:3]lng:34:=DateTime_Enter
				SAVE RECORD:C53([Order:3])
				
				ADD TO SET:C119([Order:3]; "CurrentOrders")
				
				SAVE RECORD:C53([Customer:2])
				
				
				//Amount;Backlog;salesRate,repRate
				
				
				OrdLnFillRays  //get existing line arrays
				vMod:=True:C214
				booAccept:=True:C214
				acceptOrders
			End if 
		End if 
		
		UNLOAD RECORD:C212([Order:3])
		UNLOAD RECORD:C212([Customer:2])
		UNLOAD RECORD:C212([Invoice:26])
		UNLOAD RECORD:C212([Item:4])
		ARRAY TEXT:C222(ALSITEMDESC; 0)
		ARRAY TEXT:C222(ALSITEMNUM; 0)
		ARRAY REAL:C219(ALSQTYSO; 0)
		ARRAY REAL:C219(ALSPRICE; 0)
		$backlog:=0
		$valueInvoiced:=0
		If ($runFinal)
			$closeAll:=True:C214
		End if 
	End if 
	
	//$lastInvoice:=aText2{1}//happens at end of all action
	//get or create the customer
	//get or create the mfr customer xref
	//create the item number if needed
	//insert item number into array of items to be processed
	//create the order
	//create the invoice
	If (Not:C34($closeAll))
		If (Size of array:C274(aText2)>26)
			If (($lastInvoice#$thisInvoice) | (vi8=1))  //happens at end of all action
				QUERY:C277([Customer:2]; [Customer:2]customerID:1=aText2{30})
				$createOrder:=False:C215
				$createInvoice:=False:C215
				$lastInvoice:=aText2{1}  //set the Mfr InvoiceNum to determine if order needs to be saved 
				$lastDate:=aText2{4}
				$lastCriteria:=aText2{29}
				If ((aText2{28}="Create") | (aText2{28}="RMA@"))
					$createOrder:=True:C214
					
					OrderCreateBasics
					vComRep:=6
					vComSales:=9
					[Order:3]dateNeeded:5:=Date:C102(aText2{4})
					[Order:3]dateShipOn:31:=Date:C102(aText2{4})
					$dateInvoiced:=Date:C102(aText2{4})
					[Order:3]status:59:="Mfr Import"
					[Order:3]takenBy:36:="Mfr Import"
					OrdLnRays(0)
					
					//zzz
					[Order:3]dateCancel:53:=!00-00-00!
					[Order:3]taxJuris:43:=""  //no tax add for commissions
					If (aText2{28}="RMA@")
						[Order:3]terms:23:=aText2{28}
					Else 
						[Order:3]terms:23:=[MfrCustomerXRef:110]terms:32
					End if 
					[Order:3]repID:8:=[Customer:2]repID:58
					[Order:3]salesNameID:10:=[Customer:2]salesNameID:59
					[Order:3]autoFreight:40:=False:C215  //no freight calculation
					[Order:3]customerPO:3:=aText2{5}
					
					[Order:3]salesNameID:10:="Manuf"
					[Order:3]adSource:41:="Direct"
					//Division  == "consign"  from Mfr records
					[Order:3]remoteRecordID:132:=aText2{5}
					[Order:3]remotecustomerID:133:=aText2{6}
					[Order:3]dateDocument:4:=Current date:C33
					[Order:3]dateShipOn:31:=Date:C102(aText2{4})
					[Order:3]dateNeeded:5:=Date:C102(aText2{4})
					[Order:3]mfrOrdNum:51:=aText2{2}
					[Order:3]profile1:61:=aText2{5}
					[Order:3]profile2:62:=aText2{1}
					[Order:3]customerPO:3:=aText2{5}  //Mfg
					[Order:3]profile4:103:=aText2{5}  //Mfg
					[Order:3]profile5:104:=aText2{1}
					[Order:3]profile3:63:=aText2{6}
					[Order:3]mfrID:52:=vText3
					[Order:3]mfrName:91:=iLoText5
					If ((aText2{30}="Create@") | (aText2{30}="Multiple_@") | (Records in selection:C76([Customer:2])#1))
						[Order:3]company:15:=aText2{7}  //COMPANY    Customer must be blank so a read to makes sense
						[Order:3]profile5:104:=vText3
						[Order:3]dateNeeded:5:=Date:C102(aText2{16})
						[Order:3]address1:16:=aText2{16}  // SHIP_CITY     
						[Order:3]address2:17:=aText2{17}+" "+aText2{19}  //SHIP_STATE     SHIP_ZIPCODE
						[Order:3]city:18:=aText2{13}  // BILL_CITY   
						[Order:3]state:19:=aText2{14}  //BILL_STATE
						[Order:3]zip:20:=aText2{19}  //SHIP_ZIPCODE
						[Order:3]country:21:=aText2{18}  //SHIP_COUNTRY  
						//
						//[Order]Bill2Company:=aText2{7}//COMPANY    must be blank
						[Order:3]billToCity:97:=aText2{13}  // BILL_CITY   
						[Order:3]billToState:98:=aText2{14}  //BILL_STATE
						[Order:3]billToZip:99:=aText2{19}  //SHIP_ZIPCODE
						[Order:3]billToCountry:100:=aText2{18}  //SHIP_COUNTRY  
					Else 
						$createInvoice:=True:C214
					End if 
					
					//      DscntSpecialClr ([Order]TypeSale)
					
					//         zzz
					SEND PACKET:C103(sumDoc; vText1+"\t"+String:C10([Order:3]idNum:2)+"\t"+"Create"+"\t"+[Order:3]customerID:1+"\t"+"to Create"+"\r")
				Else 
					$createOrder:=False:C215
					
					QUERY:C277([Order:3]; [Order:3]idNum:2=Num:C11(aText2{28}))
					
					If (False:C215)
						If (([Order:3]idNum:2=547618) | ([Order:3]idNum:2=547586) | ([Order:3]idNum:2=533222))
							
							
							TRACE:C157
							
						End if 
					End if 
					
					If (Records in selection:C76([Order:3])=1)
						If (Locked:C147([Order:3]))
							SEND PACKET:C103(sumDoc; vText2+"\t"+String:C10([Order:3]idNum:2)+"\t"+aText2{3}+"LOCKED"+"\t"+""+"\r")
						Else 
							[Order:3]mfrOrdNum:51:=aText2{2}
							[Order:3]profile1:61:=aText2{5}
							[Order:3]profile2:62:=aText2{1}
							
							$createInvoice:=True:C214
							SAVE RECORD:C53([Order:3])
							$backlog:=OrdersFlowToCommission
							
							SEND PACKET:C103(sumDoc; vText1+"\t"+String:C10([Order:3]idNum:2)+"\t"+"Create"+"\t"+[Order:3]customerID:1+"\t"+String:C10($backlog)+"\r")
						End if 
						$dateInvoiced:=Date:C102(aText2{4})
					Else 
						SEND PACKET:C103(sumDoc; vText1+"\t"+"No Order by OrderNum: "+aText2{28}+"\r")
					End if 
				End if 
				
			End if 
			iLoText6:=aText2{8}+"_"+vText3  //the final item number
			//in all cases add the item line to the pending lines to manage
			APPEND TO ARRAY:C911(aLsItemNum; iLoText6)
			APPEND TO ARRAY:C911(aLsItemDesc; aText2{9})  //aText2{9}    DESCRIPTION    Description
			APPEND TO ARRAY:C911(aLsQtySO; Num:C11(aText2{10}))  //aText2{10}    QTYSHIPPED    QtyShipped
			vR1:=Util_NegativePara(aText2{12})
			APPEND TO ARRAY:C911(aLsPrice; vR1)  //aText2{11}    PRICE  
		End if 
		If (($runFinal) | (Size of array:C274(aText2)=0))
			$lastInvoice:="oioainsd8s18&7rwe8&^$#"
			
		End if 
	End if 
	
	KeyModifierCurrent
	If (CapKey=1)
		TRACE:C157
		CONFIRM:C162("Drop out of import?")
		If (OK=1)
			$closeAll:=True:C214
		End if 
	End if 
Until ($closeAll)


USE SET:C118("CurrentInvoices")
CLEAR SET:C117("CurrentInvoices")
ProcessCurrentSelection(->[Invoice:26]; ""; 2; iLoText4)  //ptTable; script; processFlow create set; NameAdder

DELAY PROCESS:C323(Current process:C322; 240)
USE SET:C118("CurrentOrders")
CLEAR SET:C117("CurrentOrders")
ProcessCurrentSelection(->[Order:3]; ""; 2; iLoText4)