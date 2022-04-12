//%attributes = {}

// ----------------------------------------------------
// User name (OS): amercer
// Date and time: 04/18/19, 14:32:58
// ----------------------------------------------------
// Method: CalcDiscountedPrice
// Description
// 
//
// Parameters
// ----------------------------------------------------

// *************************************************************** //
// *** TYPE AND INITIALIZE ALL VARIABLES ************************* //
// *************************************************************** //

C_TEXT:C284($vtItemNum)
$vtItemNum:=$1

C_TEXT:C284($vtTypeSale)
$vtTypeSale:=$2

C_REAL:C285($vrOrderQty)
$vrOrderQty:=0
If (Count parameters:C259>2)
	$vrOrderQty:=$3
End if 

C_LONGINT:C283($viBasePriceFieldNum)
$viBasePriceFieldNum:=SetPricePoint($vtTypeSale)
If (($viBasePriceFieldNum<2) | ($viBasePriceFieldNum>5))
	$viBasePriceFieldNum:=2
End if 

C_REAL:C285($vrPercentDiscount)
$vrPercentDiscount:=0

C_REAL:C285($vrBasePrice; $vrDiscountedPrice)

// *************************************************************** //
// *** LOAD THE SPECIFIED ITEM, AND CALCULATE ******************** //
// *** IT'S PRICE FOR THE SPECIFIED TYPESALE ********************* //
// *************************************************************** //

// SET THE QUERY TABLES TO READ ONLY

READ ONLY:C145([Item:4])
READ ONLY:C145([PriceMatrix:105])
READ ONLY:C145([SpecialDiscount:44])

// LOAD THE SPECIFIED ITEM'S RECORD

QUERY:C277([Item:4]; [Item:4]itemNum:1=$vtItemNum)

// BUILD THE DEFAULT BASE PRICE AND DISCOUNTED PRICE

$vrBasePrice:=Field:C253(Table:C252(->[Item:4]); $viBasePriceFieldNum)->
$vrDiscountedPrice:=DiscountApply($vrBasePrice; $vrPercentDiscount; <>tcDecimalUP)

Case of 
	: ($vtTypeSale="Matrix@")
		QUERY:C277([PriceMatrix:105]; [PriceMatrix:105]TypeSale:3=$vtTypeSale; *)
		QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]QuantityMin:4<=$vrOrderQty; *)
		QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]QuantityMax:5>=$vrOrderQty)
		If (Records in selection:C76([PriceMatrix:105])=1)
			$vrDiscountedPrice:=[PriceMatrix:105]Price:6
			$vrPercentDiscount:=0
		Else 
			$vrDiscountedPrice:=[Item:4]priceA:2
			$vrPercentDiscount:=OrdSetDiscount($vrOrderQty)
		End if 
	: ([Item:4]factor:44#0)
		$vrDiscountedPrice:=Round:C94([Item:4]costLastInShip:47*(1+([Item:4]factor:44/100)); <>tcDecimalUC)
		$vrPercentDiscount:=0
	: (<>tcbManyType)  //&(bManyType=1))
		QUERY:C277([SpecialDiscount:44]; [SpecialDiscount:44]TypeSale:1=$vtTypeSale; *)
		QUERY:C277([SpecialDiscount:44];  & [SpecialDiscount:44]DateBegin:2<=Current date:C33; *)
		QUERY:C277([SpecialDiscount:44];  & [SpecialDiscount:44]DateEnd:3>=Current date:C33)
		If (Records in selection:C76([SpecialDiscount:44])=1)
			$viBasePriceFieldNum:=[SpecialDiscount:44]PriceBase:8+1
			$vrPercentDiscount:=0  // ### jwm ### 20150526_1421  initialize to zero
			If ([SpecialDiscount:44]PerCent:5)  //universal discount
				$vrPercentDiscount:=[SpecialDiscount:44]PerCentDiscount:6  // ### jwm ### 20150526_1420
				$vrBasePrice:=Field:C253(Table:C252(->[Item:4]); $viBasePriceFieldNum)->
				$vrDiscountedPrice:=DiscountApply($vrBasePrice; $vrPercentDiscount; <>tcDecimalUP)
			Else 
				QUERY:C277([ItemDiscount:45]; [ItemDiscount:45]SpecialDiscountsID:1=[SpecialDiscount:44]idUnique:4; *)
				QUERY:C277([ItemDiscount:45];  & [ItemDiscount:45]ItemNum:2=[Item:4]itemNum:1)
				If (Records in selection:C76([ItemDiscount:45])=1)
					$vrBasePrice:=[ItemDiscount:45]BasePrice:5
					$vrPercentDiscount:=[ItemDiscount:45]PerCentDiscount:4
					$vrDiscountedPrice:=DiscountApply($vrBasePrice; $vrPercentDiscount; <>tcDecimalUP)
				End if 
			End if 
		End if 
End case 

// RESET THE QUERY TABLES TO READ WRITE

READ WRITE:C146([Item:4])
READ WRITE:C146([PriceMatrix:105])
READ WRITE:C146([SpecialDiscount:44])

// RETURN THE CALCULATED DISCOUNT PRICE

$0:=$vrDiscountedPrice