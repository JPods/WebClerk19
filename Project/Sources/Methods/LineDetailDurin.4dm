//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/08/13, 01:11:19
// ----------------------------------------------------
// Method: LineDetailDurin
// Description
// 
//
// Parameters
// ----------------------------------------------------
//// Modified by: williamjames (130308)
C_REAL:C285(pTaxCost; pSalesTax)
If (ptCurTable=(->[Invoice:26]))
	$QtyCalc:=pQtyShip
	Case of 
		: ([Invoice:26]country:13="USA")
			pvCountry:="US"
		: ([Invoice:26]country:13="")
			pvCountry:="US"
		Else 
			pvCountry:=[Invoice:26]country:13
	End case 
Else   //(curFile=File([Order])) or POs
	Case of 
		: ([Order:3]country:21="USA")
			pvCountry:="US"
		: ([Order:3]country:21="")
			pvCountry:="US"
		Else 
			pvCountry:=[Order:3]country:21
	End case 
	$QtyCalc:=pQtyOrd
End if 
pFrght:=Round:C94(pUtWt*$QtyCalc; 4)
pDscntPrice:=DiscountApply(pUnitPrice; pDiscnt; <>tcDecimalUP)
pExtPrice:=Round:C94($QtyCalc*pDscntPrice; <>tcDecimalTt)
pExtCost:=Round:C94($QtyCalc*pUnitCost; <>tcDecimalTt)
If (pUnitPrice=0)
	pDiscountFactor:=100
Else 
	pDiscountFactor:=Round:C94(pUnitCost/pUnitPrice*100; 2)
End if 
If (<>vldoTaxWeb<1)
	pSalesTax:=Round:C94(Num:C11(ptaxID#"")*pExtPrice*sTaxRate; <>tcDecimalTt)
	
	Case of 
		: (ptCurTable=(->[Order:3]))
			TaxCalcLine(->[Order:3]taxJuris:43; [Order:3]taxExemptid:122; ptaxID; pExtPrice; pExtCost; 2; <>tcDecimalTt; ->pSalesTax; ->pTaxCost)
			
		: (ptCurTable=(->[Invoice:26]))
			TaxCalcLine(->[Invoice:26]taxJuris:33; [Invoice:26]taxExemptid:91; ptaxID; pExtPrice; pExtCost; 2; <>tcDecimalTt; ->pSalesTax; ->pTaxCost)
			
		: (ptCurTable=(->[Proposal:42]))
			TaxCalcLine(->[Proposal:42]taxJuris:33; [Proposal:42]taxExemptid:83; ptaxID; pExtPrice; pExtCost; 2; <>tcDecimalTt; ->pSalesTax; ->pTaxCost)
			//TaxCalcLine (->[Proposal]TaxJuris;[Customer]TaxExemptID;aOTaxable{$1};aOExtPrice{$1};aOExtCost{$1};$1;$thePrec;->aOSaleTax{$1};->aOTaxCost{$1})
	End case 
	
Else 
	Case of 
		: ([Order:3]country:21="USA")
			pvCountry:="US"
		: ([Order:3]country:21="")
			pvCountry:="US"
		Else 
			pvCountry:=[Order:3]country:21
	End case 
	pvTransDate:=String:C10(Month of:C24(Current date:C33))+"/"+String:C10(Year of:C25(Current date:C33))
	pvTransDateTime:=String:C10(Year of:C25(Current date:C33); "0000")+"-"+String:C10(Month of:C24(Current date:C33); "00")+"-"+String:C10(Day of:C23(Current date:C33); "00")+"T"+String:C10(Current time:C178; 1)+".981Z"
	
	
	TaxWebService
	pProfile1:=pvLnProfile1
	Profile2:=pvLnProfile2
	Profile3:=pvTaxRate
	pSalesTax:=Num:C11(pvTax)
	
End if 
PriceBelowMargi(->pUnitPrice; ->pUnitCost; ->pPartNum)
MarginCalc(->pExtPrice; ->pExtCost; ->pGrossMar; ->pGross)



CM_LineCalc(<>tcSaleMar; -1; ->pExtPrice; ->pExtCost; ->pCommSpc; ->pCommSales; ->pQtyOrd)
CM_LineCalc(<>tcSaleMar; -1; ->pExtPrice; ->pExtCost; ->pCommRpc; ->pCommRep; ->pQtyOrd)
//
C_REAL:C285(vRealCal1; pGrossMarAfter; pGrossPCAfter)
vRealCal1:=pExtCost+pCommSales+pCommRep
MarginCalc(->pExtPrice; ->vRealCal1; ->pGrossMarAfter; ->pGrossPCAfter)
//// Modified by: williamjames (130308)
PO_LnRtnValueWa(0; 0; ->pPartNum)

