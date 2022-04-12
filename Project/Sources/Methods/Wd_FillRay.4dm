//%attributes = {"publishedWeb":true}
//Procedure: Wd_FillRay
C_LONGINT:C283($1)
Case of 
	: ($1=0)
		ARRAY TEXT:C222(aWdItem; 0)  //[Item]ItemNum
		ARRAY TEXT:C222(aWdDscrp; 0)  //[Item]Description
		ARRAY TEXT:C222(aWdReason; 0)  //
		ARRAY REAL:C219(aWdQty; 0)  //[Item]QtySaleDefault
		ARRAY REAL:C219(aWdCost; 0)  //[Item]CostWtStd
		ARRAY LONGINT:C221(aWdSo; 0)  //0
		ARRAY TEXT:C222(aWdComment; 0)  //[Item]CommentAlert
		ARRAY TEXT:C222(aWdVendor; 0)  //[Item]VendorKey
		ARRAY TEXT:C222(aWdNameID; 0)  //who
		ARRAY DATE:C224(aWdDate; 0)
		ARRAY LONGINT:C221(aWdItemRec; 0)  //[Item]
		//
		ARRAY LONGINT:C221(aWDItemLine; 0)
	: ($1>0)
		SELECTION TO ARRAY:C260([Item:4]itemNum:1; aWdItem; [Item:4]qtySaleDefault:15; aWdQty; [Item:4]costAverage:13; aWdCost; [Item:4]description:7; aWdDscrp; [Item:4]alertMessage:52; aWdComment; [Item:4]vendorId:45; aWdVendor; [Item:4]; aWdItemRec)
		$k:=Size of array:C274(aWdItem)
		ARRAY TEXT:C222(aWdReason; $k)
		ARRAY LONGINT:C221(aWdSo; $k)
		ARRAY DATE:C224(aWdDate; $k)
		ARRAY TEXT:C222(aWdNameID; $k)  //who
		C_LONGINT:C283($theOrder)
		//If (<>aActiveWOs>0)
		//$theOrder:=<>aActiveWOs{<>aActiveWOs}
		//Else 
		$theOrder:=0
		//End if 
		For ($i; 1; $k)
			aWdReason{$i}:=<>aCostCause{<>aCostCause}
			aWdSo{$i}:=$theOrder
			aWdDate{$i}:=Current date:C33
			If (vR1>0)
				aWdQty{$i}:=vR1
			End if 
			aWdNameID{$i}:=Current user:C182
		End for 
		REDUCE SELECTION:C351([Item:4]; 0)
		//
		ARRAY LONGINT:C221(aWDItemLine; 0)
	: ($1=-4)  //fill specific record
		//[Time]Cause:=aTCCause{$2}
		//[Time]NameIDKey:=aTCNameID{$2}
		
	: ($1=-5)  //
		
	: ($1=-3)  //add a line, $2 for $3 lines    
		INSERT IN ARRAY:C227(aWdItem; $2; $3)  //[Item]ItemNum
		INSERT IN ARRAY:C227(aWdDscrp; $2; $3)  //[Item]Description
		INSERT IN ARRAY:C227(aWdReason; $2; $3)  //
		INSERT IN ARRAY:C227(aWdQty; $2; $3)  //[Item]QtySaleDefault
		INSERT IN ARRAY:C227(aWdCost; $2; $3)  //[Item]CostWtStd
		INSERT IN ARRAY:C227(aWdSo; $2; $3)  //0
		INSERT IN ARRAY:C227(aWdComment; $2; $3)  //[Item]CommentAlert
		INSERT IN ARRAY:C227(aWdVendor; $2; $3)  //[Item]VendorKey
		INSERT IN ARRAY:C227(aWdNameID; $2; $3)
		INSERT IN ARRAY:C227(aWdItemRec; $2; $3)  //[Item]    
		INSERT IN ARRAY:C227(aWdDate; $2; $3)
		//    
	: ($1=-1)  //delete a line, $2 for $3 lines
	: ($1=-6)  //Show Subset
		//Ray_ShowSubSet (aTCSelLns;aTCNameID;aTCSignedIN) 
		ARRAY LONGINT:C221(aWDItemLine; 0)
		doSearch:=6
	: ($1=-7)  //Omit Subset
		//Ray_OmitSubSet (aTCSelLns;aTCNameID)
		ARRAY LONGINT:C221(aWDItemLine; 0)
		doSearch:=6
End case 