//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: PKContentsBox
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
//TRACE

Case of 
		
	: (Size of array:C274(aShipSel)<1)
		<>pkScaleComment:="Package Must be Selected"
	: (aPKContainerType{aShipSel{1}}<2)  //box
		//   TRACE
		QUERY:C277([LoadItem:87]; [LoadItem:87]idNumLoadTag:8=aPKUniqueID{aShipSel{1}})
		LT_FillArrayLoadItems(Records in selection:C76([LoadItem:87]))
		If (eLoadList>0)
			//  --  CHOPPED  AL_UpdateArrays(eLoadList; -2)
		End if 
	: (aPKContainerType{aShipSel{1}}=2)  //pallet
		
	: (aPKContainerType{aShipSel{1}}=3)  //container/truck
		
End case 