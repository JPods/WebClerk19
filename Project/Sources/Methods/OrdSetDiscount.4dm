//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2015-02-15T00:00:00, 18:56:56
// ----------------------------------------------------
// Method: OrdSetDiscount
// Description
// Modified: 02/15/15
// Structure: CEv13_131005
// 
//
// Parameters: $1 qty Ordered; $2 TypeSale $3 ItemNumber
// ----------------------------------------------------
// ### jwm ### 20150414_1100 added disocunt calculation for Special Discounts
// ### jwm ### 20150720_1918 QQQQQQQQ Bill look at this


C_REAL:C285($1; $0; $SrchValue; vSpclDscn; $discnt)
C_BOOLEAN:C305($Done)
C_LONGINT:C283($i; $k)


// ### jwm ### 20150414_1100 Start
C_TEXT:C284($2; $typesale; $3; $itemnum)
C_DATE:C307($theDate)

$typesale:=""
$itemNum:=""

If (Count parameters:C259>=2)
	$typesale:=$2
End if 

If (Count parameters:C259>=3)
	$itemnum:=$3
End if 

//TRACE
If (($typesale#"") & ($itemnum#""))
	
	$theDate:=Current date:C33
	vSpclDscn:=0
	$discnt:=0
	
	Case of 
		: ($typesale=<>tcPriceLvlA)
			$discnt:=0
		: ($typesale=<>tcPriceLvlB)
			$discnt:=0
		: ($typesale=<>tcPriceLvlC)
			$discnt:=0
		: ($typesale=<>tcPriceLvlD)
			$discnt:=0
		: (<>tcbManyType=False:C215)
			$discnt:=0
		Else 
			QUERY:C277([SpecialDiscount:44]; [SpecialDiscount:44]TypeSale:1=$typesale; *)
			QUERY:C277([SpecialDiscount:44];  & [SpecialDiscount:44]DateBegin:2<=$theDate; *)
			QUERY:C277([SpecialDiscount:44];  & [SpecialDiscount:44]DateEnd:3>=$theDate)
			Case of 
				: (Records in selection:C76([SpecialDiscount:44])=0)
					$discnt:=0
				: (Records in selection:C76([SpecialDiscount:44])=1)
					If ([SpecialDiscount:44]PerCent:5)  //universal discount
						vSpclDscn:=[SpecialDiscount:44]PerCentDiscount:6
					Else 
						vSpclDscn:=0
						QUERY:C277([ItemDiscount:45]; [ItemDiscount:45]SpecialDiscountsID:1=[SpecialDiscount:44]idUnique:4; *)
						QUERY:C277([ItemDiscount:45]; [ItemDiscount:45]ItemNum:2=$itemnum; *)
						QUERY:C277([ItemDiscount:45])
						If (Records in selection:C76([ItemDiscount:45])=1)
							$discnt:=[ItemDiscount:45]PerCentDiscount:4
						Else 
							$discnt:=0
						End if 
					End if 
					
				: (Records in selection:C76([SpecialDiscount:44])>1)
					$discnt:=0
			End case 
			
			REDUCE SELECTION:C351([SpecialDiscount:44]; 0)
			REDUCE SELECTION:C351([ItemDiscount:45]; 0)
	End case 
End if 

Case of 
	: (vSpclDscn=0)
		$0:=$discnt
		// ### jwm ### 20150414_1100 End
	: (vSpclDscn#0)
		// Modified by: Bill James (2015-01-19T00:00:00 Special Discounts were not being changed)
		//
		$0:=vSpclDscn
	: (Not:C34([Item:4]discountable:28))
		$0:=0
	: ([Item:4]useQtyPriceBrks:6>0)
		$SrchValue:=$1
		TRACE:C157
		// Modified by: Bill James (2015-12-16T00:00:00: qqqWords TestThis)
		// does there need to be a price quantity effort or is matrix pricing working
		
		// $k:=Records in sub_selection([Item]PriceBreaks)
		// If ($k>0)
		// $Done:=False
		// $i:=0
		// FIRST SUBRECORD([Item]PriceBreaks)
		// If ($1<)
		// $0:=[Customer]Discount
		// Else 
		// Repeat 
		// $i:=$i+1
		// $discnt:=
		// If (($SrchValue>=) & ($SrchValue<=))
		// $Done:=True
		// Else 
		// NEXT SUBRECORD([Item]PriceBreaks)
		// End if 
		// Until (($i=$k) | ($Done))
		// $0:=[Customer]Discount+$discnt
		// End if 
		
		// Else 
		// $0:=Round([Customer]Discount+0.0000001;6)
		// End if 
	Else 
		$0:=Round:C94([QQQCustomer:2]discount:36+0.0000001; 6)
End case 
// Modified by: Bill James (2015-01-19T00:00:00 Special Discounts were not being changed)
//vSpclDscn:=0