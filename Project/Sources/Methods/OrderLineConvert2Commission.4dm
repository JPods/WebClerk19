//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/23/11, 18:12:32
// ----------------------------------------------------
// Method: OrderLineConvert2Commission
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283(bComInv; $k; $i)
$k:=Size of array:C274(aODescpt)
C_REAL:C285($repCommission; $salesCommission; $totalCommission)

For ($i; 1; $k)
	QUERY:C277([OrderLine:49]; [OrderLine:49]idNum:50=aoUniqueID{$i})
	
	aODescpt{$i}:="CM "+aODescpt{$i}  //keep the original item number
	// aOItemNum{$i}:="Com"+[Customer]AccountCode+"1"
	[OrderLine:49]description:5:=aODescpt{$i}
	If (aOQtyOrder{$i}#0)
		aOUnitPrice{$i}:=(aOSaleComm{$i}+aORepComm{$i})/aOQtyOrder{$i}
	Else 
		aOUnitPrice{$i}:=0
	End if 
	[OrderLine:49]unitPrice:9:=aOUnitPrice{$i}
	aODiscnt{$i}:=0
	[OrderLine:49]discount:10:=0
	
	$rateTotal:=aORepRate{$i}+aOSalesRate{$i}
	If ($rateTotal#0)
		aOSalesRate{$i}:=(aOSalesRate{$i}/$rateTotal)*100
		aORepRate{$i}:=(aORepRate{$i}/$rateTotal)*100
	Else 
		aOSalesRate{$i}:=0
		aORepRate{$i}:=0
	End if 
	[OrderLine:49]commRateRep:18:=aORepRate{$i}
	[OrderLine:49]commRateSales:29:=aOSalesRate{$i}
	
	aOSaleTax{$i}:=0
	aOTaxable{$i}:=""
	aOUnitCost{$i}:=0
	aOExtCost{$i}:=0
	aOUnitWt{$i}:=0
	aOExtWt{$i}:=0
	
	[OrderLine:49]taxCost:55:=0
	[OrderLine:49]unitWt:20:=aOUnitWt{$i}
	[OrderLine:49]unitCost:12:=aOUnitCost{$i}
	[OrderLine:49]extendedCost:13:=aOExtCost{$i}
	[OrderLine:49]taxid:14:=aOTaxable{$i}
	[OrderLine:49]salesTax:15:=aOSaleTax{$i}
	SAVE RECORD:C53([OrderLine:49])
	
	
	
	
End for 