//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $i; $2)
$i:=0
Case of 
	: ($1=0)
		SELECTION TO ARRAY:C260([Order:3]orderNum:2; aOrdNum; [Order:3]flow:134; aOrdFlow; [Order:3]customerPO:3; aOrdCustPO; [Order:3]mfrOrdNum:51; aOrdMfgOrd; [Order:3]mfrid:52; aOrdMfgAcct; [Order:3]customerID:1; aOrdCustAcc; [Order:3]company:15; aOrdCustCo; [Order:3]repID:8; aOrdCustRep)
		SELECTION TO ARRAY:C260([Order:3]total:27; aOrdTotal; [Order:3]amountBackLog:54; aOrdAmt; [Order:3]dateNeeded:5; aOrdDtNeed; [Order:3]dateCancel:53; aOrdCancel; [Order:3]dateInvoiceComp:6; aOrdDtCmp; [Order:3]; aOrdRecNum)
		UNLOAD RECORD:C212([Order:3])
End case 
//OrdOutRayInit  //was in the **Post but not the 3.8 version.