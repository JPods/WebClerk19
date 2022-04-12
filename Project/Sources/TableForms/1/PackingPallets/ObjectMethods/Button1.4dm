// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/11/11, 14:00:10
// ----------------------------------------------------
// Method: Object Method: b1
// Description
// 
//
// Parameters
// ----------------------------------------------------
//Open Button Pallet Window

QUERY:C277([LoadTag:88]; [LoadTag:88]containerType:26>1; *)
QUERY:C277([LoadTag:88];  & [LoadTag:88]complete:36<2; *)
If (b3=0)
	QUERY:C277([LoadTag:88];  & [LoadTag:88]customerID:23=iLoText1; *)
End if 
QUERY:C277([LoadTag:88])
PKArrayManage22(Records in selection:C76([LoadTag:88]))  //###_jwm_###
//  --  CHOPPED  AL_UpdateArrays(ePalletList; -2)

QUERY:C277([LoadTag:88]; [LoadTag:88]containerType:26<2; *)
QUERY:C277([LoadTag:88];  & [LoadTag:88]complete:36<2; *)
If (b3=0)
	QUERY:C277([LoadTag:88];  & [LoadTag:88]customerID:23=iLoText1; *)
End if 
QUERY:C277([LoadTag:88])
PKArrayManage(Records in selection:C76([LoadTag:88]))
//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
