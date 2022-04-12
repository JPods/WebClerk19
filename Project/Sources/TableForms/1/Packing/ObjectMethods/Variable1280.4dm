iLoText1:=""  //clear any existing error message
QUERY:C277([Order:3]; [Order:3]idNum:2=srSO)
If (Records in selection:C76([Order:3])=1)
	//TRACE
	OrdLineALDefine(eOrdList)
	OrdLnFillRays
	//QUERY([OrdLine];[OrdLine]OrderNum=[Order]OrderNum)  
	C_LONGINT:C283($i; $k)
	For ($i; 1; $k)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=aOItemNum{$i})
		aOBackLog{$i}:=[Item:4]qtyOnHand:14
	End for 
	REDUCE SELECTION:C351([Item:4]; 0)
	
	//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
Else 
	BEEP:C151
	BEEP:C151
End if 
