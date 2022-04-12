//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): jimmedlen
// Date and time: 03/21/13, 12:32:53
// ----------------------------------------------------
// Called By: BOM_ExtendCost
// Method: BOM_ChildCost
// Description
// File: BOM_ChildCost.txt
// Parameters
// ----------------------------------------------------
//### jwm ### 20130404_0956 changed <>tcsiteID to vsiteID
//### jwm ### 20130404_0957 changed <>tcsiteID to vsiteID
//### jwm ### 20130404_0958 changed <>tcsiteID to vsiteID
//### jwm ### 20130404_0959 changed <>tcsiteID to vsiteID

// 2013-06-19T00:00:00 10:39 - create flat text file
C_TEXT:C284(vDoFlatText)  //  to accumulate the values, must us a script to put something in this value to start.
If (vDoFlatText#"")
	vDoFlatText:=vDoFlatText+"\r"+"\r"+"ItemNum"+"\t"+"Reason"+"\t"+"Level"+"\t"+"aQtyPlan*aCosts"+"\t"+"aQtyPlan*aCostsLast"+"\t"+"iLoaReal1*aQtyAct"+"\t"+"iLoaReal1*aQtyAct"+"\r"
End if 

//Procedure: BOM_ChildCost
C_REAL:C285($totalCost; $totalCostLast; $subItemCosts)
$totalCost:=0
C_LONGINT:C283($1; $adjID)
$adjID:=$1
C_POINTER:C301($2; $Source)
$Source:=$2
C_REAL:C285($3; $TopQty)
$TopQty:=$3
C_POINTER:C301($4; $rowPtr)  //pointer to a Longint row variable of the parent
$rowPtr:=$4
C_LONGINT:C283($5; $level)
$level:=$5
C_BOOLEAN:C305($6; $bAdjustForQtyOnHand)
If (Count parameters:C259>5)
	$bAdjustForQtyOnHand:=$6
Else 
	$bAdjustForQtyOnHand:=False:C215
End if 

C_LONGINT:C283($jobID)
$jobID:=0

C_TEXT:C284($reason)
$reason:=""

C_REAL:C285($unitCost)
$unitCost:=0
C_REAL:C285($totalMatrixCost; $totalMatrixPrice)

C_LONGINT:C283($row)  //local copy of the row we are working on

C_BOOLEAN:C305($notDone)
$notDone:=True:C214
While ($notDone)
	If (($rowPtr->+1)>Size of array:C274(aRptPartNum))  //if this is the last row of the array I'm done
		$notDone:=False:C215
	Else 
		If (aBOMLevel{$rowPtr->+1}#$level)  //if the next Ext BOM item is not at the current level I'm done
			$notDone:=False:C215
		End if 
	End if 
	If ($notDone)
		$rowPtr->:=$rowPtr->+1
		$row:=$rowPtr->
		$reason:="BOM_ml_root_child"
		$unitCost:=aCosts{$row}
		If (($row+1)<=Size of array:C274(aRptPartNum))
			If (aBOMLevel{$row+1}>aBOMLevel{$row})  // if BOM level of the next row is greater than the current row
				BOM_ChildCost($adjID; $Source; $TopQty; $rowPtr; aBOMLevel{$row+1}; $bAdjustForQtyOnHand)  // recursive call of next row
				$subItemCosts:=$subItemCosts+vR2  //  cost of all the children from recursive
				If ($adjID#0)
					$unitCost:=aCosts{$row}
					// Positive Build of mid level BOM item
					If ($bAdjustForQtyOnHand)
						Invt_dRecCreate("BM"; $adjID; 0; $Source->; $jobID; "BOM_ml_mid_build"; 1; 0; aRptPartNum{$row}; aQtyReducedByOnHand{$row}; 0; $unitCost; $Source->; vsiteID; 0)
					Else 
						Invt_dRecCreate("BM"; $adjID; 0; $Source->; $jobID; "BOM_ml_mid_build"; 1; 0; aRptPartNum{$row}; -(aQtyAct{$row}*$TopQty); 0; $unitCost; $Source->; vsiteID; 0)
					End if 
					$reason:="BOM_ml_mid_child"
				End if 
				aCostsLast{$row}:=vR2  // set in (P) BOM_ChildCost
				aCosts{$row}:=vR1  //###_jwm_### save cost at sublevel
				
				If (vrBOMQty>0)
					ARRAY REAL:C219($aCostElement; 3)
					ARRAY TEXT:C222($aCostReason; 3)
					$inTest:=0
					$reasonCost:=""
					$lastCostFound:=aCostsLast{$row}
					$avgCostFound:=aCosts{$row}
					$matrixCost:=-1
					$matrixPrice:=-1
					$priceMultiple:=-1
					QUERY:C277([PriceMatrix:105]; [PriceMatrix:105]itemNum:11=aRptPartNum{$row}; *)
					QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]typeSale:3="Estimating"; *)
					QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]quantityMin:4<=vrBOMQty; *)
					QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]quantityMax:5>=vrBOMQty)
					Case of 
						: (Records in selection:C76([PriceMatrix:105])=1)
							$reasonCost:="1-PM"
							$matrixCost:=[PriceMatrix:105]cost:9
							$priceMultiple:=[PriceMatrix:105]price:6
						: (Records in selection:C76([PriceMatrix:105])>1)
							$reasonCost:="multi-PM"
							$priceMultiple:=vrBOMFactor
						Else 
							$reasonCost:="0-PM"
							$priceMultiple:=vrBOMFactor
					End case 
					$aCostElement{1}:=$matrixCost
					$aCostReason{1}:="Mtx"
					$aCostElement{2}:=aCostsLast{$row}
					$aCostReason{2}:="Lst"
					$aCostElement{3}:=aCosts{$row}
					$aCostReason{3}:="Avg"
					SORT ARRAY:C229($aCostElement; $aCostReason; >)  //accending order, smallest to largest
					For ($incElement; 1; 3)
						$reasonCost:=$reasonCost+"; "+String:C10(Round:C94($aCostElement{$incElement}; 2))+"_"+$aCostReason{$incElement}
					End for 
					Case of 
						: (aPriceForecastOptions=1)
							$inTest:=MinimumValueReturn($matrixCost; aCostsLast{$row}; 1; 0)
							$inTest:=MinimumValueReturn($inTest; aCosts{$row}; 1; 0)
						: (aPriceForecastOptions=2)
							$inTest:=MinimumValueReturn($matrixCost; aCostsLast{$row}; 1; 0)
						: (aPriceForecastOptions=3)
							$inTest:=$matrixCost
						: (aPriceForecastOptions=4)
							If (($matrixCost<=0) | (aCostsLast{$row}<0) | (aCosts{$row}<=0))
								$reasonCost:="Err -- "+$reasonCost
							Else 
								$reasonCost:="OK -- "+$reasonCost
							End if 
					End case 
					$reasonCost:="Used_"+String:C10(Round:C94($inTest; 2))+"; PrX_"+String:C10(Round:C94($priceMultiple; 2))+"; "+$reasonCost
					aBOMCostsExpanded{$row}:=Round:C94($inTest*aQtyAct{$row}; 2)  //[PriceMatrix]Cost
					aBomPriceExpanded{$row}:=Round:C94(iLoaReal1{$row}*$priceMultiple*aQtyAct{$row}; 2)  //[PriceMatrix]Price
					aBomBuildNote{$row}:=$reasonCost
				End if 
				
				
			End if 
		Else 
			
			If (vrBOMQty>0)
				ARRAY REAL:C219($aCostElement; 3)
				ARRAY TEXT:C222($aCostReason; 3)
				$inTest:=0
				$reasonCost:=""
				$lastCostFound:=aCostsLast{$row}
				$avgCostFound:=aCosts{$row}
				$matrixCost:=-1
				$matrixPrice:=-1
				$priceMultiple:=-1
				QUERY:C277([PriceMatrix:105]; [PriceMatrix:105]itemNum:11=aRptPartNum{$row}; *)
				QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]typeSale:3="Estimating"; *)
				QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]quantityMin:4<=vrBOMQty; *)
				QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]quantityMax:5>=vrBOMQty)
				Case of 
					: (Records in selection:C76([PriceMatrix:105])=1)
						$reasonCost:="1-PM"
						$matrixCost:=[PriceMatrix:105]cost:9
						$priceMultiple:=[PriceMatrix:105]price:6
					: (Records in selection:C76([PriceMatrix:105])>1)
						$reasonCost:="multi-PM"
						$priceMultiple:=vrBOMFactor
					Else 
						$reasonCost:="0-PM"
						$priceMultiple:=vrBOMFactor
				End case 
				$aCostElement{1}:=$matrixCost
				$aCostReason{1}:="Mtx"
				$aCostElement{2}:=aCostsLast{$row}
				$aCostReason{2}:="Lst"
				$aCostElement{3}:=aCosts{$row}
				$aCostReason{3}:="Avg"
				SORT ARRAY:C229($aCostElement; $aCostReason; >)  //accending order, smallest to largest
				For ($incElement; 1; 3)
					$reasonCost:=$reasonCost+"; "+String:C10(Round:C94($aCostElement{$incElement}; 2))+"_"+$aCostReason{$incElement}
				End for 
				Case of 
					: (aPriceForecastOptions=1)
						$inTest:=MinimumValueReturn($matrixCost; aCostsLast{$row}; 1; 0)
						$inTest:=MinimumValueReturn($inTest; aCosts{$row}; 1; 0)
					: (aPriceForecastOptions=2)
						$inTest:=MinimumValueReturn($matrixCost; aCostsLast{$row}; 1; 0)
					: (aPriceForecastOptions=3)
						$inTest:=$matrixCost
					: (aPriceForecastOptions=4)
						If (($matrixCost<=0) | (aCostsLast{$row}<0) | (aCosts{$row}<=0))
							$reasonCost:="Err -- "+$reasonCost
						Else 
							$reasonCost:="OK -- "+$reasonCost
						End if 
				End case 
				$reasonCost:="Used_"+String:C10(Round:C94($inTest; 2))+"; PrX_"+String:C10(Round:C94($priceMultiple; 2))+"; "+$reasonCost
				aBOMCostsExpanded{$row}:=Round:C94($inTest*aQtyAct{$row}; 2)  //[PriceMatrix]Cost
				aBomPriceExpanded{$row}:=Round:C94(iLoaReal1{$row}*$priceMultiple*aQtyAct{$row}; 2)  //[PriceMatrix]Price
				aBomBuildNote{$row}:=$reasonCost
			End if 
			
		End if 
		
		// Negative Adjustment of BOM root item or mid item if returning from recursive call above ($reason set above)
		If ($bAdjustForQtyOnHand)
			Invt_dRecCreate("BM"; $adjID; 0; $Source->; $jobID; $reason; 1; 0; aRptPartNum{$row}; -aQtyAdjOnHand{$row}; 0; $unitCost; $Source->; vsiteID; 0)
		Else 
			Invt_dRecCreate("BM"; $adjID; 0; $Source->; $jobID; $reason; 1; 0; aRptPartNum{$row}; (aQtyAct{$row}*$TopQty); 0; $unitCost; $Source->; vsiteID; 0)
		End if 
		
		$totalCost:=$totalCost+(aQtyPlan{$row}*aCosts{$row})
		$totalCostLast:=$totalCostLast+(aQtyPlan{$row}*aCostsLast{$row})
		//
		$totalMatrixCost:=$totalMatrixCost+(iLoaReal1{$row}*aQtyAct{$row})
		$totalMatrixPrice:=$totalMatrixPrice+(iLoaReal2{$row}*aQtyAct{$row})
		
		If (vDoFlatText#"")
			vDoFlatText:=vDoFlatText+aRptPartNum{$row}+"\t"+$reason+"\t"+String:C10(aBOMLevel{$row})+"\t"+String:C10(aQtyPlan{$row}*aCosts{$row})+"\t"+String:C10(aQtyPlan{$row}*aCostsLast{$row})+"\t"+String:C10(iLoaReal1{$row}*aQtyAct{$row})+"\t"+String:C10(iLoaReal2{$row}*aQtyAct{$row})+"\r"
			
		End if 
		
	End if 
End while 
vR1:=$totalCost
vR2:=$totalCostLast

vR3:=$totalMatrixCost
vR4:=$totalMatrixPrice
//
If (vDoFlatText#"")
	vDoFlatText:=vDoFlatText+"Exit_BOM_ChildCost"+"\t"+String:C10(vR1)+"\t"+String:C10(vR2)+"\t"+String:C10(vR3)+"\t"+String:C10(vR4)+"\r"
	
	SET TEXT TO PASTEBOARD:C523(vDoFlatText)  // if the value has been accumulated, put it to the pasteboard.
End if 

