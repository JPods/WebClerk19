//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 07/24/06, 13:55:18
// ----------------------------------------------------
// Method: LN_DiscountFactor
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_REAL:C285(pDiscountFactor)
$perCentDiscount:=pDiscountFactor*0.01

pUnitCost:=Round:C94(pUnitPrice*$perCentDiscount; <>tcDecimalTt)
