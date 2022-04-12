//%attributes = {"publishedWeb":true}
C_LONGINT:C283($i)
C_REAL:C285($Amount; $Cost; $RepCom; $SalesCom; $TotWt; $tax)
C_BOOLEAN:C305($0; $1)
If (Count parameters:C259=0)
	$doCalc:=True:C214
Else 
	$doCalc:=$1
End if 
$0:=False:C215
If ($doCalc)
	$doFrght:=False:C215
	$doBalCurr:=(([Invoice:26]currency:62#"") & (([Invoice:26]exchangeRate:61=0) | ([Invoice:26]exchangeRate:61=1)))
	Case of 
		: ((<>tcMONEYCHAR=strCurrency) | ([Invoice:26]exchangeRate:61=0) | ([Invoice:26]exchangeRate:61=1) | (<>tcMONEYCHAR=""))
			$thePrec:=<>tcDecimalTt
			$d_rate:=1
		: ((strCurrency=[Invoice:26]currency:62) & ([Invoice:26]currency:62#""))
			$thePrec:=viExDisPrec
			$d_rate:=[Invoice:26]exchangeRate:61
			$doFrght:=True:C214
		: (<>tcMONEYCHAR#strCurrency)
			$thePrec:=viExDisPrec
			$d_rate:=[Invoice:26]exchangeRate:61
		Else 
			$thePrec:=<>tcDecimalTt
			$d_rate:=1
	End case 
	$amount:=0
	$cost:=0
	$repCom:=0
	$salesCom:=0
	$totWt:=0
	$tax:=0
	$costTax:=0
	$countItems:=0
	$k:=Size of array:C274(aiLineAction)
	For ($i; 1; $k)
		aiSeq{$i}:=$i
		IvcLnExtend($i)
		$amount:=$amount+aiExtPrice{$i}
		$cost:=$cost+aiExtCost{$i}
		$repCom:=$repCom+aiRepComm{$i}
		$salesCom:=$salesCom+aiSaleComm{$i}
		$totWt:=$totWt+aiExtWt{$i}
		$tax:=$tax+aiSaleTax{$i}
		$costTax:=$costTax+aiTaxCost{$i}
		
		$countItems:=$countItems+aiQtyShip{$i}
	End for 
	[Invoice:26]countItems:92:=$countItems
	
	[Invoice:26]weightEstimate:42:=$totWt
	[Invoice:26]amount:14:=Round:C94($amount; $thePrec)
	If ([Invoice:26]amountForceValue:90#0)
		CalcOverRidePrice(->[Invoice:26])
	End if 
	[Invoice:26]totalCost:37:=Round:C94($cost; $thePrec)
	
	If (<>vbSalesTaxOnAmount)
		C_LONGINT:C283($findTax)
		$findTax:=Find in array:C230(<>aTaxJuris; [Invoice:26]taxJuris:33)
		If ($findTax>0)
			[Invoice:26]salesTax:19:=Round:C94([Invoice:26]amount:14*<>aTaxRateSales{$findTax}*0.01; $thePrec)
		Else 
			[Invoice:26]salesTax:19:=Round:C94([Invoice:26]amount:14*sTaxRate; $thePrec)
		End if 
		[Invoice:26]taxOnCost:88:=0
	Else 
		[Invoice:26]salesTax:19:=Round:C94($tax; $thePrec)
		[Invoice:26]taxOnCost:88:=Round:C94($costTax; $thePrec)
	End if 
	
	$w:=Find in array:C230(<>aComNameID; [Invoice:26]salesNameID:23)
	If ($w>0)
		If (<>aEmpRateScript{$w}#"")
			$err:=0
			ExecuteText(0; <>aEmpRateScript{$w})
		Else 
			[Invoice:26]repCommission:28:=Round:C94($repCom; $thePrec)
			[Invoice:26]salesCommission:36:=Round:C94($salesCom; $thePrec)
		End if 
	Else 
		[Invoice:26]repCommission:28:=Round:C94($repCom; $thePrec)
		[Invoice:26]salesCommission:36:=Round:C94($salesCom; $thePrec)
	End if 
	//
	If ([Invoice:26]autoFreight:32)  //|(Records in selection([LoadTag])>0))
		QUERY:C277([LoadTag:88]; [LoadTag:88]invoiceNum:19=[Invoice:26]invoiceNum:2)
		
		//If (Records in selection([LoadTag])>0)
		ShippingCost(->[Invoice:26]shipVia:5; ->[Invoice:26]zone:6; ->[Invoice:26]weightEstimate:42; ->[Invoice:26]shipFreightCost:15; ->[Invoice:26]shipMiscCosts:16; ->[Invoice:26]shipAdjustments:17; ->[Invoice:26]terms:24; ->[Invoice:26]amount:14; ->[Invoice:26]labelCount:25)
		If (([Invoice:26]orderNum:1#1) & ([Order:3]completeid:83=1) & (<>tcNoCodHand))
			[Invoice:26]shipAdjustments:17:=-[Invoice:26]shipMiscCosts:16
		End if 
		//Else 
		
		//End if 
		If (($d_rate#1) & (Not:C34(([Invoice:26]zone:6=-1) | ([Invoice:26]zone:6=0))))  //in a different currency
			[Invoice:26]shipFreightCost:15:=Round:C94([Invoice:26]exchangeRate:61*[Invoice:26]shipFreightCost:15; $thePrec)
			[Invoice:26]shipMiscCosts:16:=Round:C94([Invoice:26]exchangeRate:61*[Invoice:26]shipMiscCosts:16; $thePrec)
			If ([Invoice:26]shipAdjustments:17=0)  //Calculated value for adjustment in the base currency
				[Invoice:26]shipAdjustments:17:=Round:C94([Invoice:26]exchangeRate:61*[Invoice:26]shipAdjustments:17; $thePrec)
			End if 
		End if 
	Else 
		//leave wt as entered
	End if 
	[Invoice:26]shipTotal:20:=Round:C94([Invoice:26]shipMiscCosts:16+[Invoice:26]shipAdjustments:17+[Invoice:26]shipFreightCost:15; $thePrec)
	// ### bj ### 20180918_1558
	// gmgmgm
	C_REAL:C285(vrTaxShipping)
	C_LONGINT:C283($findTax)
	vrTaxShipping:=0
	$findTax:=Find in array:C230(<>aTaxJuris; [Invoice:26]taxJuris:33)
	If ($findTax>0)
		Case of 
			: (<>aTaxScriptShipping{$findTax}#"")
				vrTaxShipping:=0
				ExecuteText(0; <>aTaxScriptCost{$findTax}*0.01)
				//aOSaleTax{$6}:=vR1
				// vrTaxShipping is to be the returned value
			: (<>aTaxRateShipping{$findTax}#0)
				vrTaxShipping:=Round:C94([Invoice:26]shipTotal:20*<>aTaxRateShipping{$findTax}*0.01; $thePrec)
			Else 
				// do nothing
		End case 
	End if 
	[Invoice:26]taxOnShipping:105:=vrTaxShipping
	[Invoice:26]taxTotal:106:=[Invoice:26]salesTax:19+[Invoice:26]taxOnCost:88+[Invoice:26]taxOnShipping:105  // ### jwm ### 20181005_1337
	[Invoice:26]total:18:=Round:C94([Invoice:26]amount:14+[Invoice:26]taxTotal:106+[Invoice:26]shipTotal:20; $thePrec)  // ### jwm ### 20181005_1339
	[Invoice:26]balanceDue:44:=Round:C94([Invoice:26]total:18-[Invoice:26]appliedDiscount:45-[Invoice:26]appliedAmount:46; $thePrec)
	If ([Invoice:26]customerID:3#"")
		If ($d_rate#1)
			$amount:=Trunc:C95([Invoice:26]amount:14/$d_rate; 0)
		End if 
		RunningBalance(->vRunningBal; ->myTrap; [Customer:2]creditLimit:37; [Customer:2]balanceDue:42; $amount; [Invoice:26]customerID:3)
	End if 
End if 