//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2016-08-10T00:00:00, 07:11:38
// ----------------------------------------------------
// Method: Disc_ArraysDo
// Description
// Modified: 08/10/16
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------



C_LONGINT:C283($1)
C_LONGINT:C283($1; $2; $3; $i; $k)
Case of 
	: ($1=0)
		ARRAY TEXT:C222(aSdItemNum; $1)
		ARRAY TEXT:C222(aSdDescript; $1)
		ARRAY REAL:C219(aSdBase; $1)  //Depth in BOM
		ARRAY REAL:C219(aSdDiscPC; $1)  //Multiple at this BOM Point  aQtyAct
		ARRAY REAL:C219(aSdDisPrice; $1)  //keeps the place in line        aOpenOrders
		ARRAY REAL:C219(aSdCost; $1)  //keeps the place in line        aOpenOrders
		ARRAY REAL:C219(aSdMargin; $1)  //keeps the place in line        aOpenOrders
		
		ARRAY LONGINT:C221(aSdUniqueID; $1)
		ARRAY TEXT:C222(aSdtypeID; $1)
		ARRAY TEXT:C222(aSdTypeSalesBase; $1)
		ARRAY DATE:C224(aSdDateCreated; $1)
		//
		ARRAY LONGINT:C221(aSdSelectLn; 0)
	: ($1>0)
		SELECTION TO ARRAY:C260([ItemDiscount:45]itemNum:2; aSdItemNum; [ItemDiscount:45]description:8; aSdDescript; [ItemDiscount:45]basePrice:5; aSdBase; [ItemDiscount:45]perCentDiscount:4; aSdDiscPC; [ItemDiscount:45]idNum:7; aSdUniqueID; [ItemDiscount:45]dateCreated:6; aSdDateCreated; [ItemDiscount:45]typeSale:9; aSdtypeID; [ItemDiscount:45]typeSalesBase:10; aSdTypeSalesBase)
		
		ARRAY REAL:C219(aSdCost; $1)
		ARRAY REAL:C219(aSdMargin; $1)  // 
		ARRAY REAL:C219(aSdDisPrice; $1)  //
		$k:=Size of array:C274(aSdItemNum)
		For ($i; 1; $k)
			aSdCost{$i}:=0
			aSdMargin{$i}:=0
			aSdDisPrice{$i}:=Round:C94(DiscountApply(aSdBase{$i}; aSdDiscPC{$i}; 10); <>tcDecimalUP)
		End for 
		UNLOAD RECORD:C212([ItemDiscount:45])
		//
		ARRAY LONGINT:C221(aSdSelectLn; 0)
	: ($1=-1)  //delete a line, $2 for $3 lines
		DELETE FROM ARRAY:C228(aSdItemNum; $2; $3)
		DELETE FROM ARRAY:C228(aSdDescript; $2; $3)
		DELETE FROM ARRAY:C228(aSdBase; $2; $3)
		DELETE FROM ARRAY:C228(aSdDiscPC; $2; $3)
		DELETE FROM ARRAY:C228(aSdDisPrice; $2; $3)
		DELETE FROM ARRAY:C228(aSdCost; $2; $3)
		DELETE FROM ARRAY:C228(aSdMargin; $2; $3)
		
		DELETE FROM ARRAY:C228(aSdUniqueID; $2; $3)
		DELETE FROM ARRAY:C228(aSdtypeID; $2; $3)
		DELETE FROM ARRAY:C228(aSdTypeSalesBase; $2; $3)
		DELETE FROM ARRAY:C228(aSdDateCreated; $2; $3)
		
		//
		//ARRAY LONGINT(aSdSelectLn;0)
	: ($1=-3)  //add a line, $2 for $3 lines   
		INSERT IN ARRAY:C227(aSdItemNum; $2; $3)
		INSERT IN ARRAY:C227(aSdDescript; $2; $3)
		INSERT IN ARRAY:C227(aSdBase; $2; $3)
		INSERT IN ARRAY:C227(aSdDiscPC; $2; $3)
		INSERT IN ARRAY:C227(aSdDisPrice; $2; $3)
		INSERT IN ARRAY:C227(aSdCost; $2; $3)
		INSERT IN ARRAY:C227(aSdMargin; $2; $3)
		
		INSERT IN ARRAY:C227(aSdUniqueID; $2; $3)
		INSERT IN ARRAY:C227(aSdtypeID; $2; $3)
		INSERT IN ARRAY:C227(aSdTypeSalesBase; $2; $3)
		INSERT IN ARRAY:C227(aSdDateCreated; $2; $3)
		
		ARRAY LONGINT:C221(aSdSelectLn; 0)
	: ($1=-5)  //apply to selection
		
		// Modified by: Bill James (2016-08-10T00:00:00 Array to Selection change)
		
		READ WRITE:C146([ItemDiscount:45])
		QUERY:C277([ItemDiscount:45]; [ItemDiscount:45]specialDiscountsid:1=[SpecialDiscount:44]idNum:4)
		ARRAY LONGINT:C221($aRecNums; 0)
		SELECTION TO ARRAY:C260([ItemDiscount:45]; $aRecNums)
		
		C_LONGINT:C283($i; $k; $w)
		$k:=Size of array:C274(aSdItemNum)
		ARRAY LONGINT:C221(aTmpLong1; $k)
		
		For ($i; 1; $k)
			aTmpLong1{$i}:=[SpecialDiscount:44]idNum:4
			If (aSdDateCreated{$i}=!00-00-00!)
				aSdDateCreated{$i}:=Current date:C33
			End if 
			aSdtypeID{$i}:=[SpecialDiscount:44]typeSale:1
			If (aSdUniqueID{$i}=0)
				CREATE RECORD:C68([ItemDiscount:45])
				aSdUniqueID{$i}:=[ItemDiscount:45]idNum:7
			Else 
				QUERY:C277([ItemDiscount:45]; [ItemDiscount:45]idNum:7=aSdUniqueID{$i})
				$w:=Find in array:C230($aRecNums; Record number:C243([ItemDiscount:45]))
				If ($w>0)
					DELETE FROM ARRAY:C228($aRecNums; $w; 1)
				End if 
			End if 
			If (aSdTypeSalesBase{$i}="")
				Case of 
					: ([SpecialDiscount:44]priceBase:8=2)
						aSdTypeSalesBase{$i}:=<>tcPriceLvlB
					: ([SpecialDiscount:44]priceBase:8=3)
						aSdTypeSalesBase{$i}:=<>tcPriceLvlC
					: ([SpecialDiscount:44]priceBase:8=4)
						aSdTypeSalesBase{$i}:=<>tcPriceLvlD
					: ([SpecialDiscount:44]priceBase:8=5)
						aSdTypeSalesBase{$i}:="MSR"
					Else 
						aSdTypeSalesBase{$i}:=<>tcPriceLvlA
				End case 
			End if 
			[ItemDiscount:45]specialDiscountsid:1:=aTmpLong1{$i}
			[ItemDiscount:45]itemNum:2:=aSdItemNum{$i}
			[ItemDiscount:45]description:8:=aSdDescript{$i}
			[ItemDiscount:45]basePrice:5:=aSdBase{$i}
			[ItemDiscount:45]perCentDiscount:4:=aSdDiscPC{$i}
			[ItemDiscount:45]dateCreated:6:=aSdDateCreated{$i}
			[ItemDiscount:45]typeSale:9:=aSdtypeID{$i}
			[ItemDiscount:45]typeSalesBase:10:=aSdTypeSalesBase{$i}
			[ItemDiscount:45]discountedPrice:14:=DiscountApply([ItemDiscount:45]basePrice:5; [ItemDiscount:45]perCentDiscount:4; <>tcDecimalUP)  // ### jwm ### 20190522_0814
			SAVE RECORD:C53([ItemDiscount:45])
		End for 
		
		$k:=Size of array:C274($aRecNums)
		For ($i; 1; $k)
			GOTO RECORD:C242([ItemDiscount:45]; $aRecNums{$i})
			DELETE RECORD:C58([ItemDiscount:45])
		End for 
		REDUCE SELECTION:C351([ItemDiscount:45]; 0)
		// RRAY TO SELECTION(aTmpLong1;[ItemDiscount]SpecialDiscountsID;aSdItemNum;[ItemDiscount]ItemNum;aSdDescript;[ItemDiscount]Description;aSdBase;[ItemDiscount]BasePrice;aSdDiscPC;[ItemDiscount]PerCentDiscount;aSdUniqueID;[ItemDiscount]UniqueID;aSdDateCreated;[ItemDiscount]DateCreated;aSdtypeID;[ItemDiscount]TypeSale;aSdTypeSalesBase;[ItemDiscount]TypeSalesBase)
		
		
		READ ONLY:C145([ItemDiscount:45])
		ARRAY LONGINT:C221(aTmpLong1; 0)
	: ($1=-4)  //fill specific record
		
	: ($1=-6)  //Show Subset    
		
	: ($1=-7)  //Omit Subset        
		
End case 
viRecordsInSelection:=Size of array:C274(aSdItemNum)