//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: ItemKeyPathVariables
	//Date: 07/01/02
	//Who: Bill
	//Description: List of structure
End if 
// ### jwm ### 20150526_1421  correction to pDiscnt for <>tcbManyType SpecialDiscounts
// fill out the variables for items
// check if they are in the shopping cart
// 
C_TEXT:C284(pvItemPathKey)
//

pvItemPathImage:=ItemSpecPathKey([Item:4]imagePath:104; "")
pvItemPathTN:=ItemSpecPathKey([Item:4]imagePath:104; "/TN")
pvItemPathImageTN:=pvItemPathTN
pvQtyAvailable:=[Item:4]qtyOnHand:14-[Item:4]qtyOnSalesOrder:16-[Item:4]qtyAllocated:72
pvQtyLikely:=[Item:4]qtyOnHand:14-[Item:4]qtyOnSalesOrder:16-[Item:4]qtyAllocated:72+[Item:4]qtyOnPo:20+[Item:4]qtyVi:76
pvQtyAvailable:=pvQtyAvailable*Num:C11(pvQtyAvailable>0)
pvQtyLikely:=pvQtyLikely*Num:C11(pvQtyAvailable>0)
pvQtySuggested:=[Item:4]qtySaleDefault:15
If (pQtyOrd=0)
	pQtyOrd:=pvQtySuggested
	pvQtyOrd:=String:C10(pvQtySuggested)
