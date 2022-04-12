//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/07/11, 11:54:23
// ----------------------------------------------------
// Method: OrdLn_RecordFill
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($1; $i)
$i:=$1

//  Changes to the orderlines arrays must have already been made
If (False:C215)
	If (Not:C34(Is new record:C668([OrderLine:49])) & ([OrderLine:49]idNum:50=0))
		ALERT:C41("Missing UniqueID on OrderLines")
		TRACE:C157
	End if 
End if 
// If (aoUniqueID{$i}<0)
// Modified by: Bill James (2016-08-08T00:00:00 automatic numbering of [Orderline])
///  OrdLineCalc
If (Is new record:C668([OrderLine:49]))
	// 
	aoUniqueID{$i}:=[OrderLine:49]idNum:50  // arrays should never receive a uniqueID, only records
	[OrderLine:49]orderNum:1:=[Order:3]orderNum:2
	[OrderLine:49]lineNum:3:=aOLineNum{$i}
	[OrderLine:49]itemNum:4:=aOItemNum{$i}
	[OrderLine:49]dateOrdered:25:=Current date:C33
End if 
[OrderLine:49]seq:30:=aOSeq{$i}

[OrderLine:49]customerID:2:=[Order:3]customerID:1
[OrderLine:49]repID:36:=[Order:3]repID:8
[OrderLine:49]salesNameID:37:=[Order:3]salesNameID:10
[OrderLine:49]Company:41:=[Customer:2]company:2

[OrderLine:49]altItem:31:=aOAltItem{$i}
[OrderLine:49]description:5:=aODescpt{$i}
[OrderLine:49]qty:6:=aOQtyOrder{$i}
[OrderLine:49]qtyShipped:7:=aOQtyShip{$i}
[OrderLine:49]qtyBackLogged:8:=aOQtyBL{$i}
[OrderLine:49]unitPrice:9:=aOUnitPrice{$i}
[OrderLine:49]discount:10:=aODiscnt{$i}
[OrderLine:49]extendedPrice:11:=aOExtPrice{$i}
[OrderLine:49]backOrdAmount:26:=aOBackLog{$i}
[OrderLine:49]unitCost:12:=aOUnitCost{$i}
[OrderLine:49]extendedCost:13:=aOExtCost{$i}
[OrderLine:49]taxJuris:14:=aOTaxable{$i}
[OrderLine:49]salesTax:15:=aOSaleTax{$i}
[OrderLine:49]commRep:16:=aORepComm{$i}
[OrderLine:49]commSales:17:=aOSaleComm{$i}
[OrderLine:49]commRateSales:29:=aOSalesRate{$i}
[OrderLine:49]commRateRep:18:=aORepRate{$i}
[OrderLine:49]commRep:16:=aORepComm{$i}
[OrderLine:49]commSales:17:=aOSaleComm{$i}
[OrderLine:49]unitofMeasure:19:=aOUnitMeas{$i}
[OrderLine:49]unitWt:20:=aOUnitWt{$i}
[OrderLine:49]extendedWt:21:=aOExtWt{$i}
[OrderLine:49]location:22:=aOLocation{$i}
[OrderLine:49]serialRc:27:=aOSerialRc{$i}
[OrderLine:49]serialNum:40:=aoSerialNm{$i}
[OrderLine:49]typeSale:28:=aOPricePt{$i}
[OrderLine:49]dateRequired:23:=aoDateReq{$i}
[OrderLine:49]dateShipOn:38:=aoDateShipOn{$i}
[OrderLine:49]dateShipped:39:=aoDateShipped{$i}
[OrderLine:49]producedBy:43:=aoProdBy{$i}
[OrderLine:49]comment:44:=aoLnComment{$i}
//
[OrderLine:49]lineProfile1:45:=aoProfile1{$i}
[OrderLine:49]lineProfile2:46:=aoProfile2{$i}
[OrderLine:49]lineProfile3:47:=aoProfile3{$i}
[OrderLine:49]complete:48:=(aOLnCmplt{$i}#"")
//
[OrderLine:49]qtyCancelled:51:=aOQtyCanceled{$i}
[OrderLine:49]taxCost:55:=aOTaxCost{$i}
[OrderLine:49]printNot:56:=aOPrintThis{$i}
[OrderLine:49]status:58:=aoShipOrdSt{$i}
[OrderLine:49]discountedPrice:64:=aODscntUP{$i}
//OrdLnAdd

If (Is new record:C668([OrderLine:49]))
	READ ONLY:C145([Item:4])
	If (([OrderLine:49]typeItem:24="") | ([OrderLine:49]locationBin:57=""))
		If ([Item:4]itemNum:1#[OrderLine:49]itemNum:4)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=[OrderLine:49]itemNum:4)
		End if 
		If (Records in selection:C76([Item:4])=1)
			[OrderLine:49]typeItem:24:=[Item:4]type:26
			[OrderLine:49]profile1:32:=[Item:4]profile1:35
			[OrderLine:49]profile2:33:=[Item:4]profile2:36
			[OrderLine:49]profile3:34:=[Item:4]profile3:37
			[OrderLine:49]profile4:35:=[Item:4]profile4:38
			[OrderLine:49]class:53:=[Item:4]class:92
			If ([OrderLine:49]locationBin:57#"")
				[OrderLine:49]locationBin:57:=[Item:4]locationBin:113
			End if 
			[OrderLine:49]division:65:=[Item:4]division:119
		End if 
	End if 
	If ([OrderLine:49]itemNum:4="ZZZTEM@")
		If ([OrderLine:49]vendorID:42="")
			If ([Item:4]itemNum:1#[OrderLine:49]itemNum:4)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=[OrderLine:49]itemNum:4)
			End if 
			If (Records in selection:C76([Item:4])=1)
				PUSH RECORD:C176([Customer:2])
				QUERY:C277([Customer:2]; [Customer:2]mfrLocationid:67=[OrderLine:49]location:22)
				[OrderLine:49]vendorID:42:=[Customer:2]customerID:1
				[OrderLine:49]mfrID:52:=[Customer:2]customerID:1
				POP RECORD:C177([Customer:2])
			Else 
				[OrderLine:49]vendorID:42:=[Item:4]vendorID:45
				[OrderLine:49]mfrID:52:=[Item:4]mfrID:53
			End if 
		End if 
	End if 
	REDUCE SELECTION:C351([Item:4]; 0)
End if 
READ WRITE:C146([Item:4])
SAVE RECORD:C53([OrderLine:49])

