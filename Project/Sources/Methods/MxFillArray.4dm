//%attributes = {"publishedWeb":true}
//MtxFillArray
//030310
//
C_LONGINT:C283($1; $2; $3; $incRay; $sizeRay; $diff; $i; $k)
Case of 
	: ($1=0)
		ARRAY TEXT:C222(aMxClass; 0)
		ARRAY TEXT:C222(aMxDescription; 0)
		ARRAY TEXT:C222(aMxCat01; 0)
		ARRAY TEXT:C222(aMxCat02; 0)
		ARRAY TEXT:C222(aMxCat03; 0)
		ARRAY TEXT:C222(aMxCat04; 0)
		ARRAY TEXT:C222(aMxCat05; 0)
		ARRAY TEXT:C222(aMxCat06; 0)
		ARRAY TEXT:C222(aMxCat07; 0)
		ARRAY TEXT:C222(aMxCat08; 0)
		ARRAY TEXT:C222(aMxCat09; 0)
		ARRAY TEXT:C222(aMxCat10; 0)
		ARRAY TEXT:C222(aMxCat11; 0)
		ARRAY TEXT:C222(aMxCat12; 0)
		ARRAY TEXT:C222(aMxCat13; 0)
		ARRAY TEXT:C222(aMxCat14; 0)
		ARRAY TEXT:C222(aMxCat15; 0)
		ARRAY TEXT:C222(aMxCat16; 0)
		ARRAY TEXT:C222(aMxCat17; 0)
		ARRAY TEXT:C222(aMxCat18; 0)
		ARRAY TEXT:C222(aMxCat19; 0)
		ARRAY TEXT:C222(aMxCat20; 0)
		ARRAY TEXT:C222(aMxCat21; 0)
		ARRAY TEXT:C222(aMxCat22; 0)
		ARRAY TEXT:C222(aMxCat23; 0)
		ARRAY TEXT:C222(aMxCat24; 0)
		ARRAY TEXT:C222(aMxCat25; 0)
		ARRAY TEXT:C222(aMxCat26; 0)
		ARRAY TEXT:C222(aMxCat27; 0)
		ARRAY TEXT:C222(aMxCat28; 0)
		ARRAY TEXT:C222(aMxCat29; 0)
		ARRAY TEXT:C222(aMxCat30; 0)
		ARRAY TEXT:C222(aMxCat31; 0)
		ARRAY TEXT:C222(aMxCat32; 0)
		ARRAY TEXT:C222(aMxCat33; 0)
		ARRAY TEXT:C222(aMxCat34; 0)
		ARRAY TEXT:C222(aMxCat35; 0)
		ARRAY TEXT:C222(aMxCat36; 0)
		ARRAY TEXT:C222(aMxCat37; 0)
		ARRAY TEXT:C222(aMxCat38; 0)
		ARRAY TEXT:C222(aMxCat39; 0)
	: ($1>0)
		
		
	: ($1=-1)  //delete an element
		
		
	: ($1=-3)  //insert an element
		INSERT IN ARRAY:C227(aMxClass; $2; $3)
		INSERT IN ARRAY:C227(aMxDescription; $2; $3)
		$k:=39
		C_POINTER:C301($ptArray)
		For ($i; 1; $k)
			$ptArray:=Get pointer:C304("aMxCat"+String:C10($i; "00"))
			INSERT IN ARRAY:C227($ptArray->; $2; $3)
		End for 
	: ($1=-4)  //Fill a record
		
		
	: ($1=-5)  //array to selection
		
		//
	: ($1=-6)  //Update an array
		
	: ($1=-7)
		
End case 


