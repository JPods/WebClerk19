//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 08/10/06, 13:53:33
// ----------------------------------------------------
// Method: P_OrdLines2PVars
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(curLines)
$qtyFormat:="###,###,###,##0.###,###,###"
pvSeq:=String:C10([OrderLine:49]seq:30)
pvItemNum:=[OrderLine:49]itemNum:4
pvAltItem:=[OrderLine:49]altItem:31
pvDescription:=[OrderLine:49]description:5
pvQtyOrd:=String:C10([OrderLine:49]qty:6; $qtyFormat)
pvQtyShip:=String:C10([OrderLine:49]qtyShipped:7; $qtyFormat)
pvQtyBL:=String:C10([OrderLine:49]qtyBackLogged:8; $qtyFormat)
pvQtyCancelled:=String:C10([OrderLine:49]qtyCancelled:51; $qtyFormat)  //### jwm ### 20120524_1132

// ### bj ### 20191012_1720
// make this a line field based. Link it with a webbased lookup by location
pvTaxable:=(Num:C11([OrderLine:49]salesTax:15>0)*"X")
pvTax:=String:C10([OrderLine:49]salesTax:15; <>tcFormatUP)
pvrTaxCost:=String:C10([OrderLine:49]taxCost:55; <>tcFormatUP)
pvPricePt:=[OrderLine:49]typeSale:28
pvBasePrice:=String:C10([OrderLine:49]unitPrice:9; <>tcFormatUP)
pvUnitPrice:=String:C10(DiscountApply([OrderLine:49]unitPrice:9; [OrderLine:49]discount:10; <>tcDecimalUP); <>tcFormatUP)
pvDiscount:=String:C10([OrderLine:49]discount:10; "##0.0")
pvExtPrice:=String:C10([OrderLine:49]extendedPrice:11; <>tcFormatTt)

pvAmountBL:=String:C10([OrderLine:49]backOrdAmount:26; <>tcFormatTt)
pvUnitCost:=String:C10([OrderLine:49]unitCost:12; <>tcFormatTt)
pvExtCost:=String:C10([OrderLine:49]extendedCost:13; <>tcFormatTt)
pvUnitMeas:=[OrderLine:49]unitofMeasure:19
pvLocation:=String:C10([OrderLine:49]location:22; <>tcFormatTt)
pvLocationBin:=[OrderLine:49]locationBin:57
pvUse:=""
pvUnitWt:=String:C10([OrderLine:49]unitWt:20; <>tcFormatTt)
pvExtWt:=String:C10([OrderLine:49]extendedWt:21; <>tcFormatTt)

pvLeadTime:=""

pvSerial:=[OrderLine:49]serialNum:40
pvCommRep:=String:C10([OrderLine:49]commRep:16; <>tcFormatTt)
pvCommSales:=String:C10([OrderLine:49]commSales:17; <>tcFormatTt)
pvRateRep:=String:C10(Abs:C99([OrderLine:49]commRateRep:18); <>tcFormatTt)
pvRateSales:=String:C10(Abs:C99([OrderLine:49]commRateSales:29); <>tcFormatTt)
Case of 
	: (([OrderLine:49]commRep:16=0) & ([OrderLine:49]commSales:17=0))
		pvRateCommt:=""
	: (([OrderLine:49]commRateRep:18<0) | ([OrderLine:49]commRateSales:29<0))
		pvRateCommt:="Unit Rate"
	Else 
		pvRateCommt:="% Rate"
End case 
pvReference:=""  //String([OrderLine]PO;<>tcFormatTt)
pvLnProfile1:=[OrderLine:49]lineProfile1:45
pvLnProfile2:=[OrderLine:49]lineProfile2:46
pvLnProfile3:=[OrderLine:49]lineProfile3:47
pvProfileReal1:=String:C10([OrderLine:49]profileReal1:62; $qtyFormat)  //### jwm ### 20120524_0020
pvProfileReal2:=String:C10([OrderLine:49]profileReal2:63; $qtyFormat)  //### jwm ### 20120524_002
pvLnComment:=[OrderLine:49]comment:44
pvDateProm:=String:C10([OrderLine:49]dateShipOn:38; 1)
pvDateReq:=String:C10([OrderLine:49]dateRequired:23; 1)
pvDateShip:=String:C10([OrderLine:49]dateShipped:39; 1)
pvNameID:=[OrderLine:49]producedBy:43
pvPrintThis:=String:C10([OrderLine:49]printNot:56)
If (([Order:3]currency:69#"") & ([Order:3]currency:69#<>tcMONEYCHAR))
	fExUnPrice:=String:C10(Round:C94(Round:C94(DiscountApply([OrderLine:49]unitPrice:9; [OrderLine:49]discount:10; viExConPrec)*[Order:3]exchangeRate:68; viExConPrec); viExDisPrec); <>tcFormatUP)
	fExUnExPrice:=String:C10(Round:C94(Round:C94(Num:C11(fExUnPrice)*[OrderLine:49]qty:6; viExConPrec); viExDisPrec); <>tcFormatTt)
	fExUnCost:=String:C10(Round:C94(Round:C94([OrderLine:49]unitCost:12*[Order:3]exchangeRate:68; viExConPrec); viExDisPrec); <>tcFormatUC)
	fExUnExCost:=String:C10(Round:C94(Round:C94(Num:C11(fExUnCost)*[OrderLine:49]qty:6; viExConPrec); viExDisPrec); <>tcFormatTt)
Else 
	fExUnPrice:=pvUnitPrice
	fExUnExPrice:=pvExtPrice
	fExUnCost:=pvUnitCost
	fExUnExCost:=pvExtCost
End if 

pvQtyCancelled:=String:C10([OrderLine:49]qtyCancelled:51; $qtyFormat)
pvProfileReal1:=String:C10([OrderLine:49]profileReal1:62; $qtyFormat)
pvProfileReal2:=String:C10([OrderLine:49]profileReal2:63; $qtyFormat)


