//%attributes = {"publishedWeb":true}
//Procedure: PoLn_Rollin
C_LONGINT:C283($i; $k)
TRACE:C157
C_BOOLEAN:C305($doSum; $tallyNow)
C_TEXT:C284($serialNums; $comment)
C_REAL:C285($discount; $unitCost; $totalCost; $qtyOrd; $qtyRcvd; $qtyBL; $qtyNow; $baseCost)
$i:=0
$k:=Size of array:C274(aPOLnCmplt)
For ($i; $k; 2; -1)
	//If ((aPoItemNum{$i}=aPoItemNum{$i-1})|($doSum))
	Case of 
		: (aPoItemNum{$i}#aPoItemNum{$i-1})  //change in items
			$doAccum:=False:C215
		: (aPOQtyOrder{$i}>0) & (aPOQtyOrder{$i-1}<0)  //same item change in sign
			$doAccum:=False:C215
		Else 
			$doAccum:=True:C214
	End case 
	If ($doAccum)
		$doSum:=True:C214
		$qtyNow:=$qtyNow+aPOQtyNow{$i}
		$qtyOrd:=$qtyOrd+aPOQtyOrder{$i}
		$qtyRcvd:=$qtyRcvd+aPOQtyRcvd{$i}
		$qtyBL:=$qtyBL+aPOQtyBL{$i}
		$baseCost:=$baseCost+(aPOQtyOrder{$i}*aPoUnitCost{$i})
		$discount:=$discount+(aPODiscnt{$i}*0.01*aPOQtyOrder{$i}*aPOUnitCost{$i})
		$totalCost:=$totalCost+aPOExtCost{$i}
		//$serialNums:=$serialNums+aPOSerialNm{$i}
		$comment:=$comment+aPoLComment{$i}
		POLn_RaySize(-1; $i; 1)
	End if 
	If (($doSum) & ($doAccum=False:C215))
		$doSum:=False:C215
		//
		$qtyNow:=$qtyNow+aPOQtyNow{$i}
		$qtyOrd:=$qtyOrd+aPOQtyOrder{$i}
		$qtyRcvd:=$qtyRcvd+aPOQtyRcvd{$i}
		$qtyBL:=$qtyBL+aPOQtyBL{$i}
		$baseCost:=$baseCost+(aPOQtyOrder{$i}*aPoUnitCost{$i})
		$discount:=$discount+(aPODiscnt{$i}*0.01*aPOQtyOrder{$i}*aPOUnitCost{$i})
		$totalCost:=$totalCost+aPOExtCost{$i}
		//$serialNums:=$serialNums+aPOSerialNm{$i}
		$comment:=$comment+aPoLComment{$i}
		//
		aPOQtyNow{$i}:=$qtyNow
		aPOQtyOrder{$i}:=$qtyOrd
		aPOExtCost{$i}:=$totalCost
		If ($totalCost#0)
			aPoDiscnt{$i}:=Round:C94($discount/$totalCost*100; 1)
		Else 
			aPoDiscnt{$i}:=0
		End if 
		If ($qtyOrd#0)
			aPoUnitCost{$i}:=Round:C94($baseCost/$qtyOrd; <>tcDecimalUC)
			aPoDscntUP{$i}:=Round:C94($totalCost/$qtyOrd; <>tcDecimalUC)
		Else 
			aPoUnitCost{$i}:=0
			aPoDscntUP{$i}:=0
		End if 
		//aPOSerialNm{$i}:=$serialNums
		aPOQtyRcvd{$i}:=$qtyRcvd
		aPOQtyBL{$i}:=$qtyBL
		aPoLComment{$i}:=$comment
		$doSum:=False:C215
		$discount:=0
		$totalCost:=0
		$baseCost:=0
		$serialNums:=""
		$qtyOrd:=0
		$qtyRcvd:=0
		$qtyBL:=0
		$qtyNow:=0
		$comment:=""
	End if 
	//End if 
End for 