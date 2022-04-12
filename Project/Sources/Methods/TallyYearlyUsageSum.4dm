//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 01/04/18, 16:12:34
// ----------------------------------------------------
// Method: TallyYearlyUsageSum
// Description
// 
//
// Parameters
// ----------------------------------------------------


If (False:C215)
	//Date: 04/24/02
	//Who:Janani
	//Description: Added the report generation to tally full year in Usage Sum
	VERSION_960
End if 
TRACE:C157

C_DATE:C307($1; $sDate; $eDate; $2)
C_LONGINT:C283($vLoop; $k; $Count)

$sDate:=$1
$eDate:=$2

//delete previous UsageSum for this year
QUERY:C277([UsageSummary:33]; [UsageSummary:33]periodDate:2=$sDate)

$Count:=Records in selection:C76([UsageSummary:33])
DELETE SELECTION:C66([UsageSummary:33])

//get all the records from Usage that is already generated for the year specified
QUERY:C277([Usage:5]; [Usage:5]periodDate:2>=$sDate; *)
QUERY:C277([Usage:5];  & ; [Usage:5]periodDate:2<=$eDate)
$k:=Records in selection:C76([Usage:5])
If ($k>0)
	FIRST RECORD:C50([Usage:5])
	For ($vLoop; 1; $k)
		If (Modified record:C314([UsageSummary:33]))
			[UsageSummary:33]timeCalculated:13:=Current time:C178
			[UsageSummary:33]dateCalculated:12:=Current date:C33
			SAVE RECORD:C53([UsageSummary:33])
		End if 
		QUERY:C277([UsageSummary:33]; [UsageSummary:33]itemNum:34=[Usage:5]itemNum:1; *)
		QUERY:C277([UsageSummary:33];  & ; [UsageSummary:33]periodDate:2=$sDate)
		
		If (Records in selection:C76([UsageSummary:33])=0)  //if the item in Usage does not exists in Usage Sum add it
			CREATE RECORD:C68([UsageSummary:33])
			[UsageSummary:33]itemNum:34:=[Usage:5]itemNum:1
			[UsageSummary:33]periodDate:2:=$sDate
			
			[UsageSummary:33]description:36:=[Usage:5]description:11
			[UsageSummary:33]typeid:37:=[Usage:5]typeid:33
			
			[UsageSummary:33]bOMQtyActual:38:=[Usage:5]bOMQtyActual:36
			[UsageSummary:33]numOrders:19:=[Usage:5]numOrders:19
			[UsageSummary:33]ordQtyActual:27:=[Usage:5]ordQtyActual:26
			[UsageSummary:33]ordersActual:20:=[Usage:5]ordersActual:20
			[UsageSummary:33]numInvoices:16:=[Usage:5]numInvoices:16
			[UsageSummary:33]salesQtyActual:4:=[Usage:5]salesQtyActual:4
			[UsageSummary:33]salesActual:10:=[Usage:5]salesActual:10
			[UsageSummary:33]costActual:17:=[Usage:5]costActual:17
			[UsageSummary:33]purchaseQty:30:=[Usage:5]purchaseQty:29
			[UsageSummary:33]purchaseValue:31:=[Usage:5]purchaseValue:30
			[UsageSummary:33]adjustmentQty:32:=[Usage:5]adjustmentQty:31
			[UsageSummary:33]adjustmentValue:33:=[Usage:5]adjustmentValue:32
			[UsageSummary:33]actualTurns:24:=[Usage:5]actualTurns:24
			SAVE RECORD:C53([UsageSummary:33])
		Else   //if the item already exists then add the entries for SOs, BOMs and others
			[UsageSummary:33]bOMQtyActual:38:=[UsageSummary:33]bOMQtyActual:38+[Usage:5]bOMQtyActual:36
			[UsageSummary:33]numOrders:19:=[UsageSummary:33]numOrders:19+[Usage:5]numOrders:19
			[UsageSummary:33]ordQtyActual:27:=[UsageSummary:33]ordQtyActual:27+[Usage:5]ordQtyActual:26
			[UsageSummary:33]ordersActual:20:=[UsageSummary:33]ordersActual:20+[Usage:5]ordersActual:20
			[UsageSummary:33]numInvoices:16:=[UsageSummary:33]numInvoices:16+[Usage:5]numInvoices:16
			[UsageSummary:33]salesQtyActual:4:=[UsageSummary:33]salesQtyActual:4+[Usage:5]salesQtyActual:4
			[UsageSummary:33]salesActual:10:=[UsageSummary:33]salesActual:10+[Usage:5]salesActual:10
			[UsageSummary:33]costActual:17:=[UsageSummary:33]costActual:17+[Usage:5]costActual:17
			[UsageSummary:33]purchaseQty:30:=[UsageSummary:33]purchaseQty:30+[Usage:5]purchaseQty:29
			[UsageSummary:33]purchaseValue:31:=[UsageSummary:33]purchaseValue:31+[Usage:5]purchaseValue:30
			[UsageSummary:33]adjustmentQty:32:=[UsageSummary:33]adjustmentQty:32+[Usage:5]adjustmentQty:31
			[UsageSummary:33]adjustmentValue:33:=[UsageSummary:33]adjustmentValue:33+[Usage:5]adjustmentValue:32
			[UsageSummary:33]actualTurns:24:=[UsageSummary:33]actualTurns:24+[Usage:5]actualTurns:24
		End if 
		
		NEXT RECORD:C51([Usage:5])
	End for 
	
	If (Modified record:C314([UsageSummary:33]))
		SAVE RECORD:C53([UsageSummary:33])
	End if 
	UNLOAD RECORD:C212([UsageSummary:33])
Else 
	ALERT:C41("No records found")  //display meesage if no records exists in Usage
End if 