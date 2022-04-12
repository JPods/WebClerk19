//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/02/11, 00:13:07
// ----------------------------------------------------
// Method: P_PpHeader
// Description
// 
//
// Parameters
// ----------------------------------------------------

//   Alert("page: "+string(vPageCurrent)+", line: "+string(vPrintBodyCount))
C_LONGINT:C283(vPageCurrent)
C_LONGINT:C283(vPagesTotal)
If (vPageCurrent>0)
	vPageCurrent:=vPageCurrent+1
Else 
	vPrintBodyCounter:=0
	vPageCurrent:=1
	P_InitPrintCnt
	P_ClearVars  //### jwm ### 20120920_0914  added from CE2010zjn
	//  P_PpHeadVars 
	If (ptCurTable=(->[UserReport:46]))
		P_SetBodyCount
	End if 
	PpLnFillRays(Records in selection:C76([ProposalLine:43]))
	
	SORT ARRAY:C229(aPSeq; aPLocation; aPItemNum; aPAltItem; aPQtyOrder; aPDescpt; aPUse; aPUnitPrice; aPDiscnt; aPExtPrice; aPTaxable; aPSaleTax; aPUnitWt; aPExtWt; aPUnitCost; aPExtCost; aPRepRate; aPRepComm; aPSalesRate; aPSaleComm; aPLeadTime; aPUnitMeas; aPSerial; aPPricePt; aPProfile1; aPProfile2; aPProfile3; aPPrintThis)
End if 



If (False:C215)
	QUERY:C277([ProposalLine:43]; [ProposalLine:43]idNumProposal:1=[Proposal:42]idNum:5; *)
	If ([UserReport:46]printNot:30=1)
		QUERY:C277([ProposalLine:43];  & [ProposalLine:43]printNot:54=0; *)
	End if 
	QUERY:C277([ProposalLine:43])
End if 
