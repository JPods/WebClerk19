//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/10/06, 17:50:49
// ----------------------------------------------------
// Method: P_InvcLines2PVars
// Description
// 
//
// Parameters
// ----------------------------------------------------
READ ONLY:C145([InvoiceLine:54])
READ ONLY:C145([OrderLine:49])
//vPrintBodyCounter:=vPrintBodyCounter+1
GOTO RECORD:C242([InvoiceLine:54]; aPrintBodyCount{vPrintBodyCounter})
//ALERT([InvoiceLine]ItemNum+" "+String(Record number([InvoiceLine]))+" "+String(vPrintBodyCounter)+" "+String(Size of array(aPrintBodyCount)))
QUERY:C277([Item:4]; [Item:4]itemNum:1=[InvoiceLine:54]itemNum:4)
Item_GetSpec
$doBlanks:=Num:C11(([InvoiceLine:54]itemNum:4#"Comment") | ([InvoiceLine:54]itemNum:4#"-"))
$qtyFormat:="###,###,###,##0.###,###,###"
pvSeq:=String:C10(curLines+1)
pvItemNum:=[InvoiceLine:54]itemNum:4
pvAltItem:=[InvoiceLine:54]altItem:29
pvDescription:=[InvoiceLine:54]description:5
QUERY:C277([OrderLine:49]; [OrderLine:49]idNum:50=[InvoiceLine:54]orderLineNum:48)
pvQtyOrd:=String:C10([OrderLine:49]qty:6; $qtyFormat)
//  [InvoiceLine]QtyOrderedAtInvoice
pvQtyShip:=String:C10([InvoiceLine:54]qty:7; $qtyFormat)
pvQtyBL:=String:C10([InvoiceLine:54]qtyBackLogged:8; $qtyFormat)
pvTaxable:=Num:C11([InvoiceLine:54]salesTax:15>0)*"X"
pvTax:=String:C10([InvoiceLine:54]salesTax:15; <>tcFormatUP)
pvPricePt:=[InvoiceLine:54]typeSale:27
pvBasePrice:=String:C10([InvoiceLine:54]unitPrice:9; <>tcFormatUP)
pvUnitPrice:=String:C10(DiscountApply([InvoiceLine:54]unitPrice:9; [InvoiceLine:54]discount:10; <>tcDecimalUP); <>tcFormatUP)
pvDiscount:=String:C10([InvoiceLine:54]discount:10; "##0.0")
pvExtPrice:=String:C10([InvoiceLine:54]extendedPrice:11; <>tcFormatTt)

pvAmountBL:=""
pvUnitCost:=String:C10([InvoiceLine:54]unitCost:12; <>tcFormatUC)
pvExtCost:=String:C10([InvoiceLine:54]extendedCost:13; <>tcFormatTt)
pvUnitMeas:=[InvoiceLine:54]unitofMeasure:19
pvLocation:=String:C10([InvoiceLine:54]location:22; <>tcFormatTt)
pvUse:=""
pvUnitWt:=String:C10([InvoiceLine:54]unitWt:20; <>tcFormatTt)
pvExtWt:=String:C10([InvoiceLine:54]extendedWt:21; <>tcFormatTt)
pvLeadTime:=""
pvSerial:=[InvoiceLine:54]serialNum:36
pvCommRep:=String:C10([InvoiceLine:54]commRep:16; <>tcFormatTt)
pvCommSales:=String:C10([InvoiceLine:54]commSales:17; <>tcFormatTt)
pvRateRep:=String:C10(Abs:C99([InvoiceLine:54]commRateRep:18); <>tcFormatTt)
pvRateSales:=String:C10(Abs:C99([InvoiceLine:54]commRateSales:23); <>tcFormatTt)
Case of 
	: (([InvoiceLine:54]commRep:16=0) & ([InvoiceLine:54]commSales:17=0))
		pvRateCommt:=""
	: (([InvoiceLine:54]commRateRep:18<0) | ([InvoiceLine:54]commRateSales:23<0))
		pvRateCommt:="Unit Rate"
	Else 
		pvRateCommt:="% Rate"
End case 
pvReference:=""
pvLnProfile1:=[InvoiceLine:54]lineProfile1:42
pvLnProfile2:=[InvoiceLine:54]lineProfile2:43
pvLnProfile3:=[InvoiceLine:54]lineProfile3:44
pvShipOrdSt:=[InvoiceLine:54]shipOrderStatus:41
pvLnComment:=[InvoiceLine:54]comment:40
pvLnStatus:=""  //[InvoiceLine]ShipStatus
pvNameID:=[InvoiceLine:54]producedBy:39
If (([Invoice:26]currency:62#"") & ([Invoice:26]currency:62#<>tcMONEYCHAR))
	fExUnPrice:=String:C10(Round:C94(Round:C94(DiscountApply([InvoiceLine:54]unitPrice:9; [InvoiceLine:54]discount:10; viExConPrec)*[Invoice:26]exchangeRate:61; viExConPrec); viExDisPrec); <>tcFormatUP)
	fExUnExPrice:=String:C10(Round:C94(Round:C94(Num:C11(fExUnPrice)*[InvoiceLine:54]qty:7; viExConPrec); viExDisPrec); <>tcFormatTt)
	fExUnCost:=String:C10(Round:C94(Round:C94([InvoiceLine:54]unitCost:12*[Invoice:26]exchangeRate:61; viExConPrec); viExDisPrec); <>tcFormatUC)
	fExUnExCost:=String:C10(Round:C94(Round:C94(Num:C11(fExUnCost)*[InvoiceLine:54]qty:7; viExConPrec); viExDisPrec); <>tcFormatTt)
Else 
	fExUnPrice:=pvUnitPrice
	fExUnExPrice:=pvExtPrice
	fExUnCost:=pvUnitCost
	fExUnExCost:=pvExtCost
End if 
///Old_DoP_VarLines
READ WRITE:C146([InvoiceLine:54])
READ WRITE:C146([OrderLine:49])


