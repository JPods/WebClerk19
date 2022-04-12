//%attributes = {"publishedWeb":true}
//Procedure: Tally_dInvent
//need to capture price in dInventory
C_LONGINT:C283($i; $k; $0; $stakDT; $earlyDT; $PeriodEnd)
C_TEXT:C284($tallyItem; $curItem)
C_TEXT:C284($tallyType)
C_TEXT:C284($tallyDescri)
C_BOOLEAN:C305($stopLoop)
$stopLoop:=False:C215
$stakDT:=DateTime_Enter
READ WRITE:C146([DInventory:36])
READ WRITE:C146([Usage:5])
QUERY:C277([DInventory:36]; [DInventory:36]dtStack:17=0)
$k:=Records in selection:C76([DInventory:36])
If ($k=0)
	$0:=0
Else 
	ORDER BY:C49([DInventory:36]; [DInventory:36]itemNum:1; [DInventory:36]dtCreated:15)
	FIRST RECORD:C50([DInventory:36])
	$earlyDT:=[DInventory:36]dtCreated:15
	jDateTimeRecov([DInventory:36]dtCreated:15; ->vdDateBeg; ->complTime)
	//
	$PeriodDate:=Date_ThisMon(vdDateBeg; 0)
	$PeriodEnd:=DateTime_Enter(Date_ThisMon($PeriodDate; 1)+1; ?00:00:00?)
	
	//
	//$PeriodDate:=Date(String(Month of(vdDateBeg))+"/1/"+String(Year of
	//(vdDateBeg)))
	//$PeriodEnd:=DateTime_Enter (Date(String(Month of($PeriodDate+31))+"/1/"
	//+String(Year of($PeriodDate+31)));00:00:00)
	$k:=Records in selection:C76([DInventory:36])
	$i:=0
	$CurPart:=Char:C90(9)
	//ThermoInitExit ("Converting inventory changes.";$k;True)
	$viProgressID:=Progress New
	Repeat 
		$i:=$i+1
		//Thermo_Update ($i)
		ProgressUpdate($viProgressID; $i; $k; "Converting inventory changes.")
		If (<>ThermoAbort)
			$stopLoop:=True:C214
		End if 
		LOAD RECORD:C52([DInventory:36])  //I don't think this is needed
		If (Not:C34(Locked:C147([DInventory:36])))
			If ([DInventory:36]dtCreated:15<$earlyDT)
				$earlyDT:=[DInventory:36]dtCreated:15
			End if 
			[DInventory:36]dtStack:17:=$stakDT
			SAVE RECORD:C53([DInventory:36])
			//
			If ([Item:4]itemNum:1#[DInventory:36]itemNum:1)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=[DInventory:36]itemNum:1)
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
				jDateTimeRecov([DInventory:36]dtCreated:15; ->vdDateBeg; ->complTime)  //different item reject the month
				
				$PeriodDate:=Date_ThisMon(vdDateBeg; 0)
				$PeriodEnd:=DateTime_Enter(Date_ThisMon($PeriodDate; 1)+1; ?00:00:00?)
				
			End if 
			If ([DInventory:36]dtCreated:15>$PeriodEnd)  //same item but different month
				jDateTimeRecov([DInventory:36]dtCreated:15; ->vdDateBeg; ->complTime)
				//
				$PeriodDate:=Date_ThisMon(vdDateBeg; 0)
				$PeriodEnd:=DateTime_Enter(Date_ThisMon($PeriodDate; 1)+1; ?00:00:00?)
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
				: ([DInventory:36]typeID:14[[1]]="S")
					[Usage:5]numOrders:19:=[Usage:5]numOrders:19+1
					If ([DInventory:36]takeAction:19#3)
						[Usage:5]ordQtyActual:26:=[Usage:5]ordQtyActual:26+[DInventory:36]qtyOnSO:3
						[Usage:5]ordersActual:20:=[Usage:5]ordersActual:20+([DInventory:36]qtyOnSO:3*[DInventory:36]unitPrice:21)
					End if 
					//
				: ([DInventory:36]typeID:14[[1]]="i")  //S for sales order
					If (([DInventory:36]receiptid:11=1) | ([DInventory:36]takeAction:19=4))  //POS Invoice, both order and invoice
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
		End if 
		NEXT RECORD:C51([DInventory:36])
	Until (($i=$k) | ($stopLoop))
	If (Modified record:C314([Usage:5]))
		SAVE RECORD:C53([Usage:5])
	End if 
	UNLOAD RECORD:C212([Usage:5])
	$0:=$earlyDT
	//Thermo_Close 
	Progress QUIT($viProgressID)
End if 
READ ONLY:C145([DInventory:36])
UNLOAD RECORD:C212([DInventory:36])
UNLOAD RECORD:C212([Usage:5])