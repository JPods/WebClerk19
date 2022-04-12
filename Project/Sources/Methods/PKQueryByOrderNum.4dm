//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 12/14/06, 09:50:00
// ----------------------------------------------------
// Method: PKQueryByOrderNum
// Description
// 
//
// Parameters
// ----------------------------------------------------


iPalletSO:=0
iBoxSO:=0

CREATE EMPTY SET:C140([LoadTag:88]; "Current")
QUERY:C277([Order:3]; [Order:3]idNum:2=srSO)
If (Records in selection:C76([Order:3])=1)
	iLoText1:=[Order:3]customerID:1
	iLoText2:=[Order:3]company:15
	
	If (b3=1)  //ignore checkbox ###_jwm_###
		QUERY:C277([LoadTag:88]; [LoadTag:88]containerType:26>1; *)
		QUERY:C277([LoadTag:88];  & [LoadTag:88]documentID:17=srSO)
	Else 
		QUERY:C277([LoadTag:88]; [LoadTag:88]containerType:26>1; *)
		QUERY:C277([LoadTag:88];  & [LoadTag:88]complete:36<2; *)
		QUERY:C277([LoadTag:88];  & [LoadTag:88]documentID:17=srSO)
	End if 
	
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76([LoadTag:88])
	If ($k>0)
		FIRST RECORD:C50([LoadTag:88])
		For ($i; 1; $k)
			ADD TO SET:C119([LoadTag:88]; "Current")
			NEXT RECORD:C51([LoadTag:88])
		End for 
	End if 
	
	If (b3=1)  //ignore checkbox ###_jwm_###
		QUERY:C277([LoadTag:88]; [LoadTag:88]containerType:26>1; *)
		QUERY:C277([LoadTag:88];  & [LoadTag:88]customerID:23=[Order:3]customerID:1)
	Else 
		QUERY:C277([LoadTag:88]; [LoadTag:88]containerType:26>1; *)
		QUERY:C277([LoadTag:88];  & [LoadTag:88]complete:36<2; *)
		QUERY:C277([LoadTag:88];  & [LoadTag:88]customerID:23=[Order:3]customerID:1)
	End if 
	
	$k:=Records in selection:C76([LoadTag:88])
	If ($k>0)
		FIRST RECORD:C50([LoadTag:88])
		For ($i; 1; $k)
			ADD TO SET:C119([LoadTag:88]; "Current")
			NEXT RECORD:C51([LoadTag:88])
		End for 
	End if 
	USE SET:C118("Current")
	CLEAR SET:C117("Current")
	PKArrayManage22(Records in selection:C76([LoadTag:88]))
	//  --  CHOPPED  AL_UpdateArrays(ePalletList; -2)
	
	QUERY:C277([LoadTag:88]; [LoadTag:88]containerType:26<2; *)
	QUERY:C277([LoadTag:88];  & [LoadTag:88]documentID:17=srSO)
	PKArrayManage(Records in selection:C76([LoadTag:88]))
	//  --  CHOPPED  AL_UpdateArrays(eShipList; -2)
Else 
	ALERT:C41("No valid order")
End if 