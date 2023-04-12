//%attributes = {"publishedWeb":true}
//Method: PM:  IE_OrdFillOrdLineArraysByPtrArr
//Noah Dykoski   May 15, 2000 / 3:12 AM
C_POINTER:C301($1; $FieldArrayPtr)
$FieldArrayPtr:=$1
C_POINTER:C301($2; $DataArrayPtr)
$DataArrayPtr:=$2
C_LONGINT:C283($3; $OrderLineArrayElem)
$OrderLineArrayElem:=$3

C_LONGINT:C283($index)
For ($index; 1; Size of array:C274($FieldArrayPtr->))
	Case of 
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]lineNum:3))
			aOLineNum{$OrderLineArrayElem}:=Num:C11($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]itemNum:4))
			aOItemNum{$OrderLineArrayElem}:=$DataArrayPtr->{$index}
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]description:5))
			aODescpt{$OrderLineArrayElem}:=$DataArrayPtr->{$index}
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]qtyOrdered:6))
			aOQtyOrder{$OrderLineArrayElem}:=Num:C11($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]qtyShipped:7))
			aOQtyShip{$OrderLineArrayElem}:=Num:C11($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]qtyBackLogged:8))
			aOQtyBL{$OrderLineArrayElem}:=Num:C11($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]unitPrice:9))
			aOUnitPrice{$OrderLineArrayElem}:=Num:C11($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]discount:10))
			aODiscnt{$OrderLineArrayElem}:=Num:C11($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]extendedPrice:11))
			aOExtPrice{$OrderLineArrayElem}:=Num:C11($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]unitCost:12))
			aOUnitCost{$OrderLineArrayElem}:=Num:C11($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]extendedCost:13))
			aOExtCost{$OrderLineArrayElem}:=Num:C11($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]taxid:14))
			aOTaxable{$OrderLineArrayElem}:=$DataArrayPtr->{$index}
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]salesTax:15))
			aOSaleTax{$OrderLineArrayElem}:=Num:C11($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]commRep:16))
			aORepComm{$OrderLineArrayElem}:=Num:C11($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]commSales:17))
			aOSaleComm{$OrderLineArrayElem}:=Num:C11($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]commRateRep:18))
			aORepRate{$OrderLineArrayElem}:=Num:C11($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]unitofMeasure:19))
			aOUnitMeas{$OrderLineArrayElem}:=$DataArrayPtr->{$index}
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]unitWt:20))
			aOUnitWt{$OrderLineArrayElem}:=Num:C11($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]extendedWt:21))
			aOExtWt{$OrderLineArrayElem}:=Num:C11($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]location:22))
			aOLocation{$OrderLineArrayElem}:=Num:C11($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]dateRequired:23))
			aODateReq{$OrderLineArrayElem}:=Date:C102($DataArrayPtr->{$index})
			//: ($FieldArrayPtr->{$index}=(->[OrdLine]TypeItem))
			//: ($FieldArrayPtr->{$index}=(->[OrdLine]DateOrdered))
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]backOrdAmount:26))
			aOBackLog{$OrderLineArrayElem}:=Num:C11($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]serialRc:27))
			aOSerialRc{$OrderLineArrayElem}:=Num:C11($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]typeSale:28))
			aOPricePt{$OrderLineArrayElem}:=$DataArrayPtr->{$index}
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]commRateSales:29))
			aOSalesRate{$OrderLineArrayElem}:=Num:C11($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]seq:30))
			aOSeq{$OrderLineArrayElem}:=Num:C11($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]altItem:31))
			aOAltItem{$OrderLineArrayElem}:=$DataArrayPtr->{$index}
			//: ($FieldArrayPtr->{$index}=(->[OrdLine]Profile1))
			//: ($FieldArrayPtr->{$index}=(->[OrdLine]Profile2))
			//: ($FieldArrayPtr->{$index}=(->[OrdLine]Profile3))
			//: ($FieldArrayPtr->{$index}=(->[OrdLine]Profile4))
			//: ($FieldArrayPtr->{$index}=(->[OrdLine]RepID))
			//: ($FieldArrayPtr->{$index}=(->[OrdLine]SalesName))
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]dateShipOn:38))
			aoDateShipOn{$OrderLineArrayElem}:=Date:C102($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]dateShipped:39))
			aoDateShipped{$OrderLineArrayElem}:=Date:C102($DataArrayPtr->{$index})
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]serialNum:40))
			aOSerialNm{$OrderLineArrayElem}:=$DataArrayPtr->{$index}
			//: ($FieldArrayPtr->{$index}=(->[OrdLine]CustReference))
			//: ($FieldArrayPtr->{$index}=(->[OrdLine]VendorID))
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]producedBy:43))
			aoProdBy{$OrderLineArrayElem}:=$DataArrayPtr->{$index}
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]comment:44))
			aoLnComment{$OrderLineArrayElem}:=$DataArrayPtr->{$index}
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]lineProfile1:45))
			aoProfile1{$OrderLineArrayElem}:=$DataArrayPtr->{$index}
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]lineProfile2:46))
			aoProfile2{$OrderLineArrayElem}:=$DataArrayPtr->{$index}
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]lineProfile3:47))
			aoProfile3{$OrderLineArrayElem}:=$DataArrayPtr->{$index}
		: ($FieldArrayPtr->{$index}=(->[OrderLine:49]complete:48))
			aOLnCmplt{$OrderLineArrayElem}:=$DataArrayPtr->{$index}
			//: ($FieldArrayPtr->{$index}=(->[OrdLine]LnDivision))
	End case 
End for 
