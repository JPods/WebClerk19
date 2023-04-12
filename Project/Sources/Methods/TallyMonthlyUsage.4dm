//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2014-12-10T00:00:00, 14:14:10
// ----------------------------------------------------
// Method: TallyMonthlyUsage
// Description
// Modified: 12/10/14
// Structure: CEv13_131005
// Tally dInventory records into Usage records
//
// Parameters
// ----------------------------------------------------

If (False:C215)
	For (vi1; 1; vi2)
		vDate1:=Date:C102(String:C10(vi1)+"/1/2014")
		TallyMonthlyUsage(vDate1; True:C214)
	End for 
End if 


C_DATE:C307($1; $TallyMonth)
C_DATE:C307($PeriodDate)
C_LONGINT:C283($PeriodStart; $PeriodEnd; $i; $k)
C_TEXT:C284($tallyItem; $curItem)
C_TEXT:C284($tallyType)
C_TEXT:C284($tallyDescri)
C_BOOLEAN:C305($stopLoop; $retallyMonths; $2; $3; $useSelection)  // ### jwm ### 20160830_1605 

$TallyMonth:=$1
$retallyMonths:=$2

If (Count parameters:C259=3)  // ### jwm ### 20160830_1612
	$useSelection:=$3
Else 
	$useSelection:=False:C215
End if 

$PeriodDate:=Date_ThisMon($TallyMonth; 0)
$PeriodStart:=DateTime_DTTo(Date_ThisMon($TallyMonth; 0); ?00:00:00?)
$PeriodEnd:=DateTime_DTTo(Date_ThisMon($TallyMonth; 1)+1; ?23:59:59?)

//delete previous usages
//QUERY([Usage];[Usage]PeriodDate=$PeriodDate)
//DELETE SELECTION([Usage])

If ($useSelection)
	QUERY SELECTION:C341([DInventory:36]; [DInventory:36]dtCreated:15>=$PeriodStart; *)
	QUERY SELECTION:C341([DInventory:36];  & ; [DInventory:36]dtCreated:15<=$PeriodEnd)
Else 
	QUERY:C277([DInventory:36]; [DInventory:36]dtCreated:15>=$PeriodStart; *)
	QUERY:C277([DInventory:36];  & ; [DInventory:36]dtCreated:15<=$PeriodEnd)
End if 

