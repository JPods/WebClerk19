//%attributes = {"publishedWeb":true}
//Procedure: XR_FillArrays
C_LONGINT:C283($1; $i; $k; $2; $3)
Case of 
	: ($1=0)
		ARRAY TEXT:C222(aXItemNum; 0)
		ARRAY TEXT:C222(aXItemDesc; 0)
		ARRAY TEXT:C222(aXVendCode; 0)
		ARRAY LONGINT:C221(aXLead; 0)
		ARRAY REAL:C219(aXCost; 0)
		ARRAY TEXT:C222(aXLocation; 0)
		ARRAY REAL:C219(aXQtyLoc; 0)
		ARRAY LONGINT:C221(aXRefRec; 0)
	: ($1>0)
		SELECTION TO ARRAY:C260([ItemXRef:22]; aXRefRec; [ItemXRef:22]itemNumXRef:2; aXItemNum; [ItemXRef:22]descriptionXRef:3; aXItemDesc; [ItemXRef:22]sourceid:4; aXVendCode; [ItemXRef:22]leadTime:6; aXLead; [ItemXRef:22]cost:7; aXCost; [ItemXRef:22]siteid:11; aXLocation; [ItemXRef:22]quantity:12; aXQtyLoc)
	: ($1=-4)  //fill specific record
		
	: ($1=-3)  //add a line, $2 for $3 lines   
		
	: ($1=-1)  //delete a line, $2 for $3 lines
	: ($1=-6)  //Show Subset    
		
	: ($1=-7)  //Omit Subset    
End case 