//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: UtilDocManageRays
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 

C_LONGINT:C283($1)
C_LONGINT:C283($1; $2; $3; $4; $5)
Case of 
	: ($1=0)
		HtPageRay(0)
	: ($1>0)
		//FC_FillArrays 
		//
		ARRAY LONGINT:C221(aFCSelect; 0)
	: ($1=-1)
		DELETE FROM ARRAY:C228(aFCItem; $2; $3)
		DELETE FROM ARRAY:C228(aFCDesc; $2; $3)
		DELETE FROM ARRAY:C228(aFCActionDt; $2; $3)
		DELETE FROM ARRAY:C228(aFCBomCnt; $2; $3)
		DELETE FROM ARRAY:C228(aFCRunQty; $2; $3)
		DELETE FROM ARRAY:C228(aFCBaseQty; $2; $3)
		DELETE FROM ARRAY:C228(aFCBomLevel; $2; $3)
		DELETE FROM ARRAY:C228(aFCParent; $2; $3)
		DELETE FROM ARRAY:C228(aFCTypeTran; $2; $3)
		DELETE FROM ARRAY:C228(aFCDocID; $2; $3)
		DELETE FROM ARRAY:C228(aFCRecNum; $2; $3)
		DELETE FROM ARRAY:C228(aFCWho; $2; $3)
		DELETE FROM ARRAY:C228(aFCtypeID; $2; $3)
		DELETE FROM ARRAY:C228(aFCTallyLess2Year; $2; $3)
		DELETE FROM ARRAY:C228(aFCTallyLess1Year; $2; $3)
		DELETE FROM ARRAY:C228(aFCTallyYTD; $2; $3)
		
	: ($1=-3)
		INSERT IN ARRAY:C227(aFCItem; $2; $3)
		INSERT IN ARRAY:C227(aFCDesc; $2; $3)
		INSERT IN ARRAY:C227(aFCActionDt; $2; $3)
		INSERT IN ARRAY:C227(aFCBomCnt; $2; $3)
		INSERT IN ARRAY:C227(aFCRunQty; $2; $3)
		INSERT IN ARRAY:C227(aFCBaseQty; $2; $3)
		INSERT IN ARRAY:C227(aFCBomLevel; $2; $3)
		INSERT IN ARRAY:C227(aFCParent; $2; $3)
		INSERT IN ARRAY:C227(aFCTypeTran; $2; $3)
		INSERT IN ARRAY:C227(aFCDocID; $2; $3)
		INSERT IN ARRAY:C227(aFCRecNum; $2; $3)
		INSERT IN ARRAY:C227(aFCWho; $2; $3)
		INSERT IN ARRAY:C227(aFCtypeID; $2; $3)
		INSERT IN ARRAY:C227(aFCTallyLess2Year; $2; $3)
		INSERT IN ARRAY:C227(aFCTallyLess1Year; $2; $3)
		INSERT IN ARRAY:C227(aFCTallyYTD; $2; $3)
	: ($1=-7)  //update element
		
End case 