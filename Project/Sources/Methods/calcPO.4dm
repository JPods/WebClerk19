//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: calcPO
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
C_LONGINT:C283($i; $thePrec)
C_BOOLEAN:C305($0; $1)
C_LONGINT:C283($totalPrec)

If (<>viDebugMode>410)
	ConsoleMessage("CalcPO")
End if 
Case of 
	: ((<>tcMONEYCHAR=strCurrency) | ([PO:39]exchangeRate:45=0) | (<>tcMONEYCHAR=""))
		$thePrec:=<>tcDecimalTt
	: (<>tcMONEYCHAR#strCurrency)
		$thePrec:=viExDisPrec
	Else 
		$thePrec:=<>tcDecimalTt
End case 
If ($1)
	C_LONGINT:C283($i; $k)
	$k:=Size of array:C274(aPOLineAction)
	For ($i; 1; $k)
		PoLnExtend($i)
	End for 
	$0:=False:C215
	Calc_Totals(->[PO:39]amount:19; ->[PO:39]weightEstimate:48; ->curLines; ->viBoxCnt; ->aPOExtCost; ->aPoUnitWt; ->aPOQtyOrder)
	[PO:39]amount:19:=0
	[PO:39]taxJurisdiction:22:=0
	[PO:39]shipHandling:21:=0
	[PO:39]amountBackLog:25:=0
	[PO:39]weightEstimate:48:=0
	[PO:39]totalLanded:66:=0
	[PO:39]total:24:=0
	[PO:39]countItemsBl:83:=0
	[PO:39]countItems:82:=0
	For ($i; 1; Size of array:C274(aPOLineAction))
		[PO:39]amount:19:=[PO:39]amount:19+aPOExtCost{$i}
		[PO:39]totalLanded:66:=[PO:39]totalLanded:66+aPOExtCost{$i}+aPoNPCosts{$i}+aPoDuties{$i}
		[PO:39]taxJurisdiction:22:=[PO:39]taxJurisdiction:22+aPOVATax{$i}
		[PO:39]shipHandling:21:=[PO:39]shipHandling:21+aPoNPCosts{$i}
		[PO:39]amountBackLog:25:=[PO:39]amountBackLog:25+Round:C94(aPoBackLog{$i}; $thePrec)
		[PO:39]weightEstimate:48:=[PO:39]weightEstimate:48+(aPoUnitWt{$i}*aPOQtyOrder{$i})
		[PO:39]total:24:=[PO:39]total:24+aPOExtCost{$i}+aPoNPCosts{$i}+aPoDuties{$i}+aPOVATax{$i}
		
		[PO:39]countItemsBl:83:=[PO:39]countItemsBl:83+aPOQtyBL{$i}
		[PO:39]countItems:82:=[PO:39]countItems:82+aPOQtyOrder{$i}
	End for 
	
	//[PO]Total:=Round([PO]MiscAmount+[PO]Taxes+[PO]ShipHandling+[POs
	//]Amount;$thePrec)
End if 