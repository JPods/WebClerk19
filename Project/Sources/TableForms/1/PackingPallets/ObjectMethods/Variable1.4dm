// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/11/11, 13:58:53
// ----------------------------------------------------
// Method: Object Method: iLoText1
// Description
// 
//
// Parameters
// ----------------------------------------------------
//customerID Pallet Window

//iPalletSO:=0
//iBoxSO:=0
READ ONLY:C145([Customer:2])
READ ONLY:C145([Contact:13])
QUERY:C277([Customer:2]; [Customer:2]customerID:1=iLoText1)
If (Records in selection:C76([Customer:2])=1)
	If ([Customer:2]contactBillTo:92>0)
		QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Customer:2]contactBillTo:92)
		iLoText3:=[Contact:13]company:23
	Else 
		iLoText3:=[Customer:2]company:2
	End if 
	If ([Customer:2]contactShipTo:93>0)
		QUERY:C277([Contact:13]; [Contact:13]idNum:28=[Customer:2]contactShipTo:93)
		iLoText2:=[Contact:13]company:23
	Else 
		iLoText2:=[Customer:2]company:2
	End if 
End if 

QUERY:C277([LoadTag:88]; [LoadTag:88]customerID:23=iLoText1; *)
QUERY:C277([LoadTag:88]; [LoadTag:88]containerType:26>1; *)
If (b3=0)
	QUERY:C277([LoadTag:88]; [LoadTag:88]complete:36<2; *)
End if 

QUERY:C277([LoadTag:88])

PKArrayManage22(Records in selection:C76([LoadTag:88]))  //###_jwm_###
//  --  CHOPPED  AL_UpdateArrays(ePalletList; -2)

QUERY:C277([LoadTag:88]; [LoadTag:88]customerID:23=iLoText1; *)
QUERY:C277([LoadTag:88]; [LoadTag:88]containerType:26<2; *)
If (b3=0)
	QUERY:C277([LoadTag:88]; [LoadTag:88]complete:36<2; *)
End if 
QUERY:C277([LoadTag:88])

PKArrayManage(Records in selection:C76([LoadTag:88]))
//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)