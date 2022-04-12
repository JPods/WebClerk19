//%attributes = {"publishedWeb":true}
If (False:C215)
	//Method: TallySummaryByPeriod
	//Date: 03/11/03
	//Who: Bill
	//Description: 
End if 

C_DATE:C307($1; $2; $begDate; $endDate)
C_TEXT:C284($3; $ReportName; $4; $byWhom; $5; $table2Tally)

C_LONGINT:C283($dtReport; $dtBegin; $dtEnd)
ARRAY REAL:C219(aReal1; 30)
ARRAY TEXT:C222(aText1; 30)
If (Count parameters:C259=4)
	$begDate:=$1
	$endDate:=$2
	$dtBegin:=DateTime_Enter($begDate)
	$dtEnd:=DateTime_Enter($endDate; ?23:59:59?)
	$byWhom:=$3
	$table2Tally:=$4
	If (($table2Tally="Invoice") | ($table2Tally="TallyAll"))
		$dtReport:=DateTime_Enter($begDate)
		QUERY:C277([Invoice:26]; [Invoice:26]dateDocument:35>=$begDate; *)
		QUERY:C277([Invoice:26];  & [Invoice:26]dateDocument:35<=$endDate; *)
		If ($byWhom#"")
			QUERY:C277([Invoice:26];  & [Invoice:26]salesNameID:23=$byWhom; *)
		End if 
		QUERY:C277([Invoice:26])
		
		ARRAY REAL:C219($aPrice; 0)
		ARRAY REAL:C219($aCost; 0)
		ARRAY REAL:C219($aShipTotal; 0)
		ARRAY REAL:C219($aTaxTotal; 0)
		ARRAY REAL:C219($aBalDue; 0)
		SELECTION TO ARRAY:C260([Invoice:26]amount:14; $aPrice; [Invoice:26]totalCost:37; $aCost; [Invoice:26]shipTotal:20; $aShipTotal; [Invoice:26]salesTax:19; $aTaxTotal; [Invoice:26]balanceDue:44; $aBalDue)
		$cntRay:=Size of array:C274($aPrice)
		$sumCost:=0
		$sumPrice:=0
		$sumTax:=0
		$sumShip:=0
		For ($incRay; 1; $cntRay)
			$sumPrice:=$sumPrice+$aPrice{$incRay}
			$sumCost:=$sumCost+$aCost{$incRay}
			$sumTax:=$sumTax+$aTaxTotal{$incRay}
			$sumShip:=$sumShip+$aShipTotal{$incRay}
			$balDue:=$balDue+$aBalDue{$incRay}
		End for 
		aReal1{1}:=$sumPrice
		aReal1{2}:=$sumCost
		aReal1{3}:=$sumTax
		aReal1{4}:=$sumShip
		aReal1{5}:=$balDue
		aReal1{6}:=$cntRay
		aText1{1}:="Invoice Amount"
		aText1{2}:="Invoice Cost"
		aText1{3}:="Invoice Tax"
		aText1{4}:="Invoice Shipping"
		aText1{5}:="Invoice Balance Due"
		aText1{6}:="Invoice Count"
	End if 
	
	//
	If (($table2Tally="Order") | ($table2Tally="TallyAll"))
		QUERY:C277([Order:3]; [Order:3]dateDocument:4>=$begDate; *)
		QUERY:C277([Order:3];  & [Order:3]dateDocument:4<=$endDate; *)
		If ($byWhom#"")
			QUERY:C277([Order:3];  & [Order:3]salesNameID:10=$byWhom; *)
		End if 
		QUERY:C277([Order:3])
		ARRAY REAL:C219($aPrice; 0)
		ARRAY REAL:C219($aCost; 0)
		ARRAY REAL:C219($aShipTotal; 0)
		ARRAY REAL:C219($aTaxTotal; 0)
		ARRAY REAL:C219($aBackLog; 0)
		SELECTION TO ARRAY:C260([Order:3]amount:24; $aPrice; [Order:3]totalCost:42; $aCost; [Order:3]shipTotal:30; $aShipTotal; [Order:3]salesTax:28; $aTaxTotal; [Order:3]amountBackLog:54; $aBackLog)
		$cntRay:=Size of array:C274($aPrice)
		$sumCost:=0
		$sumPrice:=0
		$sumTax:=0
		$sumShip:=0
		For ($incRay; 1; $cntRay)
			$sumPrice:=$sumPrice+$aPrice{$incRay}
			$sumCost:=$sumCost+$aCost{$incRay}
			$sumTax:=$sumTax+$aTaxTotal{$incRay}
			$sumShip:=$sumShip+$aShipTotal{$incRay}
			$balDue:=$balDue+$aBackLog{$incRay}
		End for 
		aReal1{7}:=$sumPrice
		aReal1{8}:=$sumCost
		aReal1{9}:=$sumTax
		aReal1{10}:=$sumShip
		aReal1{11}:=$balDue
		aReal1{12}:=$cntRay
		
		aText1{7}:="Order Amount"
		aText1{8}:="Order Cost"
		aText1{9}:="Order Tax"
		aText1{10}:="Order Shipping"
		aText1{11}:="Order Backlog"
		aText1{12}:="Order Count"
	End if 
	//
	If (($table2Tally="Proposal") | ($table2Tally="TallyAll"))
		QUERY:C277([Proposal:42]; [Proposal:42]dateDocument:3>=$begDate; *)
		QUERY:C277([Proposal:42];  & [Proposal:42]dateDocument:3<=$endDate; *)
		If ($byWhom#"")
			QUERY:C277([Proposal:42];  & [Proposal:42]salesNameID:9=$byWhom; *)
		End if 
		QUERY:C277([Proposal:42])
		ARRAY REAL:C219($aPrice; 0)
		ARRAY REAL:C219($aCost; 0)
		ARRAY REAL:C219($aShipTotal; 0)
		ARRAY REAL:C219($aTaxTotal; 0)
		ARRAY REAL:C219($aBackLog; 0)
		SELECTION TO ARRAY:C260([Proposal:42]amount:26; $aPrice; [Proposal:42]totalCost:23; $aCost; [Proposal:42]shipTotal:31; $aShipTotal; [Proposal:42]salesTax:27; $aTaxTotal)
		$cntRay:=Size of array:C274($aPrice)
		$sumCost:=0
		$sumPrice:=0
		$sumTax:=0
		$sumShip:=0
		For ($incRay; 1; $cntRay)
			$sumPrice:=$sumPrice+$aPrice{$incRay}
			$sumCost:=$sumCost+$aCost{$incRay}
			$sumTax:=$sumTax+$aTaxTotal{$incRay}
			$sumShip:=$sumShip+$aShipTotal{$incRay}
		End for 
		aReal1{13}:=$sumPrice
		aReal1{14}:=$sumCost
		aReal1{15}:=$sumTax
		aReal1{16}:=$sumShip
		aReal1{17}:=$cntRay
		aText1{13}:="Proposal Amount"
		aText1{14}:="Proposal Cost"
		aText1{15}:="Proposal Tax"
		aText1{16}:="Proposal Shipping"
		aText1{17}:="Proposal Count"
	End if 
	//
	If (($table2Tally="PO") | ($table2Tally="TallyAll"))
		QUERY:C277([PO:39]; [PO:39]dateOrdered:2>=$begDate; *)
		QUERY:C277([PO:39];  & [PO:39]dateOrdered:2<=$endDate; *)
		If ($byWhom#"")
			QUERY:C277([PO:39];  & [PO:39]buyer:7=$byWhom; *)
		End if 
		QUERY:C277([PO:39])
		ARRAY REAL:C219($aPrice; 0)
		ARRAY REAL:C219($aCost; 0)
		ARRAY REAL:C219($aShipTotal; 0)
		ARRAY REAL:C219($aTaxTotal; 0)
		ARRAY REAL:C219($aBackLog; 0)
		SELECTION TO ARRAY:C260([PO:39]amount:19; $aCost; [PO:39]taxJurisdiction:22; $aTaxTotal; [PO:39]shipHandling:21; $aShipTotal; [PO:39]amountBackLog:25; $aBackLog)
		$cntRay:=Size of array:C274($aPrice)
		$sumCost:=0
		$sumPrice:=0
		$sumTax:=0
		$sumShip:=0
		For ($incRay; 1; $cntRay)
			$sumCost:=$sumCost+$aCost{$incRay}
			$sumTax:=$sumTax+$aTaxTotal{$incRay}
			$sumShip:=$sumShip+$aShipTotal{$incRay}
			$balDue:=$balDue+$aBackLog{$incRay}
		End for 
		aReal1{18}:=$sumCost
		aReal1{19}:=$sumTax
		aReal1{20}:=$sumShip
		aReal1{21}:=$cntRay
		aText1{18}:="PO Cost"
		aText1{19}:="PO Tax"
		aText1{20}:="PO Shipping"
		aText1{21}:="PO Count"
	End if 
	//    
	If (($table2Tally="Customer") | ($table2Tally="TallyAll"))
		QUERY:C277([Customer:2]; [Customer:2]dateOpened:14>=$begDate; *)
		QUERY:C277([Customer:2];  & [Customer:2]dateOpened:14<=$endDate; *)
		If ($byWhom#"")
			QUERY:C277([Customer:2];  & [Customer:2]salesNameID:59=$byWhom; *)
		End if 
		QUERY:C277([Customer:2])
		
		aReal1{22}:=Records in selection:C76([Customer:2])
		aText1{22}:="New Customer Count"
	End if 
	
	If (($table2Tally="Lead") | ($table2Tally="TallyAll"))
		QUERY:C277([zzzLead:48]; [zzzLead:48]dateEntered:21>=$begDate; *)
		QUERY:C277([zzzLead:48];  & [zzzLead:48]dateEntered:21<=$endDate; *)
		If ($byWhom#"")
			QUERY:C277([zzzLead:48];  & [zzzLead:48]salesNameID:13=$byWhom; *)
		End if 
		QUERY:C277([zzzLead:48])
		
		aReal1{23}:=Records in selection:C76([zzzLead:48])
		aText1{23}:="New Leads Count"
	End if 
	
	If (($table2Tally="Service") | ($table2Tally="TallyAll"))
		QUERY:C277([Service:6]; [Service:6]dtDocument:16>=$dtBegin; *)
		QUERY:C277([Service:6];  & [Service:6]dtDocument:16<=$dtEnd)
		aReal1{24}:=Records in selection:C76([zzzLead:48])
		aText1{24}:="New Service Count"
		//
		QUERY:C277([Service:6]; [Service:6]dtComplete:18>=$dtBegin; *)
		QUERY:C277([Service:6];  & [Service:6]dtComplete:18<=$dtEnd)
		aReal1{25}:=Records in selection:C76([zzzLead:48])
		aText1{25}:="Completed Service Count"
	End if 
	//
	If (($table2Tally="CallReport") | ($table2Tally="TallyAll"))
		QUERY:C277([CallReport:34]; [CallReport:34]dateDocument:17>=$begDate; *)
		QUERY:C277([CallReport:34];  & [CallReport:34]dateDocument:17<=$endDate; *)
		aReal1{26}:=Records in selection:C76([CallReport:34])
		aText1{26}:="Call Reports"
	End if 
	
End if 