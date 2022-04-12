//%attributes = {"publishedWeb":true}
//Procedure: Ledger_TallyBal
var $1; $oCust; $oSel; $oLedger; $oGarbage : Object

If (Count parameters:C259=0)
	If (process_o.tableName="Customer")
		$oCust:=process_o.cur
	End if 
Else 
	$oCust:=$1
End if 
If ($oCust#Null:C1517)
	C_LONGINT:C283($w; $dueDays; $ivcDays; $i; $ris)
	C_REAL:C285($future; $dueNow; $past30; $past60; $past90)
	C_DATE:C307($curDate)
	$curDate:=Current date:C33  // just in case done at midnight
	
	$oSel:=ds:C1482.Ledger.query("customerID = :1 & unAppliedValue # :2"; $oCust.customerID; 0)
	
	$oCust.balanceCurrent:=0
	$oCust.balanceDue:=0
	$oCust.balPastPeriod1:=0
	$oCust.balPastPeriod2:=0
	$oCust.balPastPeriod3:=0
	$oCust.futureDue:=0
	$future:=0
	$dueNow:=0
	$past30:=0
	$past60:=0
	$past90:=0
	C_REAL:C285(vrFinanceCharge)
	vrFinanceCharge:=0
	var $tableNum : Integer
	$tableNum:=ds:C1482.Ledger.getInfo().tableNumber
	For each ($oLedger; $oSel)
		$oGarbage:=ds:C1482.zzzGarbage.query("tableNum = :1 & id = :2"; $tableNum; $oLedger.id)
		If ($oGarbage=Null:C1517)  // confirm this ledger was not locked during a .drop effort
			Case of 
				: (($curDate+30)<$oLedger.dateDue)  //&($oLedger.CreatingDocType#"Pay"))//future
					$future:=$future+$oLedger.unAppliedValue
					//ConsoleMessage("Future\t"+String($oLedger.DocRefID)+"\t"+String(Current Date)+"\t"+String($oLedger.DateDue)+"\t"+String(Current Date - $oLedger.DateDue))
				: ($curDate<$oLedger.dateDue)  // NOT PAST DUE //|($oLedger.CreatingDocType="Pay"))//current
					$dueNow:=$dueNow+$oLedger.unAppliedValue
					//ConsoleMessage("Due Now\t"+String($oLedger.DocRefID)+"\t"+String(Current Date)+"\t"+String($oLedger.DateDue)+"\t"+String(Current Date - $oLedger.DateDue))
					
				: (($curDate-30)<$oLedger.dateDue)  //> zero < 30
					$past30:=$past30+$oLedger.unAppliedValue
					//ConsoleMessage("Past 30\t"+String($oLedger.DocRefID)+"\t"+String(Current Date)+"\t"+String($oLedger.DateDue)+"\t"+String(Current Date - $oLedger.DateDue))
					
				: (($curDate-60)<$oLedger.dateDue)  //> 30 < 60
					$past60:=$past60+$oLedger.unAppliedValue
					//ConsoleMessage("Past 60\t"+String($oLedger.DocRefID)+"\t"+String(Current Date)+"\t"+String($oLedger.DateDue)+"\t"+String(Current Date - $oLedger.DateDue))
					
				Else   //: (($curDate-90)>$oLedger.DateDue)//over 60
					$past90:=$past90+$oLedger.unAppliedValue
					//ConsoleMessage("Past 90\t"+String($oLedger.DocRefID)+"\t"+String(Current Date)+"\t"+String($oLedger.DateDue)+"\t"+String(Current Date - $oLedger.DateDue))
					
			End case 
			
			// ### jwm ### 20190409_1410 do we want to change the balance due values
			If (False:C215)  // shift totals to create true Past 90 days and combine future and due now
				$viDaysPastDue:=$curDate-$oLedger.dateDue
				
				Case of 
					: ($viDaysPastDue<=0)  // Not Past Due
						$future:=$future+$oLedger.unAppliedValue
						
					: (($viDaysPastDue>0) & ($viDaysPastDue<=30))  // past due 1 to 30 days
						$dueNow:=$dueNow+$oLedger.unAppliedValue
						
					: (($viDaysPastDue>30) & ($viDaysPastDue<=60))  // past due 31 to 60 days
						$past30:=$past30+$oLedger.unAppliedValue
						
					: (($viDaysPastDue>60) & ($viDaysPastDue<=90))  // past due 61 to 90 days
						$past60:=$past60+$oLedger.unAppliedValue
						
					: ($viDaysPastDue>90)  // over 90 days past due
						$past90:=$past90+$oLedger.unAppliedValue
						
				End case 
				
			End if 
		End if 
	End for each 
	
	$oCust.futureDue:=$future
	$oCust.balanceCurrent:=$dueNow  // Not past Due
	$oCust.balPastPeriod1:=$past30  // past Due 1 to 29 days
	$oCust.balPastPeriod2:=$past60  // past due 30 to 59 days
	$oCust.balPastPeriod3:=$past90  // past due over 60 days
	$oCust.balanceDue:=$dueNow+$past30+$past60+$past90+$future
	If ($oCust.balanceDue>$oCust.highCredit)
		$oCust.highCredit:=$oCust.balanceDue
	End if 
	$oCust.tallyStatus:=False:C215
	//
	
	$oCust.balanceAvailablePayments:=ds:C1482.Payment.query("amountAvailable # :1 & customerID = :2"; 0; $oCust.customerID).sum(amountAvailable)
	$oCust.balanceOpenOrders:=ds:C1482.Payment.query("amountBackLog # :1 & customerID = :2"; 0; $oCust.customerID).sum(amountBackLog)
	
	$oCust.balanceTotalExposure:=$oCust.balanceOpenOrders+$oCust.balanceDue
	
	var $oInv : Object
	
	
	$oCust.daysAvgPaid:=ds:C1482.Invoice.query("total  > :1 & balanceDue<= :2 & customerID = :3"; 0; 0; $oCust.customerID).average("daysPaid")
	
	$oCust.invoiceCount:=ds:C1482.Invoice.query("total  > :1 & customerID = :2"; 0; $oCust.customerID).length
	
	////Procedure: Cust_TlyDayAvgP
	//MESSAGES OFF
	//QUERY([Invoice]; [Invoice]total>0; *)
	//QUERY([Invoice];  & [Invoice]balanceDue<=0; *)
	//QUERY([Invoice];  & [Invoice]customerID=[Customer])
	//[Customer]daysAvgPaid:=Average([Invoice]daysPaid)
	
	//QUERY([Invoice]; [Invoice]; *)
	//QUERY([Invoice];  & [Invoice]customerID=[Customer]customerID)
	//[Customer]invoiceCount:=Records in selection([Invoice])
	//MESSAGES ON
	
	
	$oCust.save()
End if 