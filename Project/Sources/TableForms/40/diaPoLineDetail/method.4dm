// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/08/13, 01:06:31
// ----------------------------------------------------
// Method: Form Method: diaPoLineDetail
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_REAL:C285(vrOrgQtyShp; pVaTax; pNonPCost; pSalesTax)
Case of 
	: (Before:C29)
		DetailFormat(<>aPrecDis)
		Move_SetPvNxBut(->aPOLineAction)
		vrOrgQtyShp:=pQtyShip
		pDscntPrice:=DiscountApply(pUnitPrice; pDiscnt; <>tcDecimalUC)
		If ((<>vbDoSrlNums) & (pSerialized#<>ciSRNotSerialized))
			vsSerialChk:="x"
		Else 
			vsSerialChk:=""
		End if 
		pLandTotal:=pExtPrice+pSalesTax+pNonPCost
		If (pQtyOrd#0)
			pLandUnit:=Round:C94(pLandTotal/pQtyOrd; <>tcDecimalUC)
		Else 
			pLandUnit:=pTotalCost
		End if 
		//// Modified by: williamjames (130308)
		PO_LnRtnValueWa(pQtyShip; pUnitPrice; ->pPartNum)
		
	Else 
		//    pQtyBL:=pQtyOrd-pQtyShip
		If (doSearch>0)
			//// Modified by: williamjames (130308)
			If ((pQtyShip<0) | (pQtyOrd<0))
				
			End if 
			PO_LnRtnValueWa(pQtyShip; pUnitPrice; ->pPartNum)
			doSearch:=0
		End if 
		pDscntPrice:=DiscountApply(pUnitPrice; pDiscnt; <>tcDecimalUC)
		pExtPrice:=Round:C94(pQtyOrd*pDscntPrice; <>tcDecimalTt)
		pLandTotal:=pExtPrice+pSalesTax+pNonPCost+pVaTax
		pExtWt:=pUnWt*pQtyOrd
		// recalc discount
		//pdiscnt:=pUnitPrice-pDscntPrice/pUnitPrice*100
		
		If (pQtyOrd#0)
			pLandUnit:=Round:C94(pLandTotal/pQtyOrd; <>tcDecimalUC)
		Else 
			pLandUnit:=pTotalCost
		End if 
End case 