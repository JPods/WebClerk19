// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/11/11, 13:57:31
// ----------------------------------------------------
// Method: Object Method: Invisible Button1
// Description
// 
//
// Parameters
// ----------------------------------------------------
//Invisible Button Search for Pallet by OrderNum

//srSO:=iPalletSO causes typing error

QUERY:C277([LoadTag:88]; [LoadTag:88]idNumOrder:29=iPalletSo; *)
QUERY:C277([LoadTag:88]; [LoadTag:88]containerType:26>1; *)
QUERY:C277([LoadTag:88])

PKArrayManage22(Records in selection:C76([LoadTag:88]))  //###_jwm_###
//  --  CHOPPED  AL_UpdateArrays(ePalletList; -2)