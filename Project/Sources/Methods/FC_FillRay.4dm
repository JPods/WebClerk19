//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 04/10/07, 15:00:32
// ----------------------------------------------------
// Method: FC_FillRay
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1)
C_LONGINT:C283($1; $2; $3; $4; $5)
C_LONGINT:C283($i; $k)

Case of 
	: ($1=0)
		ARRAY TEXT:C222(aFCItem; 0)
		ARRAY TEXT:C222(aFCDesc; 0)
		ARRAY DATE:C224(aFCActionDt; 0)
		ARRAY REAL:C219(aFCBomCnt; 0)
		ARRAY REAL:C219(aFCRunQty; 0)
		ARRAY REAL:C219(aFCBaseQty; 0)
		ARRAY TEXT:C222(aFCBomLevel; 0)
		ARRAY TEXT:C222(aFCParent; 0)
		ARRAY TEXT:C222(aFCTypeTran; 0)
		ARRAY LONGINT:C221(aFCDocID; 0)
		ARRAY LONGINT:C221(aFCRecNum; 0)
		ARRAY TEXT:C222(aFCWho; 0)
		ARRAY TEXT:C222(aFCtypeID; 0)
		ARRAY REAL:C219(aFCTallyLess2Year; 0)
		ARRAY REAL:C219(aFCTallyLess1Year; 0)
		ARRAY REAL:C219(aFCTallyYTD; 0)
		//
		ARRAY LONGINT:C221(aFCSelect; 0)
	: ($1>0)
		//FC_FillArrays 
		ARRAY TEXT:C222(aFCItem; $1)
		ARRAY TEXT:C222(aFCDesc; $1)
		ARRAY DATE:C224(aFCActionDt; $1)
		ARRAY REAL:C219(aFCBomCnt; $1)
		ARRAY REAL:C219(aFCRunQty; $1)
		ARRAY REAL:C219(aFCBaseQty; $1)
		ARRAY TEXT:C222(aFCBomLevel; $1)
		ARRAY TEXT:C222(aFCParent; $1)
		ARRAY TEXT:C222(aFCTypeTran; $1)
		ARRAY LONGINT:C221(aFCDocID; $1)
		ARRAY LONGINT:C221(aFCRecNum; $1)
		ARRAY TEXT:C222(aFCWho; $1)
		ARRAY TEXT:C222(aFCtypeID; $1)
		ARRAY REAL:C219(aFCTallyLess2Year; $1)
		ARRAY REAL:C219(aFCTallyLess1Year; $1)
		ARRAY REAL:C219(aFCTallyYTD; $1)
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
	: ($1=-7)  //show subset
		$k:=Size of array:C274(aFCRecNum)
		If ((Size of array:C274(aFCSelect)>0) & ($k>0))
			For ($i; $k; 1; -1)
				If (Find in array:C230(aFCSelect; $i)<0)
					DELETE FROM ARRAY:C228(aFCItem; $i; 1)
					DELETE FROM ARRAY:C228(aFCDesc; $i; 1)
					DELETE FROM ARRAY:C228(aFCActionDt; $i; 1)
					DELETE FROM ARRAY:C228(aFCBomCnt; $i; 1)
					DELETE FROM ARRAY:C228(aFCRunQty; $i; 1)
					DELETE FROM ARRAY:C228(aFCBaseQty; $i; 1)
					DELETE FROM ARRAY:C228(aFCBomLevel; $i; 1)
					DELETE FROM ARRAY:C228(aFCParent; $i; 1)
					DELETE FROM ARRAY:C228(aFCTypeTran; $i; 1)
					DELETE FROM ARRAY:C228(aFCDocID; $i; 1)
					DELETE FROM ARRAY:C228(aFCRecNum; $i; 1)
					DELETE FROM ARRAY:C228(aFCWho; $i; 1)
					DELETE FROM ARRAY:C228(aFCtypeID; $i; 1)
					DELETE FROM ARRAY:C228(aFCTallyLess2Year; $i; 1)
					DELETE FROM ARRAY:C228(aFCTallyLess1Year; $i; 1)
					DELETE FROM ARRAY:C228(aFCTallyYTD; $i; 1)
				End if 
			End for 
		End if 
	: ($1=-9)  //omit subset
		
		$k:=Size of array:C274(aFCRecNum)
		If ((Size of array:C274(aFCSelect)>0) & ($k>0))
			For ($i; $k; 1; -1)
				If (Find in array:C230(aFCSelect; $i)>0)
					DELETE FROM ARRAY:C228(aFCItem; $i; 1)
					DELETE FROM ARRAY:C228(aFCDesc; $i; 1)
					DELETE FROM ARRAY:C228(aFCActionDt; $i; 1)
					DELETE FROM ARRAY:C228(aFCBomCnt; $i; 1)
					DELETE FROM ARRAY:C228(aFCRunQty; $i; 1)
					DELETE FROM ARRAY:C228(aFCBaseQty; $i; 1)
					DELETE FROM ARRAY:C228(aFCBomLevel; $i; 1)
					DELETE FROM ARRAY:C228(aFCParent; $i; 1)
					DELETE FROM ARRAY:C228(aFCTypeTran; $i; 1)
					DELETE FROM ARRAY:C228(aFCDocID; $i; 1)
					DELETE FROM ARRAY:C228(aFCRecNum; $i; 1)
					DELETE FROM ARRAY:C228(aFCWho; $i; 1)
					DELETE FROM ARRAY:C228(aFCtypeID; $i; 1)
					DELETE FROM ARRAY:C228(aFCTallyLess2Year; $i; 1)
					DELETE FROM ARRAY:C228(aFCTallyLess1Year; $i; 1)
					DELETE FROM ARRAY:C228(aFCTallyYTD; $i; 1)
				End if 
			End for 
		End if 
		
	: ($1=-8)  //sort arrays
		MULTI SORT ARRAY:C718(aFCItem; >; aFCActionDt; >; aFCDesc; aFCBOMCnt; aFCRunQty; aFCBaseQty; aFCBomLevel; aFCParent; aFCTypeTran; aFCDocID; aFCRecNum; aFCWho; aFCTallyLess2Year; aFCTallyLess1Year; aFCTallyYTD)
		
	: ($1=-11)  //Omit Positive FC_OH Forecast Qty On Hand
		
		$k:=Size of array:C274(aFCRecNum)
		If ($k>0)
			For ($i; $k; 1; -1)
				If (aFCRunQty{$i}>=0)
					DELETE FROM ARRAY:C228(aFCItem; $i; 1)
					DELETE FROM ARRAY:C228(aFCDesc; $i; 1)
					DELETE FROM ARRAY:C228(aFCActionDt; $i; 1)
					DELETE FROM ARRAY:C228(aFCBomCnt; $i; 1)
					DELETE FROM ARRAY:C228(aFCRunQty; $i; 1)
					DELETE FROM ARRAY:C228(aFCBaseQty; $i; 1)
					DELETE FROM ARRAY:C228(aFCBomLevel; $i; 1)
					DELETE FROM ARRAY:C228(aFCParent; $i; 1)
					DELETE FROM ARRAY:C228(aFCTypeTran; $i; 1)
					DELETE FROM ARRAY:C228(aFCDocID; $i; 1)
					DELETE FROM ARRAY:C228(aFCRecNum; $i; 1)
					DELETE FROM ARRAY:C228(aFCWho; $i; 1)
					DELETE FROM ARRAY:C228(aFCtypeID; $i; 1)
					DELETE FROM ARRAY:C228(aFCTallyLess2Year; $i; 1)
					DELETE FROM ARRAY:C228(aFCTallyLess1Year; $i; 1)
					DELETE FROM ARRAY:C228(aFCTallyYTD; $i; 1)
				End if 
			End for 
		End if 
		
	: ($1=-12)  //Omit Negative FC_OH Forecast Qty On Hand
		
		$k:=Size of array:C274(aFCRecNum)
		If ($k>0)
			For ($i; $k; 1; -1)
				If (aFCRunQty{$i}<0)
					DELETE FROM ARRAY:C228(aFCItem; $i; 1)
					DELETE FROM ARRAY:C228(aFCDesc; $i; 1)
					DELETE FROM ARRAY:C228(aFCActionDt; $i; 1)
					DELETE FROM ARRAY:C228(aFCBomCnt; $i; 1)
					DELETE FROM ARRAY:C228(aFCRunQty; $i; 1)
					DELETE FROM ARRAY:C228(aFCBaseQty; $i; 1)
					DELETE FROM ARRAY:C228(aFCBomLevel; $i; 1)
					DELETE FROM ARRAY:C228(aFCParent; $i; 1)
					DELETE FROM ARRAY:C228(aFCTypeTran; $i; 1)
					DELETE FROM ARRAY:C228(aFCDocID; $i; 1)
					DELETE FROM ARRAY:C228(aFCRecNum; $i; 1)
					DELETE FROM ARRAY:C228(aFCWho; $i; 1)
					DELETE FROM ARRAY:C228(aFCtypeID; $i; 1)
					DELETE FROM ARRAY:C228(aFCTallyLess2Year; $i; 1)
					DELETE FROM ARRAY:C228(aFCTallyLess1Year; $i; 1)
					DELETE FROM ARRAY:C228(aFCTallyYTD; $i; 1)
				End if 
			End for 
		End if 
		
End case 