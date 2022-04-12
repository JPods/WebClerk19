//%attributes = {}
// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-01-14T00:00:00, 22:55:23
// ----------------------------------------------------
// Method: FixOrderLineItemNum
// Description
// Modified: 01/14/15
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------




If (Size of array:C274(aRayLines)>0)
	iloText1:=Request:C163("Enter desired Item Number to replace "+pPartNum)
	If ((iloText1#"") & (OK=1))
		pPartNum:=iloText1
		aOItemNum{aRayLines{1}}:=iloText1
		QUERY:C277([OrderLine:49]; [OrderLine:49]idNum:50=aoUniqueID{aRayLines{1}})
		[OrderLine:49]itemNum:4:=iloText1
		SAVE RECORD:C53([OrderLine:49])
		UNLOAD RECORD:C212([OrderLine:49])
		//  --  CHOPPED  AL_UpdateArrays(eOrdList; -2)
	End if 
End if 
