//%attributes = {"publishedWeb":true}
C_LONGINT:C283($1; $2; $w)
Case of 
	: ($1=0)
		ARRAY TEXT:C222(aPartBom; $2)  //Item Number
		ARRAY REAL:C219(aPartBomCnt; $2)  //Count
		ARRAY DATE:C224(aDate1; $2)  //Date of action
		ARRAY TEXT:C222(a80Str2; $2)  //Level of this part, Root, Intermediate
		ARRAY TEXT:C222(a35Str2; $2)  //Parent Part
		ARRAY TEXT:C222(a3Str1; $2)  //Type of Transaction (SO, PO, WO, Nn)
		ARRAY LONGINT:C221(aLongInt2; $2)  //SO's, PO's and WO's
		ARRAY LONGINT:C221(aCrtRecs; $2)  //Record Number
		//  
		ARRAY TEXT:C222(a80Str4; $2)  //Description
		ARRAY REAL:C219(aQtyAct; $2)  //          Running quantity on hand
	: ($1=1)  //insert
		$w:=Size of array:C274(aPartBom)+1
		INSERT IN ARRAY:C227(aPartBom; $w; $2)
		INSERT IN ARRAY:C227(aPartBomCnt; $w; $2)
		INSERT IN ARRAY:C227(aDate1; $w; $2)
		INSERT IN ARRAY:C227(a80Str2; $w; $2)
		INSERT IN ARRAY:C227(a35Str2; $w; $2)
		INSERT IN ARRAY:C227(a3Str1; $w; $2)  //Type of Transaction (SO, PO, WO)
		INSERT IN ARRAY:C227(aLongInt2; $w; $2)
		INSERT IN ARRAY:C227(a80Str4; $w; $2)  //Description
		INSERT IN ARRAY:C227(aQtyAct; $w; $2)  //          Running quantity on hand
		INSERT IN ARRAY:C227(aCrtRecs; $w; $2)
	: ($1=-1)  //delete
End case 