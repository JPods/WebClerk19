//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/27/10, 19:57:59
// ----------------------------------------------------
// Method: Ord2InvComm
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("ProductInvoice"))
	C_LONGINT:C283(bComInv; $k; $i)
	C_REAL:C285($rateTotal; $pricePrec)
	C_LONGINT:C283($testLoc; $origCust; $origCust; $mfgRec)
	C_BOOLEAN:C305($tempTrack; $tempFrght)
	C_TEXT:C284($mfgAcct)
	C_TEXT:C284($typeSale)
	If (booAccept=True:C214)
		KeyModifierCurrent
		If (OptKey=1)
			$k:=Size of array:C274(aRayLines)
		Else 
			$k:=Size of array:C274(aODescpt)
			ARRAY LONGINT:C221(aRayLines; Size of array:C274(aODescpt))
			For ($i; 1; $k)
				aRayLines{$i}:=$i
			End for 
		End if 
		If ($k>0)
			$i:=0
			$testLoc:=aOLocation{aRayLines{1}}
			Repeat 
				
				$i:=$i+1
				If ((aOLocation{aRayLines{$i}}>-1999999) | (aOLocation{aRayLines{$i}}#$testLoc))
					ALERT:C41("Not all items have Mfg locations or the same Mfg.")
					$i:=$k
					$testLoc:=999999
				End if 
			Until ($i=$k)
			
			If ($testLoc<-1999999)
				$origCust:=Record number:C243([Customer:2])
				PUSH RECORD:C176([Customer:2])
				QUERY:C277([Customer:2]; [Customer:2]mfrLocationid:67=$testLoc)
				If (Records in selection:C76([Customer:2])>0)
					If (Records in selection:C76([Customer:2])>1)
						jAlertMessage(-9998)
					End if 
					FIRST RECORD:C50([Customer:2])
					$str40:=[Customer:2]company:2
					$mfgRec:=Record number:C243([Customer:2])
					$mfgAcct:=[Customer:2]customerID:1
				Else 
					$mfgRec:=-1
					$str40:=String:C10($testLoc)
				End if 
				POP RECORD:C177([Customer:2])
				If ($mfgRec=-1)
					ALERT:C41("No matching [Customer]MfrLocationID to match: "+String:C10($testLoc))
				Else 
					// CONFIRM("Create a Commission Invoice for "+$str40+"."+"\r"+"\r"+"There are "+String($k)+" lines.")
					CONFIRM:C162("Permanently convert Order to a Commission Order for "+$str40+"."+"\r"+"\r"+"There are "+String:C10($k)+" lines at Line Rates."; "Convert Order")
					If (OK=1)
						$pricePrec:=<>tcDecimalUP
						<>tcDecimalUP:=4
						BEEP:C151  //PLAY("Sosumi")
						If (Modified record:C314([Customer:2]))
							SAVE RECORD:C53([Customer:2])
						End if 
						acceptOrders
						If (OptKey=1)
							OrdLnShowSub  //reduces aO Order line item arrays to a selected sub-set
							// Modified by: williamjames (101227)
						End if 
						OptKey:=0  // Modified by: williamjames (101227)  //moved to after OrdLnShowSub
						//Commission Invoice all lines unless OptKey is down.  Then do selected lines.
						
						If (False:C215)
							OrderLineConvert2Commission  // should this create the [OrderLine] record
						End if 
						
						
						If (False:C215)
							For ($i; 1; $k)
								aODescpt{$i}:="CM "+aODescpt{$i}  //keep the original item number
								//         //         aOItemNum{$i}:="Com"+[Customer]AccountCode+"1"
								If (aOQtyOrder{$i}#0)
									aOUnitPrice{$i}:=(aOSaleComm{$i}+aORepComm{$i})/aOQtyOrder{$i}
								Else 
									aOUnitPrice{$i}:=0
								End if 
								aODiscnt{$i}:=0
								$rateTotal:=aORepRate{$i}+aOSalesRate{$i}
								If ($rateTotal#0)
									aOSalesRate{$i}:=(aOSalesRate{$i}/$rateTotal)*100
									aORepRate{$i}:=(aORepRate{$i}/$rateTotal)*100
								Else 
									aOSalesRate{$i}:=0
									aORepRate{$i}:=0
								End if 
								aOSaleTax{$i}:=0
								aOTaxable{$i}:=""
								aOUnitCost{$i}:=0
								aOExtCost{$i}:=0
								aOUnitWt{$i}:=0
								aOExtWt{$i}:=0
							End for 
						End if 
						
						
						
						$tempTrack:=<>tcbLoadItem
						$tempFrght:=(<>tcAutoFrght=1)
						<>tcAutoFrght:=0  //this is OK, reset below May 1, 1995
						<>tcbLoadItem:=False:C215
						C_REAL:C285($curOpenOrd; $ordChange)
						$curOpenOrd:=[Order:3]amountBackLog:54
						GOTO RECORD:C242([Customer:2]; $mfgRec)
						[Order:3]customerID:1:=[Customer:2]customerID:1
						//[Order]Bill2Company:=[Customer]Company   want it to stay the shipto address
						$typeSale:=[Order:3]typeSale:22
						[Order:3]typeSale:22:="!Commission"
						SAVE RECORD:C53([Order:3])
						myCycle:=12  //use the existing order arrays to build invoice
						
						FORM SET INPUT:C55([Invoice:26]; "Input")
						
						ADD RECORD:C56([Invoice:26])
						TRACE:C157
						If ([Invoice:26]balanceDue:44#0)
							[Customer:2]tallyStatus:74:=True:C214
						End if 
						//
						//If (Record number([Invoice])>-1)
						//[Customer]SalesYTD:=[Customer]SalesYTD-[Invoice]Amount
						//[Customer]SalesMTD:=[Customer]SalesMTD-[Invoice]Amount
						//[Customer]CostsYTD:=[Customer]CostsYTD-[Invoice]TotalCost
						//[Customer]CostsMTD:=[Customer]CostsMTD-[Invoice]TotalCost
						//SAVE RECORD([Customer])
						//End if 
						//        
						GOTO RECORD:C242([Customer:2]; $origCust)
						//
						//If (Record number([Invoice])>-1)
						//[Customer]LastSaleAmount:=[Invoice]Total
						//[Customer]SalesYTD:=[Customer]SalesYTD+[Invoice]Amount
						//[Customer]SalesMTD:=[Customer]SalesMTD+[Invoice]Amount
						//[Customer]CostsYTD:=[Customer]CostsYTD+[Invoice]TotalCost
						//[Customer]CostsMTD:=[Customer]CostsMTD+[Invoice]TotalCost
						//End if 
						//
						[Order:3]typeSale:22:=$typeSale
						[Order:3]customerID:1:=[Customer:2]customerID:1
						$ordChange:=[Order:3]amountBackLog:54-$curOpenOrd
						If ($ordChange#0)
							[Customer:2]balanceOpenOrders:78:=Round:C94([Customer:2]balanceOpenOrders:78+$ordChange; <>tcDecimalTt)
						End if 
						SAVE RECORD:C53([Customer:2])
						srAcct:=[Customer:2]customerID:1
						srCustomer:=[Customer:2]company:2
						srPhone:=[Customer:2]phone:13
						srZip:=[Customer:2]zip:8
						<>tcbLoadItem:=$tempTrack
						<>tcAutoFrght:=Num:C11($tempFrght)
						doItemList:=True:C214
						//FIRST RECORD([Order])    very bad.  // Modified by: williamjames (12/19/11)  Should not have been here
						OrdLnFillRays
						//myCycle:=0
						//       Accept_CalcStat ([Order];False;aOQtyShip;aOQtyBL)
						If ([Order:3]status:59="Completed")
							[Order:3]dtProdCompl:57:=DateTime_DTTo
							[Order:3]dateInvoiceComp:6:=Current date:C33
						End if 
						If ([Order:3]actionBy:55="")
							[Order:3]actionBy:55:=Current user:C182
						End if 
						If ([Order:3]dtProdRelease:56=0)
							[Order:3]dtProdRelease:56:=DateTime_DTTo
						End if 
						SAVE RECORD:C53([Order:3])
						vLineMod:=True:C214
						ENABLE MENU ITEM:C149(4; 6)
						ENABLE MENU ITEM:C149(4; 7)
						DISABLE MENU ITEM:C150(5; 5)
						<>tcDecimalUP:=$pricePrec
					End if 
				End if 
			End if 
		End if 
	Else 
		jAlertMessage(9200)
	End if 
End if 