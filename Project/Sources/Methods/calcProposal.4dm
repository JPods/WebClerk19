//%attributes = {"publishedWeb":true}
If (False:C215)
	Version_0602
	calcProposal
End if 
C_LONGINT:C283($i; $k)
C_REAL:C285($Amount; $Cost; $RepCom; $SalesCom; $TotWt; $TotTax)
C_BOOLEAN:C305($1; $0)
C_BOOLEAN:C305($doFrght)
If ($1)
	$doFrght:=False:C215
	Case of 
		: ((<>tcMONEYCHAR=strCurrency) | ([Proposal:42]currency:55="") | ([Proposal:42]exchangeRate:54=0) | (<>tcMONEYCHAR=""))
			$thePrec:=<>tcDecimalTt
			$d_rate:=1
		: ((strCurrency=[Proposal:42]currency:55) & ([Proposal:42]currency:55#""))
			$thePrec:=viExDisPrec
			$d_rate:=[Proposal:42]exchangeRate:54
			$doFrght:=True:C214
		: (<>tcMONEYCHAR#strCurrency)
			$thePrec:=viExDisPrec
			$d_rate:=[Proposal:42]exchangeRate:54
		Else 
			$thePrec:=<>tcDecimalTt
			$d_rate:=1
	End case 
	KeyModifierCurrent
	$Amount:=0
	$Cost:=0
	$RepCom:=0
	$SalesCom:=0
	$TotWt:=0
	$maxDays:=0
	$costTax:=0
	$TotTax:=0
	$countItems:=0
	$countBackLoggedItems:=0
	If (OptKey=0)
		$0:=False:C215
		C_LONGINT:C283($maxDays)
		$k:=Size of array:C274(aPLineAction)
		For ($i; 1; $k)
			// Modified by: William James (2014-04-02T00:00:00 Subrecord eliminated)
			aPSeq{$i}:=$i
			If (aPUse{$i}#"")
				PpLnExtend($i)
				$Cost:=$Cost+aPExtCost{$i}
				$Amount:=$Amount+aPExtPrice{$i}
				$RepCom:=$RepCom+aPRepComm{$i}
				$SalesCom:=$SalesCom+aPSaleComm{$i}
				$TotWt:=$TotWt+aPExtWt{$i}
				$TotTax:=$TotTax+aPSaleTax{$i}
				$costTax:=$costTax+aPTaxCost{$i}
				If ($maxDays<aPLeadTime{$i})
					$maxDays:=aPLeadTime{$i}
				End if 
				$countBackLoggedItems:=$countBackLoggedItems+aPQtyOpen{$i}
				$countItems:=$countItems+aPQtyOrder{$i}
			End if 
		End for 
	Else 
		C_LONGINT:C283($maxDays)
		$k:=Size of array:C274(aPPLnSelect)
		For ($i; 1; $k)
			PpLnExtend(aPPLnSelect{$i})
			$Cost:=$Cost+aPExtCost{aPPLnSelect{$i}}
			$Amount:=$Amount+aPExtPrice{aPPLnSelect{$i}}
			$RepCom:=$RepCom+aPRepComm{aPPLnSelect{$i}}
			$SalesCom:=$SalesCom+aPSaleComm{aPPLnSelect{$i}}
			$TotWt:=$TotWt+aPExtWt{aPPLnSelect{$i}}
			$TotTax:=$TotTax+aPSaleTax{aPPLnSelect{$i}}
			$costTax:=$costTax+aPTaxCost{aPPLnSelect{$i}}
			If ($maxDays<aPLeadTime{aPPLnSelect{$i}})
				$maxDays:=aPLeadTime{aPPLnSelect{$i}}
			End if 
			$countBackLoggedItems:=$countBackLoggedItems+aPQtyOpen{$i}
			$countItems:=$countItems+aPQtyOrder{$i}
		End for 
	End if 
	[Proposal:42]countItemsBl:85:=$countBackLoggedItems
	[Proposal:42]countItems:84:=$countItems
	[Proposal:42]amount:26:=Round:C94($Amount; $thePrec)
	If ([Proposal:42]amountForceValue:81#0)
		CalcOverRidePrice(->[Proposal:42])
	End if 
	If ([Proposal:42]daysLeadTime:40=0)
		[Proposal:42]daysLeadTime:40:=$maxDays
	End if 
	If ([Proposal:42]daysValidFor:39=0)
		[Proposal:42]daysValidFor:39:=30
	End if 
	//
	If ([Proposal:42]autoFreight:38)
		[Proposal:42]weightEstimate:45:=$TotWt
		ShippingCost(->[Proposal:42]shipVia:18; ->[Proposal:42]zone:19; ->[Proposal:42]weightEstimate:45; ->[Proposal:42]shipFreightCost:30; ->[Proposal:42]shipMiscCosts:29; ->[Proposal:42]shipAdjustments:28; ->[Proposal:42]terms:21; ->[Proposal:42]amount:26)
		If (($d_rate#1) & (Not:C34(([Proposal:42]zone:19=-1) | ([Proposal:42]zone:19=0))))
			[Proposal:42]shipFreightCost:30:=Round:C94([Proposal:42]exchangeRate:54*[Proposal:42]shipFreightCost:30; $thePrec)
			[Proposal:42]shipMiscCosts:29:=Round:C94([Proposal:42]exchangeRate:54*[Proposal:42]shipMiscCosts:29; $thePrec)
			If ([Proposal:42]shipAdjustments:28=0)  //Calculated value for adjustment in the base currency
				[Proposal:42]shipAdjustments:28:=Round:C94([Proposal:42]exchangeRate:54*[Proposal:42]shipAdjustments:28; $thePrec)
			End if 
		End if 
	Else 
		//leave the entered wt
	End if 
	//
	If (<>vbSalesTaxOnAmount)
		C_LONGINT:C283($findTax)
		$findTax:=Find in array:C230(<>aTaxJuris; [Invoice:26]taxJuris:33)
		If ($findTax>0)
			[Proposal:42]salesTax:27:=Round:C94([Proposal:42]amount:26*<>aTaxRateSales{$findTax}*0.01; $thePrec)
		Else 
			[Proposal:42]salesTax:27:=Round:C94([Proposal:42]amount:26*sTaxRate; $thePrec)  //sTaxRate  //[Order]TaxRate
		End if 
		[Proposal:42]taxOnCost:79:=0
	Else 
		[Proposal:42]salesTax:27:=Round:C94($TotTax; $thePrec)
		[Proposal:42]taxOnCost:79:=Round:C94($costTax; $thePrec)
	End if 
	
	[Proposal:42]totalCost:23:=Round:C94($Cost; $thePrec)
	If ($Amount#0)
		[Proposal:42]grossMargin:41:=Round:C94(($Amount-$Cost)/$Amount*100; $thePrec)
	Else 
		[Proposal:42]grossMargin:41:=0
	End if 
	
	$w:=Find in array:C230(<>aComNameID; [Proposal:42]salesNameID:9)
	If ($w>0)
		If (<>aEmpRateScript{$w}#"")
			$err:=0
			ExecuteText(0; <>aEmpRateScript{$w})
		Else 
			[Proposal:42]repCommission:8:=Round:C94($RepCom; $thePrec)
			[Proposal:42]salesCommission:10:=Round:C94($SalesCom; $thePrec)
		End if 
	Else 
		[Proposal:42]repCommission:8:=Round:C94($RepCom; $thePrec)
		[Proposal:42]salesCommission:10:=Round:C94($SalesCom; $thePrec)
	End if 
	[Proposal:42]shipTotal:31:=Round:C94([Proposal:42]shipMiscCosts:29+[Proposal:42]shipAdjustments:28+[Proposal:42]shipFreightCost:30; $thePrec)
	[Proposal:42]total:32:=Round:C94([Proposal:42]amount:26+[Proposal:42]salesTax:27+[Proposal:42]taxOnCost:79+[Proposal:42]shipTotal:31; $thePrec)
	If ([Proposal:42]customerID:1#"")
		If ($d_rate#1)
			$amount:=Trunc:C95([Proposal:42]amount:26/$d_rate; 0)
		End if 
		RunningBalance(->vRunningBal; ->myTrap; [Customer:2]creditLimit:37; [Customer:2]balanceDue:42; $amount; [Proposal:42]customerID:1)
	End if 
End if 
bCalcNow:=0