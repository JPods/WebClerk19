//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: PackOrdLnRays
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 
//
Case of 
	: ($1=0)
		ARRAY REAL:C219(aOQtyPack; $1)
		ARRAY REAL:C219(aOQtyBL; $1)
		ARRAY TEXT:C222(aOItemNum; $1)
		ARRAY TEXT:C222(aOAltItem; $1)
		ARRAY TEXT:C222(aODescpt; $1)
		ARRAY LONGINT:C221(aOSeq; $1)
		ARRAY TEXT:C222(aOUnitMeas; $1)
		ARRAY LONGINT:C221(aOLocation; $1)
		ARRAY REAL:C219(aOQtyShip; $1)
		ARRAY REAL:C219(aOQtyOrder; $1)
		ARRAY REAL:C219(aOQtyOpen; $1)
		ARRAY LONGINT:C221(aoLineAction; $1)  //initialize the array to 0's in the elements
		ARRAY LONGINT:C221(aOLineNum; $1)
		ARRAY LONGINT:C221(aoUniqueID; $1)
	: ($1>0)
		//SELECTION TO ARRAY(
		C_LONGINT:C283($i)
		For ($i; 1; $1)
			
			aOQtyPack{$i}:=0
			
		End for 
	: ($1=-1)  //delete elements
		//
	: ($1=-3)  //insert elements
		//
	: ($1=-7)  //update element    
		//
End case 