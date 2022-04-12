//%attributes = {}
// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 05/13/15, 17:10:02
// ----------------------------------------------------
// Method: Get_Price
// Description
// 
//
// Parameters
// ----------------------------------------------------
//Script Get_Price 20150306
//Author: James W. Medlen
//Created September 25, 2009
//Modified September 28, 2009 MTH Missing : for equals on viError 
//Modified 20090929 - TypeSale exact match for current Item Record
//Modified 20110404 - added MSRP
//Ignores Dates
//allowAlerts_boo added

//Execute_TallyMaster("Get_Price";"Scripts";3)
//$itemnum item number to lookup
//$$typesale type sale of pricing

C_REAL:C285($price; $0)
C_LONGINT:C283($error)
C_TEXT:C284($itemnum; $1; $typesale; $2)

$price:=0
$error:=0

If (Count parameters:C259=2)
	$itemnum:=$1
	$typesale:=$2
Else 
	$error:=-1
	If (allowAlerts_boo)
		ALERT:C41("ERROR: - Invalid Parameter Count")
	End if 
End if 

// Query Items // 
If (($itemnum="") | ($typesale=""))
	$error:=1  // MTH ADDED :
	If (allowAlerts_boo)
		ALERT:C41("ERROR: - Missing TypeSale or ItemNum")
	End if 
End if 

If ([Item:4]itemNum:1#$itemnum)
	If (allowAlerts_boo)
		ALERT:C41("Error: $itemnum does not match current Item Record")
	End if 
End if 

If (viError=0)
	
	QUERY:C277([SpecialDiscount:44]; [SpecialDiscount:44]typeSale:1=$typesale)
	
	viRecords:=Records in selection:C76([SpecialDiscount:44])
	
	If (viRecords>1)
		If (allowAlerts_boo)
			ALERT:C41("ERROR: Multiple Special Discounts Found")
		End if 
	End if 
	
	If (viRecords=1)
		
		//ALERT("One special Discount found "+[SpecialDiscount]TypeSale)
		
		QUERY:C277([ItemDiscount:45]; [ItemDiscount:45]specialDiscountsid:1=[SpecialDiscount:44]idNum:4; *)
		QUERY:C277([ItemDiscount:45]; [ItemDiscount:45]itemNum:2=$itemnum; *)
		QUERY:C277([ItemDiscount:45])
		
		viRecords:=Records in selection:C76([ItemDiscount:45])
		
		If (viRecords=1)
			
			vrPrice:=([ItemDiscount:45]basePrice:5-([ItemDiscount:45]basePrice:5*[ItemDiscount:45]perCentDiscount:4*0.01))
			vrPrice:=Round:C94(vrPrice; 2)
			
		Else 
			
			Case of 
				: ([SpecialDiscount:44]priceBase:8=1)
					$0:=[Item:4]priceA:2
					
				: ([SpecialDiscount:44]priceBase:8=2)
					$0:=[Item:4]priceB:3
					
				: ([SpecialDiscount:44]priceBase:8=3)
					$0:=[Item:4]priceC:4
					
				: ([SpecialDiscount:44]priceBase:8=4)
					$0:=[Item:4]priceD:5
					
				: ([SpecialDiscount:44]priceBase:8=5)
					$0:=[Item:4]priceMSR:109
					
			End case 
			
		End if 
		
	Else 
		
		Case of 
			: ($typesale="@List@")
				$0:=[Item:4]priceA:2
				
			: ($typesale="@Trade@")
				$0:=[Item:4]priceB:3
				
			: ($typesale="@Preferred@")
				$0:=[Item:4]priceC:4
				
			: ($typesale="@Distributor@")
				$0:=[Item:4]priceD:5
				
			: ($typesale="@MSRP@")
				$0:=[Item:4]priceMSR:109
				
			Else 
				If (allowAlerts_boo)
					ALERT:C41("ERROR: Type Sale "+$typesale+" Not Found")
				End if 
				
		End case 
	End if 
	
End if 

UNLOAD RECORD:C212([SpecialDiscount:44])
UNLOAD RECORD:C212([ItemDiscount:45])
REDUCE SELECTION:C351([SpecialDiscount:44]; 0)
REDUCE SELECTION:C351([ItemDiscount:45]; 0)

