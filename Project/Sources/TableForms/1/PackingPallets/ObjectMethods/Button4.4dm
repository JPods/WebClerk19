// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/20/06, 11:30:17
// ----------------------------------------------------
// Method: Object Method: b4
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($dtBegin; $dtEnd)
$dtBegin:=DateTime_Enter(iLoDate1; ?00:00:00?)
$dtEnd:=DateTime_Enter(iLoDate2; ?23:59:59?)
QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1#-111187483)
If (iLoText1#"")
	QUERY:C277([LoadTag:88];  & [LoadTag:88]customerID:23=iLoText1; *)
End if 

Case of 
	: (aTmp20Str4=1)
		QUERY:C277([LoadTag:88];  & [LoadTag:88]containerType:26>1; *)
		QUERY:C277([LoadTag:88];  & [LoadTag:88]dtShipOn:10>=$dtBegin; *)
		QUERY:C277([LoadTag:88];  & [LoadTag:88]dtShipOn:10<=$dtEnd)
		PKArrayManage22(Records in selection:C76([LoadTag:88]))
		//  --  CHOPPED  AL_UpdateArrays(ePalletList; -2)
		QUERY:C277([LoadTag:88]; [LoadTag:88]idNum:1#-111187483)
		If (iLoText1#"")
			QUERY:C277([LoadTag:88];  & [LoadTag:88]customerID:23=iLoText1; *)
		End if 
		QUERY:C277([LoadTag:88];  & [LoadTag:88]containerType:26=1; *)
		QUERY:C277([LoadTag:88];  & [LoadTag:88]dtShipOn:10>=$dtBegin; *)
		QUERY:C277([LoadTag:88];  & [LoadTag:88]dtShipOn:10<=$dtEnd)
		PKArrayManage(Records in selection:C76([LoadTag:88]))
		//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
	: (aTmp20Str4=2)
		QUERY:C277([LoadTag:88];  & [LoadTag:88]containerType:26>1; *)
		QUERY:C277([LoadTag:88];  & [LoadTag:88]dtShipOn:10>=$dtBegin; *)
		QUERY:C277([LoadTag:88];  & [LoadTag:88]dtShipOn:10<=$dtEnd)
		PKArrayManage22(Records in selection:C76([LoadTag:88]))
		//  --  CHOPPED  AL_UpdateArrays(ePalletList; -2)
	Else 
		QUERY:C277([LoadTag:88];  & [LoadTag:88]containerType:26=1; *)
		QUERY:C277([LoadTag:88];  & [LoadTag:88]dtShipOn:10>=$dtBegin; *)
		QUERY:C277([LoadTag:88];  & [LoadTag:88]dtShipOn:10<=$dtEnd)
		PKArrayManage(Records in selection:C76([LoadTag:88]))
		//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
End case 