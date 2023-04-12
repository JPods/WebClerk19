//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-01-17T00:00:00, 11:16:27
// ----------------------------------------------------
// Method: OrderLineArrayElementFill
// Description
// Modified: 01/17/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------


C_LONGINT:C283($1; $i)

$i:=$1
aoLineAction{$i}:=10  //Selected record number([OrdLine])

aOLineNum{$i}:=[OrderLine:49]lineNum:3
aOItemNum{$i}:=[OrderLine:49]itemNum:4
aOAltItem{$i}:=[OrderLine:49]itemNumAlt:31
aODescpt{$i}:=[OrderLine:49]description:5
aOQtyOrder{$i}:=[OrderLine:49]qty:6
aOQtyShip{$i}:=[OrderLine:49]qtyShipped:7
aOQtyBL{$i}:=[OrderLine:49]qtyBackLogged:8

aOQtyCanceled{$i}:=[OrderLine:49]qtyCancelled:51

aOLnCmplt{$i}:=Num:C11([OrderLine:49]complete:48)*"x"  //[[Orderline]Cmplt
aOUnitPrice{$i}:=[OrderLine:49]unitPrice:9
aODiscnt{$i}:=[OrderLine:49]discount:10
aODscntUP{$i}:=DiscountApply(aOUnitPrice{$i}; aODiscnt{$i}; <>tcDecimalUP)
aOPQDIR{$i}:=-1
aOExtPrice{$i}:=[OrderLine:49]extendedPrice:11
aOBackLog{$i}:=[OrderLine:49]backOrdAmount:26
aOUnitCost{$i}:=[OrderLine:49]unitCost:12
aOExtCost{$i}:=[OrderLine:49]extendedCost:13
aOTaxable{$i}:=[OrderLine:49]taxJuris:14
aOSaleTax{$i}:=[OrderLine:49]salesTax:15
aOTaxCost{$i}:=[OrderLine:49]taxCost:55
aOSaleComm{$i}:=[OrderLine:49]commSales:17
aOSalesRate{$i}:=[OrderLine:49]commRateSales:29
aORepComm{$i}:=[OrderLine:49]commRep:16
aORepRate{$i}:=[OrderLine:49]commRateRep:18
aOUnitMeas{$i}:=[OrderLine:49]unitofMeasure:19
aOUnitWt{$i}:=[OrderLine:49]unitWt:20
//
aOExtWt{$i}:=[OrderLine:49]extendedWt:21
aOLocation{$i}:=[OrderLine:49]location:22
aOQtyOpen{$i}:=0
aOSerialRc{$i}:=[OrderLine:49]serialRc:27
//
//aoSerialNm{$i}:=[OrderLine]obSerial
//
aOSeq{$i}:=[OrderLine:49]seq:30
aOPricePt{$i}:=[OrderLine:49]typeSale:28
aODateReq{$i}:=[OrderLine:49]dateRequired:23
aoDateShipOn{$i}:=[OrderLine:49]dateShipOn:38
aoDateShipped{$i}:=[OrderLine:49]dateShipped:39

//aOShipDateOn{$i}:=[[Orderline]DateShipOn
$lnTest:=MaxValueReturn($lnTest; aOLineNum{$i}; 1)
aoProdBy{$i}:=[OrderLine:49]producedBy:43
aoLnComment{$i}:=[OrderLine:49]comment:44
aoShipOrdSt{$i}:=[OrderLine:49]status:58
aoProfile1{$i}:=[OrderLine:49]lineProfile1:45
aoProfile2{$i}:=[OrderLine:49]lineProfile2:46
//aoProfile3{$i}:=[OrderLine]obItem

aOPrintThis{$i}:=[OrderLine:49]printNot:56
aoLocationBin{$i}:=[OrderLine:49]locationBin:57
//
If ([OrderLine:49]idNum:50=0)
	
	//SAVE RECORD([OrderLine])
End if 
aoUniqueID{$i}:=[OrderLine:49]idNum:50


aOOgItem{$i}:=aOItemNum{$i}  //test rays
aOOgQOrd{$i}:=aOQtyOrder{$i}
aOOgQShip{$i}:=aOQtyShip{$i}
aOOgCancel{$i}:=aOQtyCanceled{$i}
aOOgBLQ{$i}:=aOQtyBL{$i}
aOOgLine{$i}:=aOLineNum{$i}