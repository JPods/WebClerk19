//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): jimmedlen
// Date and time: 03/19/13, 14:36:53
// ----------------------------------------------------
// Method: IVNT_dRayInit
// Description
// File: IVNT_dRayInit.txt
// Parameters
// ----------------------------------------------------

//### jwm ### 20130308_1643 changed dSite size from 4 to 40

REDUCE SELECTION:C351([DInventory:36]; 0)
ARRAY TEXT:C222(dItemNumKey; 0)
ARRAY REAL:C219(dQtyOnHand; 0)
ARRAY REAL:C219(dQtyOnSO; 0)
ARRAY REAL:C219(dQtyOnPO; 0)
ARRAY REAL:C219(dQtyOnWO; 0)
ARRAY REAL:C219(dQtyOnAdj; 0)
ARRAY REAL:C219(dUnitCost; 0)
ARRAY LONGINT:C221(dJobID; 0)
ARRAY LONGINT:C221(dDocID; 0)
ARRAY LONGINT:C221(dLineNum; 0)
ARRAY LONGINT:C221(dReceiptID; 0)
ARRAY TEXT:C222(dSource; 0)
ARRAY TEXT:C222(dReason; 0)
ARRAY TEXT:C222(dType; 0)
ARRAY LONGINT:C221(dDTCreated; 0)
ARRAY TEXT:C222(dNote; 0)
ARRAY LONGINT:C221(dTakeAction; 0)
ARRAY TEXT:C222(dSite; 0)  //### jwm ### 20130308_1643 changed dSite size from 4 to 40
ARRAY REAL:C219(dUnitPrice; 0)
ARRAY TEXT:C222(dChangeBy; 0)
ARRAY LONGINT:C221(dTableNum; 0)
//ARRAY LONGINT(dTableUniqueID;0)
//