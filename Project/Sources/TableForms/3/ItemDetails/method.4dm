Case of 
	: (Before:C29)
		C_LONGINT:C283(pSeq)
		C_REAL:C285(pDscntPrice; pDiscountFactor)
		C_LONGINT:C283(vDiffDays1; vDiffDays2)
		C_REAL:C285(pQtyPO; pQtySO)
		
		myOK:=0
		<>aPrecDis:=3
		C_LONGINT:C283($w)
		
		$w:=Find in array:C230(<>aExecuteNames; "3_ItemDetails")
		If ($w>0)
			ExecuteText(0; <>aExecuteScripts{$w})
		End if 
		Move_SetPvNxBut(ptLineRec)
		MarginCalc(->pExtPrice; ->pExtCost; ->pGrossMar; ->pGross)
		pDscntPrice:=DiscountApply(pUnitPrice; pDiscnt; <>tcDecimalUP)
		C_REAL:C285(vRealCal1; pGrossMarAfter; pGrossPCAfter)
		vRealCal1:=pExtCost+pCommSales+pCommRep
		MarginCalc(->pExtPrice; ->vRealCal1; ->pGrossMarAfter; ->pGrossPCAfter)
		If (pUnitPrice=0)
			pDiscountFactor:=100
		Else 
			pDiscountFactor:=Round:C94(pUnitCost/pUnitPrice*100; 2)
		End if 
		C_BOOLEAN:C305($doDate)
		$doDate:=(ptCurTable=(->[Order:3]))
		$dateOrdd:=1
		OBJECT SET ENTERABLE:C238(vLnDate1; $doDate)
		OBJECT SET ENTERABLE:C238(vLnDate2; $doDate)
		OBJECT SET ENTERABLE:C238(vLnDate3; $doDate)
		OBJECT SET ENTERABLE:C238(vDiffDays1; $doDate)
		If (Not:C34($doDate))
			vLnDate1:=!00-00-00!
			vLnDate2:=!00-00-00!
			vLnDate3:=!00-00-00!
		End if 
		
		vDiffDays1:=vLnDate2-vLnDate1
		//    
		
		Case of 
			: (ptCurTable=(->[Order:3]))
				//pShipOrdSt:=""
				//SET ENTERABLE(pShipOrdSt;False)
				C_LONGINT:C283($w)
				$w:=Find in array:C230(<>aTypeSale; pPricePt)
				If ($w>0)
					<>aTypeSale:=$w
				Else 
					<>aTypeSale:=1
				End if 
			: (ptCurTable=(->[Invoice:26]))
				$lockFields:=(([Invoice:26]jrnlComplete:48=False:C215) & (changeInvLines))
				OBJECT SET ENTERABLE:C238(pQtyOrd; $lockFields)
				//SET ENTERABLE(pQtyShip;$lockFields)
				//SET ENTERABLE(pQtyBL;$lockFields)
				OBJECT SET ENTERABLE:C238(pUtWt; $lockFields)
				OBJECT SET ENTERABLE:C238(pUnitMeas; $lockFields)
				OBJECT SET ENTERABLE:C238(pLocation; $lockFields)
				OBJECT SET ENTERABLE:C238(pUnitPrice; $lockFields)
				OBJECT SET ENTERABLE:C238(pDiscnt; $lockFields)
				OBJECT SET ENTERABLE:C238(pDscntPrice; $lockFields)
				OBJECT SET ENTERABLE:C238(pUnitCost; $lockFields)
				OBJECT SET ENTERABLE:C238(ptaxID; $lockFields)
				OBJECT SET ENTERABLE:C238(pSalesTax; $lockFields)
				OBJECT SET ENTERABLE:C238(pTaxCost; $lockFields)
				
		End case 
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
		LineItemPrintManage(1; pPrintThis)
		//// Modified by: williamjames (130308)
		PO_LnRtnValueWa(0; 0; ->pPartNum)
		
	: (Outside call:C328)
		Prs_OutsideCall
		
	Else 
		LineDetailDurin
		If ((vLnDate3=!00-00-00!) | (vLnDate3=!1901-01-01!))
			vDiffDays2:=0
		Else 
			vDiffDays2:=vLnDate3-vLnDate2
		End if 
End case 