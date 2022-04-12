//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): William James
// Date and time: 2014-08-29T00:00:00, 05:58:16
// ----------------------------------------------------
// Method: TallySumOrdSale
// Description
// Modified: 08/29/14
// Structure: CEv13_131005
// Tallys Usage records into Usagesummaries
//
// Parameters
// ----------------------------------------------------
If (UserInPassWordGroup("Archive"))
	//(P)  TallySumOrdSale
	C_LONGINT:C283($i; $k)
	C_BOOLEAN:C305($stopLoop)
	C_DATE:C307($BegDate; $CurPeriod; $1)
	C_REAL:C285($QtyPlan; $QtyAct; $InventPlan; $InventAct; $ScrapPlan; $ScrapAct; $SalesPlan; $SalesAct)
	C_REAL:C285($NumInv; $CostAct; $CostPlan; $NumOrders; $OrdersAct; $OrdersPlan; $TargetTurns)
	C_REAL:C285($AvgTurns; $DollarPO; $QtyPO; $DollarAdj; $QtyAdj; $OrdQtyPlan; $OrdQtyAct)
	$stopLoop:=False:C215
	$BegDate:=Date_ThisMon($1; 0)
	QUERY:C277([Usage:5]; [Usage:5]PeriodDate:2>=$BegDate; *)
	QUERY:C277([Usage:5];  & [Usage:5]Purpose:34="Monthly")
	If (Records in selection:C76([Usage:5])>0)
		ORDER BY:C49([Usage:5]; [Usage:5]PeriodDate:2)
		FIRST RECORD:C50([Usage:5])
		$k:=Records in selection:C76([Usage:5])
		//ThermoInitExit ("Processing Usage Records";$k;True)
		$viProgressID:=Progress New
		
		
		$i:=0
		Repeat 
			$CurPeriod:=[Usage:5]PeriodDate:2
			$QtyPlan:=0
			$QtyAct:=0
			$InventPlan:=0
			$InventAct:=0
			$ScrapPlan:=0
			$ScrapAct:=0
			$SalesPlan:=0
			$SalesAct:=0
			$NumInv:=0
			$CostAct:=0
			$CostPlan:=0
			$NumOrders:=0
			$OrdersAct:=0
			$OrdersPlan:=0
			$TargetTurns:=0
			$AvgTurns:=0
			$DollarPO:=0
			$QtyPO:=0
			$DollarAdj:=0
			$QtyAdj:=0
			$OrdQtyPlan:=0
			$OrdQtyAct:=0
			While ([Usage:5]PeriodDate:2=$CurPeriod)
				$i:=$i+1
				$QtyPlan:=$QtyPlan+[Usage:5]SalesQtyPlan:3
				$QtyAct:=$QtyAct+[Usage:5]SalesQtyActual:4
				$InventPlan:=$InventPlan+[Usage:5]InventoryPlan:5
				$InventAct:=$InventAct+[Usage:5]InventoryActual:6
				$ScrapPlan:=$ScrapPlan+[Usage:5]ScrapPlan:7
				$ScrapAct:=$ScrapAct+[Usage:5]ScrapActual:8
				$SalesPlan:=$SalesPlan+[Usage:5]SalesPlan:9
				$SalesAct:=$SalesAct+[Usage:5]SalesActual:10
				$NumInv:=$NumInv+[Usage:5]NumInvoices:16
				$CostAct:=$CostAct+[Usage:5]CostActual:17
				$CostPlan:=$CostPlan+[Usage:5]CostPlan:18
				$NumOrders:=$NumOrders+[Usage:5]NumOrders:19
				$OrdersAct:=$OrdersAct+[Usage:5]OrdersActual:20
				$OrdersPlan:=$OrdersPlan+[Usage:5]OrdersPlan:21
				$OrdQtyPlan:=$OrdQtyPlan+[Usage:5]OrdQtyPlan:27
				$OrdQtyAct:=$OrdQtyAct+[Usage:5]OrdQtyActual:26
				//
				$DollarPO:=$DollarPO+[Usage:5]PurchaseValue:30
				$QtyPO:=$QtyPO+[Usage:5]PurchaseQty:29
				$DollarAdj:=$DollarAdj+[Usage:5]AdjustmentValue:32
				$QtyAdj:=$QtyAdj+[Usage:5]AdjustmentQty:31
				//
				$TargetTurns:=Round:C94((($TargetTurns*$i)+[Usage:5]TargetTurns:22)/$i; 2)
				$AvgTurns:=Round:C94((($AvgTurns*$i)+[Usage:5]ActualTurns:24)/$i; 2)
				NEXT RECORD:C51([Usage:5])
			End while 
			//Thermo_Update ($i)
			ProgressUpdate($viProgressID; $i; $k; "Processing Usage Records")
			
			If (<>ThermoAbort)
				$stopLoop:=False:C215
			End if 
			QUERY:C277([UsageSummary:33]; [UsageSummary:33]PeriodDate:2=$CurPeriod)
			If (Records in selection:C76([UsageSummary:33])=0)
				CREATE RECORD:C68([UsageSummary:33])
				
				[UsageSummary:33]PeriodDate:2:=$CurPeriod
			End if 
			[UsageSummary:33]OrdQtyPlan:28:=Trunc:C95($OrdQtyPlan; 0)
			[UsageSummary:33]SalesQtyPlan:3:=Trunc:C95($QtyPlan; 0)
			[UsageSummary:33]InventoryPlan:5:=Trunc:C95($InventPlan; 0)
			[UsageSummary:33]ScrapPlan:7:=Trunc:C95($ScrapPlan; 0)
			[UsageSummary:33]SalesPlan:9:=Trunc:C95($SalesPlan; 0)
			[UsageSummary:33]CostPlan:18:=Trunc:C95($CostPlan; 0)
			[UsageSummary:33]OrdersPlan:21:=Trunc:C95($OrdersPlan; 0)
			[UsageSummary:33]TargetTurns:22:=Trunc:C95($TargetTurns; 1)
			[UsageSummary:33]OrdQtyActual:27:=Trunc:C95($OrdQtyAct; 0)
			[UsageSummary:33]SalesQtyActual:4:=Trunc:C95($QtyAct; 0)
			[UsageSummary:33]InventoryActual:6:=Trunc:C95($InventAct; 0)
			[UsageSummary:33]ScrapActual:8:=Trunc:C95($ScrapAct; 0)
			[UsageSummary:33]SalesActual:10:=Trunc:C95($SalesAct; 0)
			[UsageSummary:33]DateCalculated:12:=Current date:C33
			[UsageSummary:33]TimeCalculated:13:=Current time:C178
			[UsageSummary:33]Capacity:14:=-1
			[UsageSummary:33]NumInvoices:16:=Trunc:C95($NumInv; 0)
			[UsageSummary:33]CostActual:17:=Trunc:C95($CostAct; 0)
			[UsageSummary:33]NumOrders:19:=Trunc:C95($NumOrders; 0)
			[UsageSummary:33]OrdersActual:20:=Trunc:C95($OrdersAct; 0)
			[UsageSummary:33]AverageTurns:23:=Trunc:C95($AvgTurns; 1)
			//
			[UsageSummary:33]PurchaseValue:31:=Trunc:C95($DollarPO; 0)
			[UsageSummary:33]PurchaseQty:30:=Trunc:C95($QtyPO; 0)
			[UsageSummary:33]AdjustmentValue:33:=Trunc:C95($DollarAdj; 0)
			[UsageSummary:33]AdjustmentQty:32:=Trunc:C95($QtyAdj; 0)
			//
			If ([UsageSummary:33]InventoryActual:6>0)
				[UsageSummary:33]ActualTurns:24:=Round:C94(([UsageSummary:33]CostActual:17/[UsageSummary:33]InventoryActual:6)*12; 1)
			Else 
				[UsageSummary:33]ActualTurns:24:=0
			End if 
			If ([UsageSummary:33]SalesActual:10>0)
				[UsageSummary:33]MarginFactor:15:=Round:C94((([UsageSummary:33]SalesActual:10-[UsageSummary:33]CostActual:17)/[UsageSummary:33]SalesActual:10)*[UsageSummary:33]ActualTurns:24; 1)
			Else 
				[UsageSummary:33]MarginFactor:15:=0
			End if 
			SAVE RECORD:C53([UsageSummary:33])
		Until (($i>=$k) | ($stopLoop))
		//Thermo_Close 
		Progress QUIT($viProgressID)
	End if 
	UNLOAD RECORD:C212([Usage:5])
	UNLOAD RECORD:C212([UsageSummary:33])
End if 
