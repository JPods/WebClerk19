Case of 
	: (Before:C29)
		C_LONGINT:C283(pSeq)
		myOK:=0
		<>aPrecDis:=3
		Move_SetPvNxBut(->aPLineAction)
		$doChange:=UserInPassWordGroup("ViewCommission")
		If (Not:C34($doChange))
			C_LONGINT:C283($theColor)
			$theColor:=14
			_O_OBJECT SET COLOR:C271(pGrossMarAfter; -$theColor+(256*$theColor))
			_O_OBJECT SET COLOR:C271(pGrossPCAfter; -$theColor+(256*$theColor))
			_O_OBJECT SET COLOR:C271(pCommSales; -$theColor+(256*$theColor))
			_O_OBJECT SET COLOR:C271(pCommRep; -$theColor+(256*$theColor))
			_O_OBJECT SET COLOR:C271(pCommSPC; -$theColor+(256*$theColor))
			_O_OBJECT SET COLOR:C271(pCommRPC; -$theColor+(256*$theColor))
		End if 
		Pp_VarRay(False:C215)
		pDscntPrice:=DiscountApply(pUnitPrice; pDiscnt; <>tcDecimalUP)
		MarginCalc(->pExtPrice; ->pExtCost; ->pGrossMar; ->pGross)
		C_REAL:C285(vRealCal1; pGrossMarAfter; pGrossPCAfter)
		vRealCal1:=pExtCost+pCommSales+pCommRep
		MarginCalc(->pExtPrice; ->vRealCal1; ->pGrossMarAfter; ->pGrossPCAfter)
		//
		If (pUnitPrice=0)
			pDiscountFactor:=100
		Else 
			pDiscountFactor:=Round:C94((pUnitCost/pUnitPrice)*100; 2)
		End if 
		LineItemPrintManage(1; pPrintThis)
	Else 
		LineDetailDurin
End case 