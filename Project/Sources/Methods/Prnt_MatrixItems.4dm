//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-17T00:00:00, 08:49:46
// ----------------------------------------------------
// Method: Prnt_MatrixItems
// Description
// Modified: 01/17/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------

// not called anywhere at this time
//  qqqqq

FC_FillRay(0)
Case of 
	: (ptCurTable=(->[Order:3]))
		//REDUCE SELECTION([POLine];0)
		REDUCE SELECTION:C351([ProposalLine:43]; 0)
		FC_FillArrays(0; 0; 0)  //No POs and No WOs; No expand BOM; by Ord
	: (ptCurTable=(->[PO:39]))
		//REDUCE SELECTION(Orders;0)
		REDUCE SELECTION:C351([ProposalLine:43]; 0)
		FC_FillArrays(0; 0; 0)  //No POs and No WOs; No expand BOM; by Ord
	: (ptCurTable=(->[Proposal:42]))
		//REDUCE SELECTION([POLine];0)
		//REDUCE SELECTION([PrpLine];0)
		FC_FillArrays(0; 0; 0)  //No POs and No WOs; No expand BOM; by Ord
	: (ptCurTable=(->[Invoice:26]))
		REDUCE SELECTION:C351([QQQPOLine:40]; 0)
		REDUCE SELECTION:C351([ProposalLine:43]; 0)
		FC_FillArrays(0; 0; 0)  //No POs and No WOs; No expand BOM; by Ord    
End case 
