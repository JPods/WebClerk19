//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-22T00:00:00, 02:16:48
// ----------------------------------------------------
// Method: OrdLnExtendSub
// Description
// Modified: 01/22/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_REAL:C285($discntPrc)

If ([OrderLine:49]profile1:32="")
	[OrderLine:49]profile1:32:=pvLnProfile1
End if 
If ([OrderLine:49]profile2:33="")
	[OrderLine:49]profile2:33:=pvLnProfile2
End if 
If ([OrderLine:49]profile3:34="")
	[OrderLine:49]profile3:34:=pvTaxRate
End if 

// ### bj ### 20191012_1722
// shift to a line based field
[OrderLine:49]salesTax:15:=Num:C11(pvTax)
[OrderLine:49]taxCost:55:=Num:C11(pvTax)

$discntPrc:=DiscountApply([OrderLine:49]unitPrice:9; [OrderLine:49]discount:10; <>tcDecimalUP+4)
If ([OrderLine:49]complete:48)
	[OrderLine:49]qtyOrdered:6:=[OrderLine:49]qtyShipped:7
	[OrderLine:49]qtyBackLogged:8:=0
	[OrderLine:49]backOrdAmount:26:=0
	[OrderLine:49]extendedPrice:11:=Round:C94([OrderLine:49]qtyOrdered:6*$discntPrc; <>tcDecimalTt)
	[OrderLine:49]extendedCost:13:=Round:C94([OrderLine:49]qtyOrdered:6*[OrderLine:49]unitCost:12; <>tcDecimalTt)
	If (<>vldoTaxWeb<1)
		[OrderLine:49]salesTax:15:=Round:C94((Num:C11(([OrderLine:49]taxid:14#"") & (doTax)))*[OrderLine:49]extendedPrice:11*sTaxRate; <>tcDecimalTt)
	Else 
		TaxWebService
	End if 
	CM_LineCalc(<>tcSaleMar; -1; ->[OrderLine:49]extendedPrice:11; ->[OrderLine:49]extendedCost:13; ->[OrderLine:49]commRateSales:29; ->[OrderLine:49]commSales:17; ->[OrderLine:49]qtyShipped:7)
	CM_LineCalc(<>tcSaleMar; -1; ->[OrderLine:49]extendedPrice:11; ->[OrderLine:49]extendedCost:13; ->[OrderLine:49]commRateRep:18; ->[OrderLine:49]commRep:16; ->[OrderLine:49]qtyShipped:7)
	[OrderLine:49]extendedWt:21:=[OrderLine:49]qtyOrdered:6*[OrderLine:49]unitWt:20
Else 
	[OrderLine:49]extendedPrice:11:=Round:C94([OrderLine:49]qtyOrdered:6*$discntPrc; <>tcDecimalTt)
	[OrderLine:49]extendedCost:13:=Round:C94([OrderLine:49]qtyOrdered:6*[OrderLine:49]unitCost:12; <>tcDecimalTt)
	[OrderLine:49]extendedWt:21:=[OrderLine:49]qtyOrdered:6*[OrderLine:49]unitWt:20
	[OrderLine:49]backOrdAmount:26:=Round:C94([OrderLine:49]qtyBackLogged:8*$discntPrc; <>tcDecimalTt)
	If (<>vldoTaxWeb<1)
		[OrderLine:49]salesTax:15:=Round:C94((Num:C11(([OrderLine:49]taxid:14#"") & (doTax)))*[OrderLine:49]extendedPrice:11*sTaxRate; <>tcDecimalTt)
	Else 
		TaxWebService
	End if 
	
	CM_LineCalc(<>tcSaleMar; -1; ->[OrderLine:49]extendedPrice:11; ->[OrderLine:49]extendedCost:13; ->[OrderLine:49]commRateSales:29; ->[OrderLine:49]commSales:17; ->[OrderLine:49]qtyOrdered:6)
	CM_LineCalc(<>tcSaleMar; -1; ->[OrderLine:49]extendedPrice:11; ->[OrderLine:49]extendedCost:13; ->[OrderLine:49]commRateRep:18; ->[OrderLine:49]commRep:16; ->[OrderLine:49]qtyOrdered:6)
End if 



