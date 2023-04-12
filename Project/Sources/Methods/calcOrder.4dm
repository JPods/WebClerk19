//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/23/11, 15:01:32
// ----------------------------------------------------
// Method: calcOrder
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20170411_1113 added protection for EDI

C_LONGINT:C283($i; bExchange)
C_REAL:C285($Amount; $Cost; $RepCom; $SalesCom; $TotWt; $backLog; $tax; vrOldValue)
C_BOOLEAN:C305($0; $1)
C_BOOLEAN:C305($doFrght)
If ($1)
	Case of 
		: ((<>tcMONEYCHAR=strCurrency) | ([Order:3]currency:69="") | ([Order:3]exchangeRate:68=0) | (<>tcMONEYCHAR=""))
			$thePrec:=<>tcDecimalTt
			$d_rate:=1
		: ((strCurrency=[Order:3]currency:69) & ([Order:3]currency:69#""))
			$thePrec:=viExDisPrec
			$d_rate:=[Order:3]exchangeRate:68
			$doFrght:=True:C214
		: (<>tcMONEYCHAR#strCurrency)
			$thePrec:=viExDisPrec
			$d_rate:=[Order:3]exchangeRate:68
		Else 
			$thePrec:=<>tcDecimalTt
			$d_rate:=1
	End case 
	If (<>tcbManyType)  //&(bManyType=1))
		Discnt_BySale
	End if 
	$0:=False:C215
	$amount:=0
	$backLog:=0
	$cost:=0
	$repCom:=0
	$salesCom:=0
	$totWt:=0
	$tax:=0
	$costTax:=0
	$countBackLoggedItems:=0
	$countItems:=0
	If (False:C215)
		If ([Order:3]flow:134=2)  //Bulk Commission 
			For ($i; 1; Size of array:C274(aoLineAction))
				If (aOItemNum{$i}="Com"+[Order:3]mfrID:52+"@")
					OrdLnExtend($i)
					
					$amount:=$amount+aOExtPrice{$i}
					$backLog:=$backLog+aOBackLog{$i}
					$cost:=$cost+aOExtCost{$i}
					$repCom:=$repCom+aORepComm{$i}
					$salesCom:=$salesCom+aOSaleComm{$i}
					$totWt:=$totWt+aOExtWt{$i}
					$tax:=$tax+aOSaleTax{$i}
					$costTax:=$costTax+aOTaxCost{$i}
					
					$countBackLoggedItems:=$countBackLoggedItems+aOQtyBL{$i}
					$countItems:=$countItems+aOQtyOrder{$i}
				End if 
			End for 
		End if 
	End if 
	//Else 
	// Modified by: williamjames (130405)  Preventing duplicate line errors
	$k:=Size of array:C274(aoLineAction)
	
	C_LONGINT:C283($raySize; $rayIncrement)
	For ($i; 1; $k)
		aOSeq{$i}:=$i
		If (False:C215)  // (Shift down) & (allowAlerts_boo))  // ### jwm ### 20170411_1113 added protection for EDI
			CONFIRM:C162("i value="+String:C10($i)+"; aoLineAction size="+String:C10($k)+"; aoLineAction size="+String:C10(Size of array:C274(aOQtyOrder)))
			If ((OK=1) & ($i<=$k) & ($i>0))
				ALERT:C41(aOItemNum{$i})
			End if 
		End if 
		
		If (($i<=$k) & ($i>0))
			OrdLnExtend($i)
			
			$amount:=$amount+aOExtPrice{$i}
			$backLog:=$backLog+aOBackLog{$i}
			$cost:=$cost+aOExtCost{$i}
			$repCom:=$repCom+aORepComm{$i}
			$salesCom:=$salesCom+aOSaleComm{$i}
			$totWt:=$totWt+aOExtWt{$i}
			$tax:=$tax+aOSaleTax{$i}
			$costTax:=$costTax+aOTaxCost{$i}
			
			$countBackLoggedItems:=$countBackLoggedItems+aOQtyBL{$i}
			
			
			If (($i>0) & ($i<Size of array:C274(aOQtyOrder)))
				$countItems:=$countItems+aOQtyOrder{$i}
			End if 
			// Modified by: William James BUG_To_Hunt #85
		End if 
		
	End for 
	//End if 
	[Order:3]countItemsBl:123:=$countBackLoggedItems
	[Order:3]countItems:124:=$countItems
	
	[Order:3]amount:24:=Round:C94($amount; $thePrec)
	If ([Order:3]amountForceValue:112#0)
		CalcOverRidePrice(->[Order:3])
	End if 
	[Order:3]totalCost:42:=Round:C94($cost; $thePrec)
	If ([Order:3]amount:24>0)
		[Order:3]grossMargin:47:=Trunc:C95(([Order:3]amount:24-[Order:3]totalCost:42)/[Order:3]amount:24*100; 1)
	Else 
		[Order:3]grossMargin:47:=0
	End if 
	//
	If (<>vbSalesTaxOnAmount)
		C_LONGINT:C283($findTax)
		$findTax:=Find in array:C230(<>aTaxJuris; [Order:3]taxJuris:43)
		// Modified by: williamjames (110323  was [Invoice]TaxJuris)
		
		If ($findTax>0)
			[Order:3]salesTax:28:=Round:C94([Order:3]amount:24*<>aTaxRateSales{$findTax}*0.01; $thePrec)
		Else 
			[Order:3]salesTax:28:=Round:C94([Order:3]amount:24*sTaxRate; $thePrec)  //sTaxRate  //[Order]TaxRate
		End if 
		[Order:3]taxOnCost:109:=0
	Else 
		[Order:3]salesTax:28:=Round:C94($tax; $thePrec)
		[Order:3]taxOnCost:109:=Round:C94($costTax; $thePrec)
	End if 
	[Order:3]taxTotal:141:=[Order:3]salesTax:28+[Order:3]taxOnCost:109  // ### jwm ### 20181005_1339
	$w:=Find in array:C230(<>aComNameID; [Order:3]salesNameID:10)
	If ($w>0)
		If (<>aEmpRateScript{$w}#"")
			$err:=0
			ExecuteText(0; <>aEmpRateScript{$w})
		Else 
			[Order:3]repCommission:9:=Round:C94($repCom; $thePrec)
			[Order:3]salesCommission:11:=Round:C94($salesCom; $thePrec)
		End if 
	Else 
		[Order:3]repCommission:9:=Round:C94($repCom; $thePrec)
		[Order:3]salesCommission:11:=Round:C94($salesCom; $thePrec)
	End if 
	//
	[Order:3]weightEstimate:49:=$totWt
	
	<>FreightService:=0
	
	If (<>FreightService=2)
		// XML_FedExRateRequest 
		shipVia:=[Order:3]shipVia:13
		C_REAL:C285($freightAutoPrice)
		// If (<>doAutoFreight)
		$p:=Position:C15(shipVia; <>tcMONEYCHAR)
		If ($p>0)
			$shipViaAuto:=Substring:C12(shipVia; 1; $p-1)
			$freightAutoPrice:=Num:C11(Substring:C12(shipVia; $p+1))
		End if 
		[Order]shipAuto:=False:C215
		[Order:3]shipFreightCost:38:=$freightAutoPrice
	Else 
		If ([Order]shipAuto)
			QUERY:C277([LoadTag:88]; [LoadTag:88]idNumOrder:29=[Order:3]idNum:2)
			ShippingCost(->[Order:3]shipVia:13; ->[Order:3]zone:14; ->[Order:3]weightEstimate:49; ->[Order:3]shipFreightCost:38; ->[Order:3]shipMiscCosts:25; ->[Order:3]shipAdjustments:26; ->[Order:3]terms:23; ->[Order:3]amount:24; ->[Order:3]labelCount:32)
			If (($d_rate#1) & (Not:C34(([Order:3]zone:14=-1) | ([Order:3]zone:14=0))))
				[Order:3]shipFreightCost:38:=Round:C94([Order:3]exchangeRate:68*[Order:3]shipFreightCost:38; $thePrec)
				[Order:3]shipMiscCosts:25:=Round:C94([Order:3]exchangeRate:68*[Order:3]shipMiscCosts:25; $thePrec)
				If ([Order:3]shipAdjustments:26=0)  //Calculated value for adjustment in the base currency
					[Order:3]shipAdjustments:26:=Round:C94([Order:3]exchangeRate:68*[Order:3]shipAdjustments:26; $thePrec)
				End if 
			End if 
		Else 
			//leave the entered value
		End if 
	End if 
	[Order:3]shipTotal:30:=Round:C94([Order:3]shipMiscCosts:25+[Order:3]shipAdjustments:26+[Order:3]shipFreightCost:38; $thePrec)
	[Order:3]total:27:=Round:C94([Order:3]amount:24+[Order:3]salesTax:28+[Order:3]taxOnCost:109+[Order:3]shipTotal:30; $thePrec)
	[Order:3]amountBackLog:54:=Round:C94($backLog; $thePrec)
	QUERY:C277([Payment:28]; [Payment:28]idNumOrder:2=[Order:3]idNum:2)
	[Order:3]balanceDueEstimated:107:=Sum:C1([Payment:28]amount:1)
	If (allowAlerts_boo)
		PayLoadShow(Records in selection:C76([Payment:28]))
	Else 
		REDUCE SELECTION:C351([Payment:28]; 0)
		PayLoadShow(0)
	End if 
	
	If ([Order:3]customerID:1#"")
		If ($d_rate#1)
			$amount:=Trunc:C95([Order:3]amount:24/$d_rate; 0)
		End if 
		RunningBalance(->vRunningBal; ->myTrap; [Customer:2]creditLimit:37; [Customer:2]balanceDue:42; $amount-vrOldValue; [Order:3]customerID:1)
	End if 
End if 
bCalcNow:=0
vLineMod:=False:C215