End if 
C_TEXT:C284(pvTypeSale)
Case of 
	: (pvTypeSale#"")
		pvTypeSale:=pvTypeSale
	: (Record number:C243([Invoice:26])>-1)
		pvTypeSale:=[Invoice:26]typeSale:49
	: (Record number:C243([Order:3])>-1)
		pvTypeSale:=[Order:3]typeSale:22
	: (Record number:C243([Proposal:42])>-1)
		pvTypeSale:=[Proposal:42]typeSale:20
	Else 
		pvTypeSale:=[Customer:2]typeSale:18
End case 
vUseBase:=SetPricePoint(pvTypeSale)
If ((vUseBase<2) | (vUseBase>5))
	vUseBase:=2
End if 
$theBaseLinePricePoint:=vUseBase
pUnitPrice:=Field:C253(Table:C252(->[Item:4]); vUseBase)->
pBasePrice:=Field:C253(4; $theBaseLinePricePoint)->  //must have vUseBase set earlier
pDiscnt:=OrdSetDiscount(pQtyOrd)
pUnitPrice:=DiscountApply(pBasePrice; pDiscnt; <>tcDecimalUP)
// pExtPrice:=Round(pUnitPrice*$qty;<>tcDecimalTt)

C_LONGINT:C283($foundInCart)
pvQtyInCart:=0
If (Size of array:C274(aShoppingCartItem)>0)
	$foundInCart:=Find in array:C230(aShoppingCartItem; [Item:4]itemNum:1)
	If ($foundInCart>0)
		pvQtyInCart:=aShoppingCartQty{$foundInCart}  //qty in the shopping carts
	End if 
End if 
Case of 
	: (pvTypeSale="Matrix@")
		//QUERY([PriceMatrix];[PriceMatrix]TypeSale=[Customer]TypeSale;*)
		//QUERY([PriceMatrix];&[PriceMatrix]HowUsed=[Order]TypeSale;*)
		QUERY:C277([PriceMatrix:105]; [PriceMatrix:105]typeSale:3=pvTypeSale; *)
		//QUERY([PriceMatrix];&[PriceMatrix]HowUsed=[Order]TypeSale;*)
		QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]quantityMin:4<=pQtyOrd; *)
		QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]quantityMax:5>=pQtyOrd)
		If (Records in selection:C76([PriceMatrix:105])=1)
			pUnitPrice:=[PriceMatrix:105]price:6
			pDiscnt:=0
			pComm:=[PriceMatrix:105]commissionFactor:7
			ptaxID:=[PriceMatrix:105]taxid:8
		Else 
			pUnitPrice:=[Item:4]priceA:2
			pDiscnt:=OrdSetDiscount(pQtyOrd)
			pComm:=[Item:4]commissionA:29
		End if 
	: (pvTypeSale="LastPrice")
		QUERY:C277([OrderLine:49]; [OrderLine:49]itemNum:4=[Item:4]itemNum:1; *)
		QUERY:C277([OrderLine:49];  & [OrderLine:49]customerID:2=[Customer:2]customerID:1)
		Case of 
			: (Records in selection:C76([OrderLine:49])=1)
				pUnitPrice:=[OrderLine:49]unitPrice:9
				pDiscnt:=[OrderLine:49]discount:10
			: (Records in selection:C76([OrderLine:49])>1)
				ORDER BY:C49([OrderLine:49]; [OrderLine:49]dateOrdered:25; <)
				FIRST RECORD:C50([OrderLine:49])
			Else 
				pUnitPrice:=[OrderLine:49]unitPrice:9
				pDiscnt:=[OrderLine:49]discount:10
		End case 
		pComm:=[Item:4]commissionA:29
	: ([Item:4]factor:44#0)
		pUnitPrice:=Round:C94([Item:4]costLastInShip:47*(1+([Item:4]factor:44/100)); <>tcDecimalUC)
		pDiscnt:=0
		pComm:=Field:C253(Table:C252(->[Item:4]); (vUseBase+27))->
	: (<>tcbManyType)  //&(bManyType=1))
		//DscntSetPrice ([Order]TypeSale;cdToday)
		
		QUERY:C277([SpecialDiscount:44]; [SpecialDiscount:44]typeSale:1=pvTypeSale; *)
		QUERY:C277([SpecialDiscount:44];  & [SpecialDiscount:44]dateBegin:2<=cdToday; *)
		QUERY:C277([SpecialDiscount:44];  & [SpecialDiscount:44]dateEnd:3>=cdToday)
		If (Records in selection:C76([SpecialDiscount:44])=1)
			pComm:=[SpecialDiscount:44]commission:9
			vUseBase:=[SpecialDiscount:44]priceBase:8+1
			//pDiscnt:=[SpecialDiscount]PerCentDiscount
			pDiscnt:=0  // ### jwm ### 20150526_1421  initialize to zero
			pComm:=[SpecialDiscount:44]commission:9
			If ([SpecialDiscount:44]perCent:5)  //universal discount
				// ### jwm ### 20150720_1851 QQQQQQ
				pDiscnt:=[SpecialDiscount:44]perCentDiscount:6  // ### jwm ### 20150526_1420
				booSpclComm:=True:C214
				pBasePrice:=Field:C253(4; vUseBase)->
				pUnitPrice:=DiscountApply(pBasePrice; pDiscnt; <>tcDecimalUP)
			Else 
				QUERY:C277([ItemDiscount:45]; [ItemDiscount:45]specialDiscountsid:1=[SpecialDiscount:44]idNum:4; *)
				QUERY:C277([ItemDiscount:45];  & [ItemDiscount:45]itemNum:2=[Item:4]itemNum:1)
				If (Records in selection:C76([ItemDiscount:45])=1)
					pBasePrice:=[ItemDiscount:45]basePrice:5
					pDiscnt:=[ItemDiscount:45]perCentDiscount:4
					pUnitPrice:=DiscountApply(pBasePrice; pDiscnt; <>tcDecimalUP)
				End if 
			End if 
		End if 
		//Else 
		//pUnitPrice:=Field(Table(->[Item]);vUseBase)->
		//pDiscnt:=OrdSetDiscount (pQtyOrd)
		//pComm:=Field(Table(->[Item]);(vUseBase+27))->
End case 
//
If ((vWccSecurity=0) & (viEndUserSecurityLevel<<>viWebPriceLevel))
	pvBasePrice:=<>vWebNoPriceComment
	pvUnitPrice:=<>vWebNoPriceComment
Else 
	pvBasePrice:=String:C10(pBasePrice; <>tcFormatUP)
	pvUnitPrice:=String:C10(pUnitPrice; <>tcFormatUP)
End if 
pvQtyOrd:=String:C10(pQtyOrd)