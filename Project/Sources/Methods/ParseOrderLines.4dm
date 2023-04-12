//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 09/17/11, 14:44:05
// ----------------------------------------------------
// Method: ParseOrderLines
// Description
// 
//
// Parameters
// ----------------------------------------------------
//recalc the specifics
//

// ### bj ### 20181219_1001
// $k is never set to any value
// used in WCC_Parse of OrderLines
// uncertain is this is a correct action
//TRACE
C_LONGINT:C283($k; $viOrderNum; $0)
C_BOOLEAN:C305($lineTaxable; $notLocked)

C_LONGINT:C283($viOrderNum; $orderLineUniqueID; $lineDelete; $orderLineRecNum)
$viOrderNum:=[OrderLine:49]idNumOrder:1
$0:=$viOrderNum
If ([Order:3]idNum:2#[OrderLine:49]idNumOrder:1)
	QUERY:C277([Order:3]; [Order:3]idNum:2=[OrderLine:49]idNumOrder:1)
End if 
If ([Customer:2]customerID:1#[OrderLine:49]customerID:2)
	QUERY:C277([Customer:2]; [Customer:2]customerID:1=[OrderLine:49]customerID:2)
End if 
$notLocked:=True:C214
$lockedOrderLines:=Locked:C147([OrderLine:49])
$lockedOrders:=Locked:C147([Order:3])
$lockedCustomers:=Locked:C147([Customer:2])
If (($lockedOrderLines) | ($lockedOrders))  //|($lockedCustomers))
	vResponse:="Locked Records, Customers: "+String:C10(Num:C11($lockedCustomers))+"; Orders: "+String:C10(Num:C11($lockedOrders))+"; OrderLines: "+String:C10(Num:C11($lockedOrderLines))
	$notLocked:=False:C215
	$0:=-11
End if 

If ($notLocked)
	// ### bj ### 20200131_2359
	// do not allow the web changing of quantity shipped or backlog
	
	// ### bj ### 20200426_2343
	// qqqq Put in a dInventory process here
	[OrderLine:49]qtyShipped:7:=Old:C35([OrderLine:49]qtyShipped:7)
	[OrderLine:49]qtyBackLogged:8:=Old:C35([OrderLine:49]qtyBackLogged:8)
	
	$k:=Record number:C243([OrderLine:49])
	C_BOOLEAN:C305($lineTaxable)
	C_REAL:C285($vrTaxRate)
	
	$vrTaxRate:=[Order:3]taxRate:29
	// ### bj ### 20191012_1628
	// change to have a taxable field in each line
	If (($vrTaxRate>0) & ([OrderLine:49]salesTax:15>0))
		$lineTaxable:=True:C214
	Else 
		$lineTaxable:=False:C215
	End if 
	
	If ([OrderLine:49]lineNum:3=0)  // should never happen
		[OrderLine:49]lineNum:3:=[OrderLine:49]idNum:50
		If ([OrderLine:49]typeSale:28#(Old:C35([OrderLine:49]typeSale:28)))
			QUERY:C277([Item:4]; [Item:4]itemNum:1=[OrderLine:49]itemNum:4)
			DscntSetPrice([OrderLine:49]typeSale:28; [Order:3]dateDocument:4)
			OrdSetPrice(->[OrderLine:49]unitPrice:9; ->[OrderLine:49]discount:10; [OrderLine:49]qty:6; ->pComm)
			vComRep:=CM_FindRate(->[Order:3]repID:8; -><>aReps; -><>aRepRate)
			vComSales:=CM_FindRate(->[Order:3]salesNameID:10; -><>aComNameID; -><>aEmpRate)
			[OrderLine:49]commRateSales:29:=vComSales*pComm*0.01
			[OrderLine:49]commRateRep:18:=vComRep*pComm*0.01
		End if 
		
		// ### bj ### 20181219_1001
		// $k is never set to any value
		
		Case of 
			: (vPackingProcess="PK")  //when operating from the PK window
				//TRACE
				// how is this different that IvcLnLoadRec qqqq
				$dOnHand:=0
			: ($k>-1)  //existing order line
				C_REAL:C285($oldOnOrder; $newOnOrder; $dOnHand)
				// ### bj ### 20191012_1415
				// If there is a change in quantity ordered
				
				$oldOnOrder:=Old:C35([OrderLine:49]qty:6)
				$newOnOrder:=[OrderLine:49]qty:6  // restating the obvious for debugging
				$dOnOrder:=$newOnOrder-$oldOnOrder
				If ($dOnOrder<0)  // if reducing the order, it cannot drop below qty backLogged
					$dOnOrder:=-MaxChange([OrderLine:49]qtyBackLogged:8; Abs:C99($dOnOrder))
				End if 
				$dAction:=3
				Case of 
					: ($dOnOrder=0)
						//no action
					: (-$dOnOrder=Old:C35([OrderLine:49]qtyBackLogged:8))  // Change equals the QtyBackLogged
						// reducing the quantity ordered to the 
						[OrderLine:49]qtyBackLogged:8:=0
						[OrderLine:49]backOrdAmount:26:=0
						[OrderLine:49]qty:6:=[OrderLine:49]qtyShipped:7
						[OrderLine:49]complete:48:=False:C215
						OrdLnExtendSub
					: ($dOnOrder>0)  // adding to the quantity on order
						// [OrderLine]Complete:=false   ??
						[OrderLine:49]qtyBackLogged:8:=Old:C35([OrderLine:49]qtyBackLogged:8)+$dOnOrder
						OrdLnExtendSub
					Else 
						[OrderLine:49]qtyBackLogged:8:=[OrderLine:49]qty:6-[OrderLine:49]qtyShipped:7
						OrdLnExtendSub
				End case 
		End case 
		//  zzzzz
		
		
		
		SAVE RECORD:C53([OrderLine:49])
		
		Execute_TallyMaster("OrderLinesAfterParse"; "WebScript")
		
		// determine if the records is to be deleted
		$orderLineUniqueID:=[OrderLine:49]idNum:50
		$orderLineRecNum:=Record number:C243([OrderLine:49])
		$lineDelete:=Num:C11(([OrderLine:49]status:58="delete") | ([OrderLine:49]description:5="delete"))
		//
		
		C_LONGINT:C283($thisRecord)
		$thisRecord:=Record number:C243([OrderLine:49])
		//  PUSH RECORD([OrderLine])  //build the order before checking this order line.  May need to add a feature to identify new orderlines when one is created (-3000)
		
		
		
	End if 
End if 

