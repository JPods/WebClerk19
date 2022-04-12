TRACE:C157
QUERY:C277([POReceipt:95]; [POReceipt:95]vendorInvoiceNum:4#""; *)
QUERY:C277([POReceipt:95];  & [POReceipt:95]jrnlComplete:8=False:C215)
PoReceiptFillRay(Records in selection:C76([POReceipt:95]))
//  --  CHOPPED  AL_UpdateArrays(eReceipts; -2)

PoLnFillRays(0)
REDUCE SELECTION:C351([PO:39]; 0)
PoArrayManage(-5)
POALDefine
// -- AL_SetRowOpts(ePOs; 0; 0; 0; 0; 1)  //reset this item.
//  CHOPPED  POLineALDefine(ePoLines)

// -- AL_SetHdrStyle(ePoLines; 1; "Geneva"; 9; 2)  //Item Number
// -- AL_SetWidths(ePoLines; 1; 12; 80; 3; 43; 43; 35; 17; 17; 380; 58; 28; 3; 72)
//  --  CHOPPED  AL_UpdateArrays(ePoLines; -2)
//
Try_AdjRayFill(0)
Try_AdjALDefine(eShipAdj)



//If (vMod)
//If ((vlReceiptID#0)|(haveReceiptID))
//haveReceiptID:=True
//booAccept:=True
//TRACE
//vlReceiptID:=PORcpt_CreateNew ([PO]PONum;[PO]VendorID;True)
//vbSpreadFreight:=False
//End if 
//If (vbSpreadFreight)
//
//Else 
//CREATE RECORD([InvStack])
//
//[InvStack]ItemNum:="FreightPO"
//[InvStack]UnitCost:=1
//[InvStack]ReceiptID:=[POReceipt]ReceiptID
//[InvStack]QtyOnHand:=1
//[InvStack]ExtendedCost:=[POReceipt]VendorInvoiceFreight
//[InvStack]VendorID:=[POReceipt]VendorID
//[InvStack]DateEntered:=[POReceipt]VendorInvoiceDate
//[InvStack]DocID:=[POReceipt]PONum
//[InvStack]DateVendorInvc:=[POReceipt]VendorInvoiceDate
//SAVE RECORD([InvStack])
//End if 
//C_BOOLEAN(haveReceiptID)
//haveReceiptID:=(vlReceiptID>0)
//acceptPO 
//
//haveReceiptID:=False
//vMod:=False
//End if 

