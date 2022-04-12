If (False:C215)
	//Date: 03/14/02
	//Who: Dan Bentson, Arkware
	//Description: Added base quantity, tally
	VERSION_960
End if 

C_LONGINT:C283(bSelectLine)  //first element is the sizing array, second element is the controlling array
If (Size of array:C274(aFCSelect)>0)
	If (Size of array:C274(aFCRecNum)>0)
		Ray_ShowSubSet(->aFCSelect; ->aFCRecNum; ->aFCItem; ->aFCBomCnt; ->aFCActionDt; ->aFCBomLevel; ->aFCParent; ->aFCTypeTran; ->aFCDocID; ->aFCDesc; ->aFCRunQty; ->aFCWho; ->aFCBaseQty; ->aFCTallyYTD; ->aFCTallyLess1Year; ->aFCTallyLess2Year)
		Ray_SetSize(Size of array:C274(aFCSelect); ->aFCRecNum; ->aFCItem; ->aFCBomCnt; ->aFCActionDt; ->aFCBomLevel; ->aFCParent; ->aFCTypeTran; ->aFCDocID; ->aFCDesc; ->aFCRunQty; ->aFCWho; ->aFCBaseQty; ->aFCTallyYTD; ->aFCTallyLess1Year; ->aFCTallyLess2Year)
		doSearch:=6
	End if 
End if 