//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 03/23/12, 10:30:10
// ----------------------------------------------------
// Method: BOM_Consume
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $i; $k)  //depth of consume
C_REAL:C285($3; $totalCost; $0)  //Qty, cost, total cost
C_POINTER:C301($2)  //item
C_LONGINT:C283($4; $adjID)
$adjID:=$4
C_BOOLEAN:C305($5; $bAdjustForQtyOnHand)
If (Count parameters:C259>4)
	$bAdjustForQtyOnHand:=$5
Else 
	$bAdjustForQtyOnHand:=False:C215
End if 
C_BOOLEAN:C305($6; $bAdjustTopQty)
If (Count parameters:C259>5)
	$bAdjustTopQty:=$6
Else 
	$bAdjustTopQty:=True:C214
End if 

Case of 
	: ($1=-1111)  //first level
		
		If ($bAdjustForQtyOnHand)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=$2->)
			vrBOMBuild_LeftOnHand:=[Item:4]qtyOnHand:14
			BOM_BuildCalcQty(-$3; ->vrBOMBuild_LeftOnHand; ->vrBOMBuild_AdjOnHand)
			C_REAL:C285($buildAdjOnHand)
			$buildAdjOnHand:=vrBOMBuild_AdjOnHand
			
			If (vrBOMBuild_AdjOnHand#0)
				Invt_dRecCreate("BM"; $adjID; 0; "BOM"; 0; "Build by BOM"; 4; 0; $2->; vrBOMBuild_AdjOnHand; 0; vR1; ""; vsiteID; 0)
			Else 
				ALERT:C41("There is sufficient quantity on hand of "+$2->+", so none were built.")
			End if 
		Else 
			Invt_dRecCreate("BM"; $adjID; 0; "BOM"; 0; "Build by BOM"; 4; 0; $2->; -$3; 0; vR1; ""; vsiteID; 0)
		End if 
		
		If (($bAdjustForQtyOnHand=False:C215) | (vrBOMBuild_AdjOnHand#0))
			QUERY:C277([BOM:21]; [BOM:21]itemNum:1=$2->)
			Bom_FillArray(Records in selection:C76([BOM:21]))
			$k:=Size of array:C274(aRptPartNum)
			$adjID:=DateTime_Enter
			For ($i; 1; $k)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=aRptPartNum{$i})
				$unitMeasBy:=1
				If ([Item:4]unitOfMeasure:11#"")  // Modified by: williamjames (111216 checked for <= length protection)
					If ([Item:4]unitOfMeasure:11[[1]]="*")
						C_REAL:C285($unitMeasBy)
						$unitMeasBy:=Item_PricePer(->[Item:4]unitOfMeasure:11)
					End if 
				End if 
				aCosts{$i}:=[Item:4]costAverage:13/$unitMeasBy
				$totalCost:=$totalCost+(aCosts{$i}*aQtyPlan{$i}*$3)
				Invt_dRecCreate("BM"; $adjID; 0; $2->; $adjID; "ivc 1child"; 1; 0; aRptPartNum{$i}; (aQtyPlan{$i}*$3); 0; aCosts{$i}; $2->; vsiteID; 0)
			End for 
			$0:=Abs:C99(Round:C94($totalCost/$3; <>tcDecimalUP))
		End if 
	Else   //:($1=-1112)//all levels
		vrBOMBuildParentQty:=-$3
		BOM_BuildExtend($2->; $bAdjustForQtyOnHand; ->vrBOMBuildParentQty; $bAdjustTopQty)
		Bom_CostItems
		If ($bAdjustForQtyOnHand)
			BOM_ExtendCost($adjID; $2; -vrBOMBuildParentQty; $bAdjustForQtyOnHand)
		Else 
			BOM_ExtendCost($adjID; $2; $3; $bAdjustForQtyOnHand)
		End if 
		$0:=vrBOMCostStandard
End case 