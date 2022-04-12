//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): jmedlen
// Date and time: 02/08/10, 11:01:33
// ----------------------------------------------------
// Method: setChTax
// Description
// updated <>aLinetaxID to include DoTax
//
// Parameters
// ----------------------------------------------------
CREATE SET:C116([TaxJurisdiction:14]; "Current")
READ ONLY:C145([TaxJurisdiction:14])
QUERY:C277([TaxJurisdiction:14]; [TaxJurisdiction:14]active:3=True:C214)
ARRAY TEXT:C222(<>aTaxJuris; 0)
ARRAY TEXT:C222(<>aTaxService; 0)
ARRAY TEXT:C222(<>aTaxScriptSales; 0)
ARRAY REAL:C219(<>aTaxRateSales; 0)
ARRAY TEXT:C222(<>aTaxScriptCost; 0)
ARRAY REAL:C219(<>aTaxRateCost; 0)
ARRAY TEXT:C222(<>aTaxScriptShipping; 0)
ARRAY REAL:C219(<>aTaxRateShipping; 0)

SELECTION TO ARRAY:C260([TaxJurisdiction:14]taxJurisdiction:1; <>aTaxJuris; [TaxJurisdiction:14]taxService:8; <>aTaxService; [TaxJurisdiction:14]scriptSales:12; <>aTaxScriptSales; [TaxJurisdiction:14]taxRateSales:2; <>aTaxRateSales; [TaxJurisdiction:14]scriptCost:11; <>aTaxScriptCost; [TaxJurisdiction:14]taxRateCost:10; <>aTaxRateCost; [TaxJurisdiction:14]taxScriptOnShipping:17; <>aTaxScriptShipping; [TaxJurisdiction:14]taxRateOnShipping:16; <>aTaxRateShipping)
SORT ARRAY:C229(<>aTaxJuris; <>aTaxService; <>aTaxScriptSales; <>aTaxRateSales; <>aTaxScriptCost; <>aTaxRateCost; <>aTaxScriptShipping; <>aTaxRateShipping; >)
INSERT IN ARRAY:C227(<>aTaxJuris; 1; 1)
INSERT IN ARRAY:C227(<>aTaxService; 1; 1)
INSERT IN ARRAY:C227(<>aTaxScriptSales; 1; 1)
INSERT IN ARRAY:C227(<>aTaxRateSales; 1; 1)
INSERT IN ARRAY:C227(<>aTaxScriptCost; 1; 1)
INSERT IN ARRAY:C227(<>aTaxRateCost; 1; 1)
INSERT IN ARRAY:C227(<>aTaxScriptShipping; 1; 1)
INSERT IN ARRAY:C227(<>aTaxRateShipping; 1; 1)
<>aTaxJuris{1}:="Tax Juris"
<>aTaxJuris:=1
READ WRITE:C146([TaxJurisdiction:14])
USE SET:C118("Current")
CLEAR SET:C117("Current")
UNLOAD RECORD:C212([TaxJurisdiction:14])

ARRAY TEXT:C222(<>aLinetaxID; 4)
<>aLinetaxID{1}:="Tax"
<>aLinetaxID{2}:="NoTax"
<>aLinetaxID{3}:="DoTax"
<>aLinetaxID{4}:="ItemRecord"
