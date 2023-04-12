//%attributes = {}
// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-02-08T00:00:00, 14:53:11
// ----------------------------------------------------
// Method: OrdLineCreateFromInvoice
// Description
// Modified: 02/08/14
// Structure: CEv13_131005
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $2)

If (False:C215)
	
	vi2:=Records in selection:C76([Invoice:26])
	FIRST RECORD:C50([Invoice:26])
	For (vi1; 1; vi2)
		QUERY:C277([InvoiceLine:54]; [InvoiceLine:54]idNumInvoice:1=[Invoice:26]idNum:2)
		vi4:=Records in selection:C76([InvoiceLine:54])
		For (vi3; 1; vi4)
			QUERY:C277([OrderLine:49]; [OrderLine:49]idNumOrder:1=[InvoiceLine:54]idNumOrder:60; *)
			QUERY:C277([OrderLine:49];  & ; [OrderLine:49]lineNum:3=[InvoiceLine:54]lineNum:3)
			If (Records in selection:C76([OrderLine:49])=1)
				[InvoiceLine:54]unitCost:12:=[OrderLine:49]unitCost:12
				[InvoiceLine:54]extendedCost:13:=Round:C94([InvoiceLine:54]unitCost:12*[InvoiceLine:54]qty:7; 2)
				SAVE RECORD:C53([InvoiceLine:54])
			Else 
				
				
			End if 
			
		End for 
	End for 
End if 
CREATE RECORD:C68([OrderLine:49])

aiLnOrdUnique{$1}:=[OrderLine:49]idNum:50
aiLineNum{$1}:=[OrderLine:49]idNum:50
[InvoiceLine:54]orderLineNum:48:=[OrderLine:49]idNum:50
[InvoiceLine:54]lineNum:3:=[OrderLine:49]idNum:50
[OrderLine:49]lineNum:3:=[OrderLine:49]idNum:50
vLineSeq:=vLineSeq+1
[OrderLine:49]seq:30:=vLineSeq  // MaxValueInArray(->aoSeq)+1

[OrderLine:49]idNumOrder:1:=[Invoice:26]idNumOrder:1
[OrderLine:49]complete:48:=True:C214
[OrderLine:49]qty:6:=aiQtyShip{$1}
[OrderLine:49]qtyShipped:7:=aiQtyShip{$1}
[OrderLine:49]qtyBackLogged:8:=0
[OrderLine:49]itemNum:4:=aiItemNum{$1}
[OrderLine:49]itemNumAlt:31:=aiAltItem{$1}
[OrderLine:49]description:5:=aiDescpt{$1}
[OrderLine:49]unitPrice:9:=aiUnitPrice{$1}
[OrderLine:49]discount:10:=aiDiscnt{$1}
[OrderLine:49]extendedPrice:11:=aiExtPrice{$1}
[OrderLine:49]backOrdAmount:26:=0
[OrderLine:49]unitCost:12:=aiUnitCost{$1}
[OrderLine:49]extendedCost:13:=aiExtCost{$1}
[OrderLine:49]taxJuris:14:=aiTaxable{$1}
[OrderLine:49]salesTax:15:=aiSaleTax{$1}
[OrderLine:49]commRep:16:=aiRepComm{$1}
[OrderLine:49]commSales:17:=aiSaleComm{$1}
[OrderLine:49]commRateSales:29:=aiSalesRate{$1}
[OrderLine:49]commRateRep:18:=aiRepRate{$1}
[OrderLine:49]commRep:16:=aiRepComm{$1}
[OrderLine:49]commSales:17:=aiSaleComm{$1}
[OrderLine:49]unitofMeasure:19:=aiUnitMeas{$1}
[OrderLine:49]unitWt:20:=aiUnitWt{$1}
[OrderLine:49]extendedWt:21:=aiExtWt{$1}
[OrderLine:49]location:22:=aiLocation{$1}
[OrderLine:49]serialRc:27:=aiSerialRc{$1}
//[OrderLine]obSerial:=aiSerialNm{$1}
[OrderLine:49]typeSale:28:=aiPricePt{$1}
[OrderLine:49]producedBy:43:=aiProdBy{$1}
[OrderLine:49]comment:44:=aiLnComment{$1}
[OrderLine:49]profile1:32:=aiProfile1{$1}
[OrderLine:49]profile2:33:=aiProfile2{$1}
[OrderLine:49]profile3:34:=aiProfile3{$1}
[OrderLine:49]printNot:56:=aiPrintThis{$1}
[OrderLine:49]dateShipped:39:=[Invoice:26]dateShipped:4
SAVE RECORD:C53([OrderLine:49])