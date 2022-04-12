//%attributes = {"publishedWeb":true}
If (aPLineAction>0)
	ptLineRec:=->aPLineAction
	//Ray_RayLoadVar (aPLineAction;aPItemNum;pPartNum;aPAltItem;pAltItem
	//;aPDescpt;pDescript;aPQtyOrder;pQtyOrd;aPLeadTime;vi2;aPUnitWt
	//;pUtWt)
	//Ray_RayLoadVar (aPLineAction;aPExtWt;pFrght;aPLocation;pLocation
	//;aPUnitPrice;pUnitPrice;aPDiscnt;pDiscnt;aPExtPrice;pExtPrice
	//;aPSaleTax;pSalesTax)
	//Ray_RayLoadVar (aPLineAction;aPUnitMeas;pUnitMeas;aPTaxable;pbooTaxable
	//;aPUnitCost;pUnitCost;aPExtCost;pExtCost;aPSalesRate;pCommSPC)
	//Ray_RayLoadVar (aPLineAction;aPRepRate;pCommRPC;aPSaleComm;pCommSales
	//;aPRepComm;pCommRep;aPProdBy;pProdBy;aPLnComment;pComment)
	//Ray_RayLoadVar (aPLineAction;aPProfile1;pProfile1;aPProfile2;pProfile2
	//;aPProfile3;pProfile3;aPDateExp;vDate1)
	jCenterWindow(520; 510; 1)  //(452;204;1)
	DIALOG:C40([ProposalLine:43]; "diaPLineDetails")
	CLOSE WINDOW:C154
	
	// Modified by: William James (2014-04-02T00:00:00 Subrecord eliminated)
	// replace this with Pp_VarRay
	If (myOK=1)
		Ray_VarLoadRay(aPLineAction; ->aPItemNum; ->pPartNum; ->aPAltItem; ->pAltItem; ->aPDescpt; ->pDescript; ->aPQtyOrder; ->pQtyOrd; ->aPLeadTime; ->vi2; ->aPUnitWt; ->pUtWt)
		Ray_VarLoadRay(aPLineAction; ->aPExtWt; ->pFrght; ->aPLocation; ->pLocation; ->aPUnitPrice; ->pUnitPrice; ->aPDiscnt; ->pDiscnt; ->aPExtPrice; ->pExtPrice; ->aPSaleTax; ->pSalesTax)
		Ray_VarLoadRay(aPLineAction; ->aPUnitMeas; ->pUnitMeas; ->aPTaxable; ->ptaxID; ->aPUnitCost; ->pUnitCost; ->aPExtCost; ->pExtCost; ->aPSalesRate; ->pCommSPC)
		Ray_VarLoadRay(aPLineAction; ->aPRepRate; ->pCommRPC; ->aPSaleComm; ->pCommSales; ->aPRepComm; ->pCommRep; ->aPProdBy; ->pProdBy; ->aPLnComment; ->pComment)
		Ray_VarLoadRay(aPLineAction; ->aPProfile1; ->pProfile1; ->aPProfile2; ->pProfile2; ->aPProfile3; ->pProfile3; ->aPDateExp; ->vDate1; ->aPSeq; ->pSeq)
		Ray_VarLoadRay(aPLineAction; ->apTaxCost; ->pCostTax; ->apPrintThis; ->pPrintThis; ->apLocationBin; ->pLocationBin)
		vLineMod:=True:C214
		vMod:=True:C214
		//   invMod:=True
	Else 
		Ray_RayLoadVar(aPLineAction; ->aPItemNum; ->pPartNum; ->aPAltItem; ->pAltItem; ->aPDescpt; ->pDescript; ->aPQtyOrder; ->pQtyOrd; ->aPLeadTime; ->vi2; ->aPUnitWt; ->pUtWt)
		Ray_RayLoadVar(aPLineAction; ->aPExtWt; ->pFrght; ->aPLocation; ->pLocation; ->aPUnitPrice; ->pUnitPrice; ->aPDiscnt; ->pDiscnt; ->aPExtPrice; ->pExtPrice; ->aPSaleTax; ->pSalesTax)
		Ray_RayLoadVar(aPLineAction; ->aPUnitMeas; ->pUnitMeas; ->aPTaxable; ->ptaxID; ->aPUnitCost; ->pUnitCost; ->aPExtCost; ->pExtCost; ->aPSalesRate; ->pCommSPC)
		Ray_RayLoadVar(aPLineAction; ->aPRepRate; ->pCommRPC; ->aPSaleComm; ->pCommSales; ->aPRepComm; ->pCommRep; ->aPProdBy; ->pProdBy; ->aPLnComment; ->pComment)
		Ray_RayLoadVar(aPLineAction; ->aPProfile1; ->pProfile1; ->aPProfile2; ->pProfile2; ->aPProfile3; ->pProfile3; ->aPDateExp; ->vDate1; ->aPSeq; ->pSeq)
		Ray_RayLoadVar(aPLineAction; ->apTaxCost; ->pCostTax; ->apPrintThis; ->pPrintThis; ->apLocationBin; ->pLocationBin)
		//Ray_RayLoadVar (aPLineAction;->aPQtyOrder;->pQtyOrd;->aPItemNum;->pPartNum;->aPDescpt;->pDescript;->aPUnitPrice;->pUnitPrice;->aPDiscnt;->pDiscnt;->aPExtPrice;->pExtPrice)
	End if 
	vLineMod:=True:C214
	jNxPvButtonSet
Else 
	jAlertMessage(9209)
End if 