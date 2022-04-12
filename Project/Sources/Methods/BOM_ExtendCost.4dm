//%attributes = {"publishedWeb":true}
//Procedure: BOM_ExtendCost
C_LONGINT:C283($1; $adjID)
$adjID:=$1
C_POINTER:C301($2; $Source)
If (Count parameters:C259>1)
	$Source:=$2
Else 
	$Source:=(->vText1)
End if 
C_REAL:C285($3; $TopQty)
If (Count parameters:C259>2)
	$TopQty:=$3
Else 
	$TopQty:=1
End if 
C_BOOLEAN:C305($4; $bAdjustForQtyOnHand)
If (Count parameters:C259>3)
	$bAdjustForQtyOnHand:=$4
Else 
	$bAdjustForQtyOnHand:=False:C215
End if 

C_LONGINT:C283($jobID)
$jobID:=0
If (vrBOMFactor=0)
	vrBOMFactor:=3
End if 
$soa:=Size of array:C274(aRptPartNum)
C_LONGINT:C283($soa)
C_REAL:C285($theTotal)
Case of 
	: ($soa=0)
		$theTotal:=0
		vR1:=$theTotal
		vR2:=0
	: ($soa=1)
		$theTotal:=aQtyPlan{1}*aCosts{1}
		vR1:=$theTotal
		vR2:=aCostsLast{1}
		
		vR3:=vrBOMCostQty
		vR4:=vrBOMPriceQty
		If ($1#0)
			$i:=1
			Invt_dRecCreate("BM"; $adjID; 0; $Source->; $jobID; "BOM_ml_root_child"; 1; 0; aRptPartNum{$i}; aQtyPlan{$i}*$TopQty; 0; aCosts{$i}; $Source->; vsiteID; 0)
		End if 
	: ($soa>1)
		vi1:=0
		vR1:=0
		vR2:=0
		vR3:=0
		vR4:=0
		BOM_ChildCost($adjID; $Source; $TopQty; ->vi1; aBOMLevel{1}; $bAdjustForQtyOnHand)
End case 
vrBOMCostStandard:=Round:C94(vR1; <>tcDecimalUC)
vrBOMCostLast:=Round:C94(vR2; <>tcDecimalUC)
//
C_LONGINT:C283($cntRay; $incRay)
C_REAL:C285($levelTotal)
$cntRay:=Size of array:C274(aBOMLevel)-1
//
vrBOMCostQty:=0
vrBOMPriceQty:=0
$levelTotalCost:=0
$levelTotalPrice:=0
For ($incRay; 1; $cntRay)
	If (aBOMLevel{$incRay}<aBOMLevel{$incRay+1})  //find a parent
		aBOMCostsExpanded{$incRay}:=0
		aBomPriceExpanded{$incRay}:=0
	Else 
		vrBOMCostQty:=vrBOMCostQty+aBOMCostsExpanded{$incRay}
		vrBOMPriceQty:=vrBOMPriceQty+aBomPriceExpanded{$incRay}
	End if 
End for 
vrBOMCostQty:=vrBOMCostQty+aBOMCostsExpanded{$cntRay+1}
vrBOMPriceQty:=vrBOMPriceQty+aBomPriceExpanded{$cntRay+1}
