//%attributes = {}
// ----------------------------------------------------
// User name (OS): jmedlen
// Date and time: 09/22/09, 10:34:58
// ----------------------------------------------------
// Method: BOM_CostMatrix
// Description
// Procedure for BOM Cost Matrix Button
//
// Parameters
// ----------------------------------------------------

If (bExtendedBOM=0)
	//SEARCH([BOM];[BOM]ItemNum=[Item]ItemNum)
	//Bom_FillArray (Records in selection([BOM]))
	Bom_CostItems
Else 
	//Bom_FillArray (0)
	//BOM_BuildExtend ([Item]ItemNum)
	Bom_CostItems
	C_REAL:C285($totalCost)
	BOM_ExtendCost(0)
	OBJECT SET FORMAT:C236(vrBOMCostLast; <>tcFormatUC)
	OBJECT SET FORMAT:C236(vrBOMCostStandard; <>tcFormatUC)
End if 
//  --  CHOPPED  AL_UpdateArrays(eBOMList; -2)

IVNT_dRayInit