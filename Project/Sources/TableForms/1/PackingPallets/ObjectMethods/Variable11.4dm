// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/11/11, 13:58:22
// ----------------------------------------------------
// Method: Object Method: iPalletSO
// Description
// 
//
// Parameters
// ----------------------------------------------------
//Search forPallet by OrderNum

//srSO:=iPalletSO causes typing error

QUERY:C277([LoadTag:88]; [LoadTag:88]idNumOrder:29=iPalletSo; *)
QUERY:C277([LoadTag:88]; [LoadTag:88]containerType:26>1; *)
If (b3=0)
	QUERY:C277([LoadTag:88]; [LoadTag:88]customerID:23=iLoText1; *)
End if 
QUERY:C277([LoadTag:88])

PKArrayManage22(Records in selection:C76([LoadTag:88]))  //###_jwm_###
//  --  CHOPPED  AL_UpdateArrays(ePalletList; -2)