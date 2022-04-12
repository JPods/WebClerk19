//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 11/30/11, 17:28:27
// ----------------------------------------------------
// Method: Method: CMAComOrderOneLine
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $createLineItem; $lineNum)
$createLineItem:=$1


READ ONLY:C145([ManufacturerTerm:111])

If ($createLineItem=4)
	$calcOrd:=True:C214
	CREATE RECORD:C68([OrderLine:49])
	
	[OrderLine:49]lineNum:3:=[OrderLine:49]idNum:50
	viOrdLnCnt:=viOrdLnCnt+1
	[OrderLine:49]seq:30:=viOrdLnCnt
	[OrderLine:49]idNumOrder:1:=[Order:3]idNum:2
	//
	[OrderLine:49]itemNum:4:=v4
	[OrderLine:49]qty:6:=vR7
	[OrderLine:49]qtyBackLogged:8:=vAmount
	
	[OrderLine:49]itemNum:4:=[Item:4]itemNum:1
	[OrderLine:49]description:5:="CommWindow Bulk Convertion "+[Item:4]mfrID:53
	[OrderLine:49]location:22:=[Item:4]location:9
	[OrderLine:49]unitWt:20:=[Item:4]weightAverage:8
	[OrderLine:49]unitofMeasure:19:="Comm"
	[OrderLine:49]taxJuris:14:=""
	
	//[OrderLine]ItemNum:="Com"+[Order]mfrID
	//[OrderLine]Description:="Bulk Order Convert"
	//[OrderLine]UnitWt:=0.11
	//[OrderLine]UnitofMeasure:="Comm"
	//[OrderLine]taxID:=""
	
	//v4:=[OrderLine]ItemNum
	[OrderLine:49]unitPrice:9:=1
	[OrderLine:49]extendedPrice:11:=vR7
	[OrderLine:49]unitCost:12:=1-(vR2*0.01)
	[OrderLine:49]extendedCost:13:=Round:C94([OrderLine:49]unitCost:12*vR7; <>tcDecimalTt)
	[OrderLine:49]discount:10:=0
	
	[OrderLine:49]commRateSales:29:=Round:C94((vR1-vR3)/vAmount*100; 1)
	[OrderLine:49]commRateRep:18:=Round:C94(vR3/vAmount*100; 1)
	
	[OrderLine:49]commRep:16:=Round:C94([OrderLine:49]commRateRep:18*vR7*0.01; <>tcDecimalTt)
	[OrderLine:49]commSales:17:=Round:C94([OrderLine:49]commRateSales:29*vR7*0.01; <>tcDecimalTt)
	
	[OrderLine:49]extendedWt:21:=0
	[OrderLine:49]salesTax:15:=0
	
	//   
	If ([Order:3]flow:134=0)
		[Order:3]flow:134:=2
	End if 
	[Order:3]weightEstimate:49:=0
	[Order:3]grossMargin:47:=0
	[Order:3]shipTotal:30:=0
	[Order:3]salesTax:28:=0
	[Order:3]totalCost:42:=[OrderLine:49]extendedCost:13
	[Order:3]amount:24:=[OrderLine:49]qtyBackLogged:8
	[Order:3]repCommission:9:=[OrderLine:49]commRep:16
	[Order:3]salesCommission:11:=[OrderLine:49]commSales:17
	[Order:3]total:27:=[OrderLine:49]extendedPrice:11
	[Order:3]amountBackLog:54:=[OrderLine:49]backOrdAmount:26
	
	If ([Order:3]amountBackLog:54#Old:C35([Order:3]amountBackLog:54))
		[Customer:2]balanceOpenOrders:78:=[Order:3]amountBackLog:54-Old:C35([Order:3]amountBackLog:54)
	End if 
	SAVE RECORD:C53([OrderLine:49])
	SAVE RECORD:C53([Order:3])
Else 
	
	
	doNewOrd:=False:C215
	
	//zzzCheckThis   // Modified by: williamjames (9/30/09)
	
	srOrd:=[Order:3]idNum:2
	//
	[Order:3]labelCount:32:=1
	LoadCustOrder
	REDUCE SELECTION:C351([Invoice:26]; 0)
	REDUCE SELECTION:C351([Payment:28]; 0)
	C_BOOLEAN:C305($calcOrd)
	Case of 
		: ($createLineItem=1)
			$calcOrd:=True:C214
			[Order:3]dateNeeded:5:=vDate3
			[Order:3]dateShipOn:31:=vDate3-[Customer:2]shippingDays:22
			[Order:3]dateDocument:4:=vDate2
			[Order:3]dateCancel:53:=vDate4
			[Order:3]taxJuris:43:=""  //no tax add for commissions
			[Order:3]terms:23:=v1
			[Order:3]repID:8:=v5
			[Order:3]salesNameID:10:=[Customer:2]salesNameID:59
			[Order:3]typeSale:22:=v2
			[Order:3]adSource:41:=v3
			[Order:3]autoFreight:40:=False:C215  //no freight calculation
			[Order:3]customerPO:3:=srCustPo
			[Order:3]mfrOrdNum:51:=srMfgOrd
			[Order:3]mfrID:52:=<>aMfg{<>aMfg}
			//      DscntSpecialClr ([Order]TypeSale)
			
			CREATE RECORD:C68([OrderLine:49])
			
			[OrderLine:49]lineNum:3:=[OrderLine:49]idNum:50
			[OrderLine:49]idNumOrder:1:=[Order:3]idNum:2
			[OrderLine:49]seq:30:=[OrderLine:49]idNum:50
			
			[OrderLine:49]qty:6:=vR7
			[OrderLine:49]qtyBackLogged:8:=vR7
			If ([Item:4]itemNum:1#v4)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=v4)
			End if 
			[OrderLine:49]itemNum:4:=[Item:4]itemNum:1
			[OrderLine:49]description:5:=[Item:4]description:7
			[OrderLine:49]location:22:=[Item:4]location:9
			[OrderLine:49]unitofMeasure:19:="Comm"
			[OrderLine:49]taxJuris:14:=""
			[OrderLine:49]unitWt:20:=[Item:4]weightAverage:8
			
			[OrderLine:49]unitPrice:9:=1
			[OrderLine:49]extendedPrice:11:=vR7
			[OrderLine:49]unitCost:12:=1-(vR2*0.01)
			[OrderLine:49]extendedCost:13:=Round:C94([OrderLine:49]unitCost:12*vR7; <>tcDecimalTt)
			[OrderLine:49]discount:10:=0
			
			[OrderLine:49]commRep:16:=Round:C94(vR3; <>tcDecimalTt)
			[OrderLine:49]commSales:17:=Round:C94(vR1-vR3; <>tcDecimalTt)
			[OrderLine:49]commRateSales:29:=Round:C94((vR1-vR3)/vAmount*100; 1)
			[OrderLine:49]commRateRep:18:=Round:C94(vR3/vAmount*100; 1)
			
			[OrderLine:49]extendedWt:21:=0
			[OrderLine:49]salesTax:15:=0
			[OrderLine:49]backOrdAmount:26:=vR7
			
			SAVE RECORD:C53([OrderLine:49])
			//   
			If ([Order:3]flow:134=0)
				[Order:3]flow:134:=2
			End if 
		: ($createLineItem=2)
			$calcOrd:=False:C215
			
			
	End case 
	[Order:3]weightEstimate:49:=0
	[Order:3]grossMargin:47:=0
	[Order:3]shipTotal:30:=0
	[Order:3]salesTax:28:=0
	TRACE:C157
	If ($calcOrd)
		[Order:3]totalCost:42:=[OrderLine:49]extendedCost:13
		[Order:3]amount:24:=[OrderLine:49]extendedPrice:11
		[Order:3]repCommission:9:=[OrderLine:49]commRep:16
		[Order:3]salesCommission:11:=[OrderLine:49]commSales:17
		[Order:3]total:27:=[OrderLine:49]extendedPrice:11
		[Order:3]amountBackLog:54:=[OrderLine:49]backOrdAmount:26
		
	End if 
	If ([Order:3]amountBackLog:54#Old:C35([Order:3]amountBackLog:54))
		[Customer:2]balanceOpenOrders:78:=[Order:3]amountBackLog:54-Old:C35([Order:3]amountBackLog:54)
	End if 
End if 
//
[Order:3]lng:34:=DateTime_Enter
SAVE RECORD:C53([Order:3])