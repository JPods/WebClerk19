//%attributes = {"publishedWeb":true}
//Procedure: Bom_CostItems

// ----------------------------------------------------
// User name (OS): Jim Medlen
// Date and time: 01/07/16, 14:46:20
// ----------------------------------------------------
// Method: Bom_CostItems
// Description
// 
//
// Parameters
// ----------------------------------------------------
// ### jwm ### 20160106_1649  decimal precision

C_LONGINT:C283($i; $k; $w)
C_REAL:C285($total; $totalLast; vrBOMCostStandard; vrBOMCostLast; vrBOMQty; vrBOMCostQty; $totalCostQty; vrBOMPriceQty; $totalPriceQty; vrBOMFactor)

vrBOMCostQty:=0
vrBOMPriceQty:=0
//array TEXT(a35Str1;0)
$total:=0
$k:=Size of array:C274(aRptPartNum)
ARRAY LONGINT:C221(aBomRecs; $k)
C_BOOLEAN:C305($doPop)
$doPop:=False:C215
If ((ptCurTable=(->[Item:4])) & (Record number:C243([Item:4])>-1))
	PUSH RECORD:C176([Item:4])
	$doPop:=True:C214
End if 
ARRAY REAL:C219(iLoaReal1; $k)
ARRAY REAL:C219(iLoaReal2; $k)
If (vrBOMFactor=0)
	vrBOMFactor:=3
End if 

