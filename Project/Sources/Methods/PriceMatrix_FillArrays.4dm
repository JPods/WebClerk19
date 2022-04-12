//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 06/03/08, 16:36:33
// ----------------------------------------------------
// Method: 


// Description
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $2; $3; $incRay; $cntRay; $diff; eListDocuments; ePPListDocuments; $4)
Case of 
	: ($1=0)
		ARRAY LONGINT:C221(aPMtrxUniqueID; 0)
		ARRAY LONGINT:C221(aPMtrxRecordNum; 0)
		ARRAY TEXT:C222(aPMtrxItemNum; 0)
		ARRAY REAL:C219(aPMtrxQtyMin; 0)
		ARRAY REAL:C219(aPMtrxQtyMax; 0)
		ARRAY REAL:C219(aPMtrxCost; 0)
		ARRAY REAL:C219(aPMtrxPrice; 0)
		//
		ARRAY LONGINT:C221(aPMtrxSelect; 0)  //selection array
	: ($1>0)
		SELECTION TO ARRAY:C260([PriceMatrix:105]price:6; aPMtrxPrice; [PriceMatrix:105]cost:9; aPMtrxCost; [PriceMatrix:105]idNum:1; aPMtrxUniqueID; [PriceMatrix:105]; aPMtrxRecordNum; [PriceMatrix:105]itemNum:11; aPMtrxItemNum; [PriceMatrix:105]quantityMin:4; aPMtrxQtyMin; [PriceMatrix:105]quantityMax:5; aPMtrxQtyMax)
		SORT ARRAY:C229(aPMtrxQtyMin; aPMtrxQtyMax; aPMtrxCost; aPMtrxItemNum; aPMtrxUniqueID; aPMtrxRecordNum; aPMtrxPrice)
		ARRAY LONGINT:C221(aPMtrxSelect; 0)
		
	: (($1=-1) | ($1=-2))  //delete an element
		//-2  delete an element in array only
		If ($1=-1)
			//READ WRITE([PriceMatrix])
			GOTO RECORD:C242([PriceMatrix:105]; aPMtrxRecordNum{$2})
			DELETE RECORD:C58([PriceMatrix:105])
			//READ ONLY([PriceMatrix])
		End if 
		DELETE FROM ARRAY:C228(aPMtrxUniqueID; $2; $3)
		DELETE FROM ARRAY:C228(aPMtrxRecordNum; $2; $3)
		DELETE FROM ARRAY:C228(aPMtrxItemNum; $2; $3)
		DELETE FROM ARRAY:C228(aPMtrxQtyMin; $2; $3)
		DELETE FROM ARRAY:C228(aPMtrxQtyMax; $2; $3)
		DELETE FROM ARRAY:C228(aPMtrxCost; $2; $3)
		DELETE FROM ARRAY:C228(aPMtrxPrice; $2; $3)
		
		//
		ARRAY LONGINT:C221(aPMtrxSelect; 0)  //selection array
		//
	: ($1=-3)  //insert an element
		INSERT IN ARRAY:C227(aPMtrxUniqueID; $2; $3)
		INSERT IN ARRAY:C227(aPMtrxRecordNum; $2; $3)
		INSERT IN ARRAY:C227(aPMtrxItemNum; $2; $3)
		INSERT IN ARRAY:C227(aPMtrxQtyMin; $2; $3)
		INSERT IN ARRAY:C227(aPMtrxQtyMax; $2; $3)
		INSERT IN ARRAY:C227(aPMtrxCost; $2; $3)
		INSERT IN ARRAY:C227(aPMtrxPrice; $2; $3)
		
		//
		ARRAY LONGINT:C221(aPMtrxSelect; 1)  //selection array
		aPMtrxSelect{1}:=$2
	: ($1=-4)  //Fill a record
		
		//
	: ($1=-5)  //array to selection
		//READ WRITE([ImagePath])
		$cntRay:=Size of array:C274(aPMtrxRecordNum)
		For ($incRay; 1; $cntRay)
			If (aPMtrxUniqueID{$incRay}=0)
				
				CREATE RECORD:C68([PriceMatrix:105])
			Else 
				QUERY:C277([PriceMatrix:105]; [PriceMatrix:105]idNum:1=aPMtrxUniqueID{$incRay})
			End if 
			[PriceMatrix:105]price:6:=aPMtrxPrice{$incRay}
			[PriceMatrix:105]cost:9:=aPMtrxCost{$incRay}
			// [PriceMatrix]UniqueID:=aPMtrxUniqueID{$incRay}
			[PriceMatrix:105]itemNum:11:=aPMtrxItemNum{$incRay}
			[PriceMatrix:105]quantityMin:4:=aPMtrxQtyMin{$incRay}
			[PriceMatrix:105]quantityMax:5:=aPMtrxQtyMax{$incRay}
			SAVE RECORD:C53([PriceMatrix:105])
		End for 
		// Modified by: Bill James (2016-08-12T00:00:00)  qqqq????zzzz test this
		// RRAY TO SELECTION(aPMtrxPrice;[PriceMatrix]Price;aPMtrxCost;[PriceMatrix]Cost;aPMtrxUniqueID;[PriceMatrix]UniqueID;aPMtrxItemNum;[PriceMatrix]ItemNum;aPMtrxQtyMin;[PriceMatrix]QuantityMin;aPMtrxQtyMax;[PriceMatrix]QuantityMax)
		SORT ARRAY:C229(aPMtrxQtyMin; aPMtrxQtyMax; aPMtrxCost; aPMtrxItemNum; aPMtrxUniqueID; aPMtrxRecordNum; aPMtrxPrice)
		UNLOAD RECORD:C212([PriceMatrix:105])
		//
	: ($1=-6)  //Update an array
		
		aPMtrxUniqueID{$2}:=[PriceMatrix:105]idNum:1
		aPMtrxRecordNum{$2}:=Record number:C243([PriceMatrix:105])
		aPMtrxItemNum{$2}:=[PriceMatrix:105]itemNum:11
		aPMtrxQtyMin{$2}:=[PriceMatrix:105]quantityMin:4
		aPMtrxQtyMax{$2}:=[PriceMatrix:105]quantityMax:5
		aPMtrxCost{$2}:=[PriceMatrix:105]cost:9
		aPMtrxPrice{$2}:=[PriceMatrix:105]price:6
		
	: ($1=-7)
		
		SORT ARRAY:C229(aPMtrxQtyMin; aPMtrxQtyMax; aPMtrxCost; aPMtrxItemNum; aPMtrxUniqueID; aPMtrxRecordNum; aPMtrxPrice)
		ARRAY LONGINT:C221(aPMtrxSelect; 0)  //selection array
		
	: ($1=-9)
		
		SORT ARRAY:C229(aPMtrxItemNum; aPMtrxQtyMin; aPMtrxQtyMax; aPMtrxCost; aPMtrxUniqueID; aPMtrxRecordNum; aPMtrxPrice)
		ARRAY LONGINT:C221(aPMtrxSelect; 0)  //selection array
		
	: ($1=-8)
		
		
	: ($1=-13)
		If ((Size of array:C274(aPMtrxRecordNum)>=$2) & (Size of array:C274(aPMtrxRecordNum)>0))
			GOTO RECORD:C242([PriceMatrix:105]; aPMtrxRecordNum{$2})
			//CREATE RECORD([PriceMatrix])
			//
			//aPMtrxUniqueID{$2}:=[PriceMatrix]UniqueID
			//[PriceMatrix]ItemNum:=aPMtrxItemNum{$2}
			[PriceMatrix:105]quantityMin:4:=aPMtrxQtyMin{$2}
			[PriceMatrix:105]quantityMax:5:=aPMtrxQtyMax{$2}
			[PriceMatrix:105]cost:9:=aPMtrxCost{$2}
			[PriceMatrix:105]price:6:=aPMtrxPrice{$2}
			//[PriceMatrix]TypeSale:="Estimating"
			SAVE RECORD:C53([PriceMatrix:105])
			//aPMtrxRecordNum{$2}:=Record number([PriceMatrix])
		End if 
		UNLOAD RECORD:C212([PriceMatrix:105])
		
	: ($1=-15)
		If ((Size of array:C274(aPMtrxRecordNum)>=$2) & (Size of array:C274(aPMtrxRecordNum)>0))
			If (aPMtrxRecordNum{$2}<0)
				CREATE RECORD:C68([PriceMatrix:105])
				
				aPMtrxUniqueID{$2}:=[PriceMatrix:105]idNum:1
				[PriceMatrix:105]itemNum:11:=aPMtrxItemNum{$2}
				[PriceMatrix:105]typeSale:3:="Estimating"
			Else 
				GOTO RECORD:C242([PriceMatrix:105]; aPMtrxRecordNum{$2})
			End if 
			[PriceMatrix:105]quantityMin:4:=aPMtrxQtyMin{$2}
			[PriceMatrix:105]quantityMax:5:=aPMtrxQtyMax{$2}
			[PriceMatrix:105]cost:9:=aPMtrxCost{$2}
			[PriceMatrix:105]price:6:=aPMtrxPrice{$2}
			SAVE RECORD:C53([PriceMatrix:105])
			aPMtrxRecordNum{$2}:=Record number:C243([PriceMatrix:105])
		End if 
		UNLOAD RECORD:C212([PriceMatrix:105])
End case 
Case of 
	: (ePriceMatrixList>0)
		//  --  CHOPPED  AL_UpdateArrays(ePriceMatrixList; -2)
End case 

