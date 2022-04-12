//srSO:=iBoxSO

QUERY:C277([LoadTag:88]; [LoadTag:88]idNumOrder:29=iBoxSo; *)
QUERY:C277([LoadTag:88]; [LoadTag:88]containerType:26<2; *)
If (b3=0)
	QUERY:C277([LoadTag:88]; [LoadTag:88]customerID:23=iLoText1; *)
End if 
QUERY:C277([LoadTag:88])

PKArrayManage(Records in selection:C76([LoadTag:88]))
//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)