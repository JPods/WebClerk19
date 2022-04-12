If (False:C215)
	//Date: 03/14/02
	//Who: Dan Bentson, Arkware
	//Description: Added base quantity, tally
	VERSION_960
End if 


C_LONGINT:C283(bOmit)
If ((Size of array:C274(aFCRecNum)>0) & (Size of array:C274(aFCSelect)>0))
	Ray_OmitSubSet(->aFCSelect; ->aFCRecNum; ->aFCItem; ->aFCBomCnt; ->aFCActionDt; ->aFCBomLevel; ->aFCParent; ->aFCTypeTran; ->aFCDocID; ->aFCDesc; ->aFCRunQty; ->aFCWho; ->aFCBaseQty; ->aFCTallyYTD; ->aFCTallyLess1Year; ->aFCTallyLess2Year)
	doSearch:=6
End if   //first element is the sizing array, second element is the controlling array