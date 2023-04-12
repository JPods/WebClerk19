//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/27/12, 15:44:09
// ----------------------------------------------------
// Method: IvcLineFillArrayElement
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $2; $curSize; $fillByRecords; $i)
$i:=$1
// might add a check to assure $i is never one more than size of array
If ($i>Size of array:C274(aiLineAction))
	IvcLn_RaySize(1; $i; 1)
End if 
aiLineAction{$i}:=10  //Selected record number([InvLine])
// If ([InvoiceLine]LineNum=0)
// [InvoiceLine]LineNum:=$i
// SAVE RECORD([InvoiceLine])
// End if 
aiUniqueID{$i}:=[InvoiceLine:54]idNum:47
aiLnOrdUnique{$i}:=[InvoiceLine:54]orderLineNum:48

aiLineNum{$i}:=[InvoiceLine:54]lineNum:3

aiSeq{$i}:=[InvoiceLine:54]seq:28
If ([InvoiceLine:54]seq:28=0)
	aiSeq{$i}:=MaxValueInArray(->aiSeq)+1
Else 
	aiSeq{$i}:=[InvoiceLine:54]seq:28
End if 

//
aiItemNum{$i}:=[InvoiceLine:54]itemNum:4
aiAltItem{$i}:=[InvoiceLine:54]itemNumAlt:29
aiDescpt{$i}:=[InvoiceLine:54]description:5
aiQtyOrder{$i}:=[InvoiceLine:54]qtyOrderedAtInvoice:63
viBoxCnt:=viBoxCnt+aiQtyOrder{$i}
aiQtyShip{$i}:=[InvoiceLine:54]qty:7

// Modified by: William James (2014-01-21T00:00:00)
// The [InvoiceLine]QtyRemain and [InvoiceLine]QtyBackLogged should be set when the record is created
// Adjustment should follow the normal flow ONLY

// If (([Invoice]OrderNum#1) & (Size of array(aOLineNum)>0))
// $w:=Find in array(aOLineNum;[InvoiceLine]LineNum)
// If ($w>0)
// aiQtyRemain{$i}:=aOQtyBL{$w}+[InvoiceLine]QtyShipped
// aiQtyBL{$i}:=aOQtyBL{$w}
// End if 
// Else 
If (False:C215)
	If ([InvoiceLine:54]orderLineNum:48>0)
		QUERY:C277([OrderLine:49]; [OrderLine:49]idNum:50=[InvoiceLine:54]orderLineNum:48)
		aiQtyRemain{$i}:=[OrderLine:49]qtyBackLogged:8
		UNLOAD RECORD:C212([OrderLine:49])
	Else 
		aiQtyRemain{$i}:=0
	End if 
End if 
aiQtyRemain{$i}:=[InvoiceLine:54]qtyRemain:6  // keep at the level created at the time the invoice was created
aiQtyBL{$i}:=[InvoiceLine:54]qtyBackLogged:8
//  End if 
aiUnitPrice{$i}:=[InvoiceLine:54]unitPrice:9
aiDiscnt{$i}:=[InvoiceLine:54]discount:10
aiUnitPriceDiscounted{$i}:=DiscountApply(aiUnitPrice{$i}; aiDiscnt{$i}; <>tcDecimalUP)
aiPQDIR{$i}:=-1
aiExtPrice{$i}:=[InvoiceLine:54]extendedPrice:11
aiUnitCost{$i}:=[InvoiceLine:54]unitCost:12
aiExtCost{$i}:=[InvoiceLine:54]extendedCost:13

aiTaxable{$i}:=[InvoiceLine:54]taxJuris:14
aiSaleTax{$i}:=[InvoiceLine:54]salesTax:15
aiTaxCost{$i}:=[InvoiceLine:54]taxCost:51
aiSaleComm{$i}:=[InvoiceLine:54]commSales:17
aiSalesRate{$i}:=[InvoiceLine:54]commRateSales:23
aiRepComm{$i}:=[InvoiceLine:54]commRep:16
aiRepRate{$i}:=[InvoiceLine:54]commRateRep:18
aiUnitMeas{$i}:=[InvoiceLine:54]unitofMeasure:19
aiUnitWt{$i}:=[InvoiceLine:54]unitWt:20
aiExtWt{$i}:=[InvoiceLine:54]extendedWt:21
aiLocation{$i}:=[InvoiceLine:54]location:22
aiLocationBin{$i}:=[InvoiceLine:54]locationBin:53
aiQtyOpen{$i}:=0
aiSerialRc{$i}:=[InvoiceLine:54]serialRc:26
//aiSerialNm{$i}:=[InvoiceLine]obSerial
aiPricePt{$i}:=[InvoiceLine:54]typeSale:27
aiProdBy{$i}:=[InvoiceLine:54]producedBy:39
aiLnComment{$i}:=[InvoiceLine:54]comment:40
aiShipOrdSt{$i}:=[InvoiceLine:54]shipOrderStatus:41
aiProfile1{$i}:=[InvoiceLine:54]lineProfile1:42
aiProfile2{$i}:=[InvoiceLine:54]lineProfile2:43
//aiProfile3{$i}:=[InvoiceLine]obItem
aiPrintThis{$i}:=[InvoiceLine:54]printNot:52


