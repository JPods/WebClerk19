//%attributes = {"publishedWeb":true}
C_LONGINT:C283(viPOLnCnt; $1)
If ($1=0)
	POLn_RaySize(0; 0; 0)  //size 0; element none; num elements none
Else 
	POLn_RaySize(2; 0; 0)
End if 
If (Size of array:C274(aPoSeq)>0)
	SORT ARRAY:C229(aPoSeq; aPOLnCmplt; aPOQtyNow; aPOQtyOrder; aPOQtyRcvd; aPOQtyBL; aPODescpt; aPOUnitCost; aPODiscnt; aPoDscntUP; aPOExtCost; aPOVATax; aPOTaxable; aPOUnitMeas; aPoUnitWt; aPoNPCosts; aPoDuties; aPOBackLog; aPOLineNum; aPODateExp; aPOOrdRef; aPODateRcvd; aPOSerialRc; aPOSerialNm; aPOVndrAlph; aPoItemNum; aPoPQBIR; aPOLineAction; aPOCustRef; aPoSiteRef; aPoLComment; aPoExtWt; aPoUniqueID; aPoHoldQty)
End if 