$k:=Records in selection:C76([DInventory:36])
If ($k>0)
	ORDER BY:C49([DInventory:36]; [DInventory:36]itemNum:1)
	$i:=0
	$CurPart:=Char:C90(9)
	//ThermoInitExit ("Converting inventory changes.";$k;True)
	$viProgressID:=Progress New
	
	Repeat 
		$i:=$i+1
		//Thermo_Update ($i)
		ProgressUpdate($viProgressID; $i; $k; "Converting inventory changes")
		If (<>ThermoAbort)
			$stopLoop:=True:C214
		End if 
		LOAD RECORD:C52([DInventory:36])  //I don't think this is needed    
		If ([Item:4]itemNum:1#[DInventory:36]itemNum:1)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=[DInventory:36]itemNum:1)
		End if   // ### jwm ### 20190429_1348
		
		Case of 
			: (Records in selection:C76([Item:4])=0)
				$tallyItem:="NotDefined"
				$tallyType:="NotDefined"
				$tallyDescri:="NotDefined"
			: ([Item:4]tallyByType:19)
				$tallyItem:=[Item:4]type:26
				$tallyType:=[Item:4]type:26
				$tallyDescri:=[Item:4]type:26
			Else 
				$tallyItem:=[DInventory:36]itemNum:1
				$tallyType:=[Item:4]type:26
				$tallyDescri:=[Item:4]description:7
		End case 
		DateTime_DTFrom([DInventory:36]dtCreated:15; ->vdDateBeg; ->complTime)  //different item reject the month
		
		$PeriodDate:=Date_ThisMon(vdDateBeg; 0)
		$PeriodEnd:=DateTime_DTTo(Date_ThisMon($PeriodDate; 1)+1; ?00:00:00?)
		
		
		If ([DInventory:36]dtCreated:15>$PeriodEnd)  //same item but different month
			DateTime_DTFrom([DInventory:36]dtCreated:15; ->vdDateBeg; ->complTime)
			//
			$PeriodDate:=Date_ThisMon(vdDateBeg; 0)
			$PeriodEnd:=DateTime_DTTo(Date_ThisMon($PeriodDate; 1)+1; ?00:00:00?)
			//        
		End if 
		If (([Usage:5]periodDate:2#$PeriodDate) | ([Usage:5]itemNum:1#$tallyItem))
			If (Modified record:C314([Usage:5]))
				[Usage:5]timeCalculated:13:=Current time:C178
				[Usage:5]dateCalculated:12:=Current date:C33
				SAVE RECORD:C53([Usage:5])
			End if 
			QUERY:C277([Usage:5]; [Usage:5]itemNum:1=$tallyItem; *)
			QUERY:C277([Usage:5];  & [Usage:5]periodDate:2=$PeriodDate)
			If (Records in selection:C76([Usage:5])=0)
				CREATE RECORD:C68([Usage:5])
				[Usage:5]itemNum:1:=$tallyItem
				[Usage:5]periodDate:2:=$PeriodDate
				
				[Usage:5]description:11:=$tallyDescri
				[Usage:5]typeID:33:=$tallyType
				[Usage:5]purpose:34:="Monthly"
				[Usage:5]dateEnd:35:=Date_ThisMon([Usage:5]periodDate:2; 1)
			End if 
		End if 
		Case of 
			: ([DInventory:36]typeID:14="")
			: ([DInventory:36]typeID:14[[1]]="B")
				If ([DInventory:36]takeAction:19=1)
					[Usage:5]bOMQtyActual:36:=[Usage:5]bOMQtyActual:36-[DInventory:36]qtyOnHand:2
				End if 
			: ([DInventory:36]typeID:14[[1]]="S")
				[Usage:5]numOrders:19:=[Usage:5]numOrders:19+1
				If ([DInventory:36]takeAction:19#3)
					[Usage:5]ordQtyActual:26:=[Usage:5]ordQtyActual:26+[DInventory:36]qtyOnSO:3
					[Usage:5]ordersActual:20:=[Usage:5]ordersActual:20+([DInventory:36]qtyOnSO:3*[DInventory:36]unitPrice:21)
				End if 
				//
			: ([DInventory:36]typeID:14[[1]]="i")  //S for sales order
				If (([DInventory:36]idReceipt:11=1) | ([DInventory:36]takeAction:19=4))  //POS Invoice, both order and invoice
					[Usage:5]numOrders:19:=[Usage:5]numOrders:19+1
					[Usage:5]ordQtyActual:26:=[Usage:5]ordQtyActual:26+[DInventory:36]qtyOnSO:3
					[Usage:5]ordersActual:20:=[Usage:5]ordersActual:20+([DInventory:36]qtyOnSO:3*[DInventory:36]unitPrice:21)
				End if 
				[Usage:5]numInvoices:16:=[Usage:5]numInvoices:16+1
				[Usage:5]salesQtyActual:4:=[Usage:5]salesQtyActual:4-[DInventory:36]qtyOnHand:2
				[Usage:5]salesActual:10:=[Usage:5]salesActual:10-([DInventory:36]qtyOnHand:2*[DInventory:36]unitPrice:21)
				[Usage:5]costActual:17:=[Usage:5]costActual:17-([DInventory:36]qtyOnHand:2*[DInventory:36]unitCost:7)
				//
			: ([DInventory:36]typeID:14[[1]]="P")  //P for Purchase Receipt
				Case of 
					: ([DInventory:36]takeAction:19=3)
						//no effect              
					: ([DInventory:36]takeAction:19=4)
						[Usage:5]purchaseQty:29:=[Usage:5]purchaseQty:29+[DInventory:36]qtyOnHand:2+[DInventory:36]qtyOnPo:4
						[Usage:5]purchaseValue:30:=[Usage:5]purchaseValue:30+(([DInventory:36]qtyOnHand:2+[DInventory:36]qtyOnPo:4)*[DInventory:36]unitCost:7)
					Else 
						[Usage:5]purchaseQty:29:=[Usage:5]purchaseQty:29+[DInventory:36]qtyOnHand:2
						[Usage:5]purchaseValue:30:=[Usage:5]purchaseValue:30+([DInventory:36]qtyOnHand:2*[DInventory:36]unitCost:7)
				End case 
			: ([DInventory:36]typeID:14[[1]]="W")  //W for Work Receipt
				
			: (([DInventory:36]typeID:14[[1]]="A") | ([DInventory:36]typeID:14[[1]]="B"))  //A and else for adjustments
				[Usage:5]adjustmentQty:31:=[Usage:5]adjustmentQty:31+[DInventory:36]qtyOnHand:2
				[Usage:5]adjustmentValue:32:=[Usage:5]adjustmentValue:32+Round:C94([DInventory:36]qtyOnHand:2*[DInventory:36]unitCost:7; 2)
		End case 
		If ([DInventory:36]reason:13="scrap")
			[Usage:5]scrapActual:8:=[Usage:5]scrapActual:8-Round:C94([DInventory:36]qtyOnHand:2*[DInventory:36]unitCost:7; 2)
		End if 
		//      could tighten this up, only needed once per Usage record
		If ([Usage:5]inventoryActual:6>0)
			[Usage:5]actualTurns:24:=([Usage:5]costActual:17/[Usage:5]inventoryActual:6)*12
		Else 
			[Usage:5]actualTurns:24:=0
		End if 
		If ([Usage:5]salesActual:10>0)
			[Usage:5]marginFactor:15:=Round:C94((([Usage:5]salesActual:10-[Usage:5]costActual:17)/[Usage:5]salesActual:10)*[Usage:5]actualTurns:24; 1)
		Else 
			[Usage:5]salesActual:10:=0
		End if 
		//
		NEXT RECORD:C51([DInventory:36])
	Until (($i=$k) | ($stopLoop))
	
	If (Modified record:C314([Usage:5]))
		SAVE RECORD:C53([Usage:5])
	End if 
	UNLOAD RECORD:C212([Usage:5])
	//Thermo_Close 
	Progress QUIT($viProgressID)
	
	READ ONLY:C145([DInventory:36])
	UNLOAD RECORD:C212([DInventory:36])
	UNLOAD RECORD:C212([Usage:5])
Else 
	If ($retallyMonths=False:C215)
		ALERT:C41("No dInventory records found for that month!")
	End if 
End if 

