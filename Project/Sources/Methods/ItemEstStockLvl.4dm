//%attributes = {"publishedWeb":true}
C_LONGINT:C283($k; $i; $myOK; $NumSales; $Days; $recSel)
C_REAL:C285($SafetyFact; $ReOrdPt; $TotUsage; $DaysUsage; $avgSaleQty; $DayQty; $UsagePerDay)
C_REAL:C285($CostCur; $CostAct; $CostRec)
C_DATE:C307($curMon; $LtYrmon; $PerBeg; $PerEnd)
If (vHere=0)
	jsetDefaultFile(->[Item:4])
	//QUERY([Item])
	curTableNum:=Table:C252(->[Item:4])
	doQuickQuote:=1
	Srch_FullDia(Table:C252(curTableNum))
	doQuickQuote:=0
	If (OK=1)
		myOK:=1
	Else 
		myOK:=0
	End if 
Else 
	myOK:=1
End if 
If (myOK=1)
	$k:=Records in selection:C76([Item:4])
	If ($k>0)
		//    myDocName:=""
		$myOK:=EI_CreateDoc(->myDocName; ->myDoc; "")
		If ($myOK=1)
			FIRST RECORD:C50([Item:4])
			//ThermoInitExit ("Processing Item Record";$k;True)
			$viProgressID:=Progress New
			
			$SafetyFact:=Num:C11(Request:C163("Enter Safety Factor."; "1.5"))
			SEND PACKET:C103(myDoc; "Estimated Reorder Point"+"\r")
			SEND PACKET:C103(myDoc; String:C10(Current date:C33)+"\r"+"\r")
			SEND PACKET:C103(myDoc; "Item Num"+"\t"+"Description"+"\t"+" Cur Min"+"\t"+"Recom Min"+"\t"+"Total Usage"+"\t"+"Days Usage"+"\t"+"Lead Time(days)"+"\t"+"Num Sales"+"\t"+"Units Per Sale"+"\t"+"Units Per Day"+"\t"+"Std Cost"+"\t"+"Min Carry $"+"\t"+"Rec Carry $"+"\t"+"Act Carry $"+"\r")
			//SEND PACKET(myDoc;"Item Num"+"\t"+"Description"+"\t"+" Cur Min"
			//+"\t"+"Recom Min"+"\t"+"Total Usage"+"\t"+"Days Usage"+"\t"+"Lead Time
			//(days)"+"\t"+"Num Sales"+"\t"+"Units Per Sale"+"\t"+"Units Per Day"
			//+"\t"+"Std Cost"+"\t"+"Min Carry $"+"\t"+"Rec Carry $"+"\t"+"Act Carry
			// $"+"\r")
			
			$curMon:=Date:C102(String:C10(Month of:C24(Current date:C33))+"/1/"+String:C10(Year of:C25(Current date:C33)))
			$LtYrmon:=Date:C102(String:C10(Month of:C24($curMon))+"/1/"+String:C10(Year of:C25(Current date:C33)-1))
			For ($i; 1; $k)
				//Thermo_Update ($i)
				ProgressUpdate($viProgressID; $i; $k; "Processing Item Record")
				If (<>ThermoAbort)
					$i:=$k
				End if 
				$ReOrdPt:=0
				$TotUsage:=0
				$DaysUsage:=0
				$avgSaleQty:=0
				$DayQty:=0
				$NumSales:=0
				QUERY:C277([Usage:5]; [Usage:5]itemNum:1=[Item:4]itemNum:1; *)
				QUERY:C277([Usage:5];  & [Usage:5]periodDate:2>=$LtYrmon; *)
				QUERY:C277([Usage:5];  & [Usage:5]periodDate:2<=$curMon)
				$recSel:=Records in selection:C76([Usage:5])
				If ($recSel>0)
					ORDER BY:C49([Usage:5]; [Usage:5]periodDate:2; >)
					FIRST RECORD:C50([Usage:5])
					$PerBeg:=[Usage:5]periodDate:2
					LAST RECORD:C200([Usage:5])
					$PerEnd:=[Usage:5]periodDate:2
					$Days:=$PerEnd-$PerBeg
					$TotUsage:=Sum:C1([Usage:5]salesQtyActual:4)
					$UsagePerDay:=Round:C94($TotUsage/$Days; 4)
					$avgSaleQty:=Round:C94($TotUsage/Sum:C1([Usage:5]numInvoices:16); 4)
					$NumSales:=Sum:C1([Usage:5]numInvoices:16)
					$ReOrdPt:=Round:C94(($TotUsage/$Days)*[Item:4]leadTimeSales:12*$SafetyFact; 4)
					$CostCur:=Round:C94([Item:4]qtyMinStock:18*[Item:4]costAverage:13*0.03; 2)
					$CostAct:=Round:C94([Item:4]qtyOnHand:14*[Item:4]costAverage:13*0.03; 2)
					$CostRec:=Round:C94($ReOrdPt*[Item:4]costAverage:13*0.03; 2)
				End if 
				SEND PACKET:C103(myDoc; [Item:4]itemNum:1+"\t"+[Item:4]description:7+"\t"+String:C10([Item:4]qtyMinStock:18)+"\t"+String:C10($ReOrdPt)+"\t"+String:C10($TotUsage)+"\t"+String:C10($Days)+"\t"+String:C10([Item:4]leadTimeSales:12)+"\t"+String:C10($NumSales)+"\t"+String:C10($avgSaleQty)+"\t"+String:C10($UsagePerDay)+"\t"+String:C10([Item:4]costAverage:13)+"\t"+String:C10($CostCur)+"\t"+String:C10($CostRec)+"\t"+String:C10($CostAct)+"\r")
				//SEND PACKET(myDoc;[Item]ItemNum+"\t"+[Item]Description+"\t"
				//+String([Item]QtyMinStock)+"\t"+String($ReOrdPt)+"\t"+String($TotUsage)
				//+"\t"+String($Days)+"\t"+String([Item]LeadTimeSales)+"\t"+String
				//($NumSales)+"\t"+String($avgSaleQty)+"\t"+String($UsagePerDay)+"\t"
				//+String([Item]CostWtStd)+"\t"+String($CostCur)+"\t"+String($CostRec)
				//+"\t"+String($CostAct)+"\r")
				NEXT RECORD:C51([Item:4])
			End for 
			//Thermo_Close 
			Progress QUIT($viProgressID)
			CLOSE DOCUMENT:C267(myDoc)
		End if 
	End if 
End if 