For ($i; 1; $k)
	//$w:=Find in array(a35Str1;aRptPartNum{$i})
	//If ($w>0)
	//aCosts{$i}:=aCosts{$w}
	////aBomRecs{$i}:=aBomRecs{$w}
	//Else 
	QUERY:C277([Item:4]; [Item:4]itemNum:1=aRptPartNum{$i})
	If (Records in selection:C76([Item:4])=1)
		If ([Item:4]profile4:38="Expensed")
			aCosts{$i}:=0
			aCostsLast{$i}:=0
		Else 
			$unitMeasBy:=1
			If ([Item:4]unitOfMeasure:11#"")  // Modified by: williamjames (111216 checked for <= length protection)
				If ([Item:4]unitOfMeasure:11[[1]]="*")
					C_REAL:C285($unitMeasBy)
					$unitMeasBy:=Item_PricePer(->[Item:4]unitOfMeasure:11)
				End if 
			End if 
			aCosts{$i}:=Round:C94([Item:4]costAverage:13/$unitMeasBy; <>tcDecimalUC)  // ### jwm ### 20160106_1649  decimal precision
			aCostsLast{$i}:=Round:C94([Item:4]costLastInShip:47/$unitMeasBy; <>tcDecimalUC)  // ### jwm ### 20160106_1649  decimal precision
			C_REAL:C285($lastCostFound; $avgCostFound; $matrixCost; $matrixPrice; $priceMultiple)
			C_TEXT:C284($reasonCost)
			
			If (vrBOMQty>0)
				ARRAY REAL:C219($aCostElement; 3)
				ARRAY TEXT:C222($aCostReason; 3)
				$inTest:=0
				$reasonCost:=""
				$lastCostFound:=aCostsLast{$i}
				$avgCostFound:=aCosts{$i}
				$matrixCost:=-1
				$matrixPrice:=-1
				$priceMultiple:=-1
				QUERY:C277([PriceMatrix:105]; [PriceMatrix:105]ItemNum:11=aRptPartNum{$i}; *)
				QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]TypeSale:3="Estimating"; *)
				QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]QuantityMin:4<=vrBOMQty; *)
				QUERY:C277([PriceMatrix:105];  & [PriceMatrix:105]QuantityMax:5>=vrBOMQty)
				Case of 
					: (Records in selection:C76([PriceMatrix:105])=1)
						$reasonCost:="1-PM"
						$matrixCost:=[PriceMatrix:105]Cost:9
						$priceMultiple:=[PriceMatrix:105]Price:6
					: (Records in selection:C76([PriceMatrix:105])>1)
						$reasonCost:="multi-PM"
						$priceMultiple:=vrBOMFactor
					Else 
						$reasonCost:="0-PM"
						$priceMultiple:=vrBOMFactor
				End case 
				$aCostElement{1}:=$matrixCost
				$aCostReason{1}:="Mtx"
				$aCostElement{2}:=aCostsLast{$i}
				$aCostReason{2}:="Lst"
				$aCostElement{3}:=aCosts{$i}
				$aCostReason{3}:="Avg"
				SORT ARRAY:C229($aCostElement; $aCostReason; >)  //accending order, smallest to largest
				For ($incElement; 1; 3)
					$reasonCost:=$reasonCost+"; "+String:C10(Round:C94($aCostElement{$incElement}; <>tcDecimalUC))+"_"+$aCostReason{$incElement}  // ### jwm ### 20160106_1649  decimal precision
				End for 
				Case of 
					: (aPriceForecastOptions=1)
						$inTest:=MinimumValueReturn($matrixCost; aCostsLast{$i}; 1; 0)
						$inTest:=MinimumValueReturn($inTest; aCosts{$i}; 1; 0)
					: (aPriceForecastOptions=2)
						$inTest:=MinimumValueReturn($matrixCost; aCostsLast{$i}; 1; 0)
					: (aPriceForecastOptions=3)
						$inTest:=$matrixCost
					: (aPriceForecastOptions=4)
						If (($matrixCost<=0) | (aCostsLast{$i}<0) | (aCosts{$i}<=0))
							$reasonCost:="Err -- "+$reasonCost
						Else 
							$reasonCost:="OK -- "+$reasonCost
						End if 
				End case 
				$reasonCost:="Used_"+String:C10(Round:C94($inTest; <>tcDecimalUC))+"; PrX_"+String:C10(Round:C94($priceMultiple; <>tcDecimalUC))+"; "+$reasonCost
				aBOMCostsExpanded{$i}:=Round:C94($inTest*aQtyPlan{$i}; <>tcDecimalUC)  //[PriceMatrix]Cost  // ### jwm ### 20160106_1649  decimal precision
				aBomPriceExpanded{$i}:=Round:C94(aBOMCostsExpanded{$i}*$priceMultiple*aQtyPlan{$i}; 2)  //[PriceMatrix]Price ????
				aBomBuildNote{$i}:=$reasonCost
			End if 
			
			
		End if 
		//aBomRecs{$i}:=Record number([Item])
	Else 
		aCosts{$i}:=0
		aCostsLast{$i}:=0
		aBomRecs{$i}:=-1
		BEEP:C151
	End if 
	// End if 
	If (aBOMLevel{$i}=1)
		$total:=$total+(aCosts{$i}*aQtyAct{$i})
		$totalLast:=$totalLast+(aCostsLast{$i}*aQtyAct{$i})
		
		$totalCostQty:=$totalCostQty+(iLoaReal1{$i}*aQtyAct{$i})
		$totalPriceQty:=$totalPriceQty+(iLoaReal2{$i}*aQtyAct{$i})
	End if 
End for 
vrBOMCostStandard:=$total
vrBOMCostLast:=$totalLast
//
vrBOMCostQty:=$totalCostQty
vrBOMPriceQty:=$totalPriceQty
If (vrTooling>0)
	vrBOMCostQty:=vrBOMCostQty+Round:C94(vrTooling/vrBOMQty; <>tcDecimalUC)  // ### jwm ### 20160106_1649  decimal precision
End if 



//ARRAY REAL(iLoaReal1;0)
//ARRAY REAL(iLoaReal2;0)

UNLOAD RECORD:C212([Item:4])
If ($doPop)
	POP RECORD:C177([Item:4])
Else 
	UNLOAD RECORD:C212([Item:4])
End if 
//array TEXT(a35Str1;0)