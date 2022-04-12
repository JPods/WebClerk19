//%attributes = {}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 12/04/19, 13:39:58
// ----------------------------------------------------
// Method: UpdateItemDiscounts
// Description
// 
//
// Parameters
// ----------------------------------------------------


//<declarations>
//==================================
//  Type variables 
//==================================

// vHere
C_LONGINT:C283($vi1; $vi2; $viProgressID)

//==================================
//  Initialize variables 
//==================================

$vi1:=0
$vi2:=0
$viProgressID:=0
//</declarations>

//script Update ItemDiscounts 200191114
//Shift Key to Exit

//All Records([ItemDiscount])

$viProgressID:=Progress New
Progress SET BUTTON ENABLED($viProgressID; True:C214)

If (vHere<2)
	$vi2:=Records in selection:C76([ItemDiscount:45])
	FIRST RECORD:C50([ItemDiscount:45])
Else 
	$vi2:=1
End if 

For ($vi1; 1; $vi2)
	If (Shift down:C543 & Caps lock down:C547)
		$vi1:=$vi2
	End if 
	
	If (Progress Stopped($viProgressID))
		$vi1:=$vi2  // exit the loop
	Else 
		ProgressUpdate($viProgressID; $vi1; $vi2; "Searching...")
	End if   // Exit Loop
	
	//==================================
	// Begin Body of Work
	//==================================
	
	
	QUERY:C277([SpecialDiscount:44]; [SpecialDiscount:44]idUnique:4=[ItemDiscount:45]SpecialDiscountsID:1)
	
	If (Records in selection:C76([SpecialDiscount:44])=0)
		[ItemDiscount:45]TypeSale:9:="Orphan"
	Else 
		
		[ItemDiscount:45]TypeSale:9:=[SpecialDiscount:44]TypeSale:1
		[ItemDiscount:45]DateBegin:15:=[SpecialDiscount:44]DateBegin:2
		[ItemDiscount:45]DateEnd:16:=[SpecialDiscount:44]DateEnd:3
		
		If ([ItemDiscount:45]DiscountedPrice:14=0)
			// ### jwm ### 20180131_1602 calculate Discounted price
			[ItemDiscount:45]DiscountedPrice:14:=Round:C94([ItemDiscount:45]BasePrice:5*(1-([ItemDiscount:45]PerCentDiscount:4*0.01)); 2)
		End if 
		// ### jwm ### 20180131_1602 calculate Discount
		
		If ([ItemDiscount:45]PerCentDiscount:4=0)
			If ([ItemDiscount:45]BasePrice:5#0)
				[ItemDiscount:45]PerCentDiscount:4:=(([ItemDiscount:45]BasePrice:5-[ItemDiscount:45]DiscountedPrice:14)/[ItemDiscount:45]BasePrice:5)*100
			Else 
				[ItemDiscount:45]PerCentDiscount:4:=0
			End if 
		End if 
		
		Case of 
				
			: ([SpecialDiscount:44]PriceBase:8=1)
				[ItemDiscount:45]TypeSalesBase:10:="List"
				
			: ([SpecialDiscount:44]PriceBase:8=2)
				[ItemDiscount:45]TypeSalesBase:10:="Trade"
				
			: ([SpecialDiscount:44]PriceBase:8=3)
				[ItemDiscount:45]TypeSalesBase:10:="Preferred"
				
			: ([SpecialDiscount:44]PriceBase:8=1)
				[ItemDiscount:45]TypeSalesBase:10:="Distributor"
				
			: ([SpecialDiscount:44]PriceBase:8=1)
				[ItemDiscount:45]TypeSalesBase:10:="MSRP"
				
				
		End case 
		
	End if 
	
	SAVE RECORD:C53([ItemDiscount:45])
	
	If ((vHere<2) & ($vi1<$vi2))
		NEXT RECORD:C51([ItemDiscount:45])
	End if 
	
	//==================================
	// End Body of Work
	//==================================
	
End for 

Progress QUIT($viProgressID)

If (vHere<2)
	UNLOAD RECORD:C212([ItemDiscount:45])
End if 
