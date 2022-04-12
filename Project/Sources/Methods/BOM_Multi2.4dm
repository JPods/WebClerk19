//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): jimmedlen
// Date and time: 04/04/13, 14:55:30
// ----------------------------------------------------
// Method: BOM_Multi2
// Description
// File: BOM_Multi2.txt
// Parameters
// ----------------------------------------------------
//04/04/2013 15:20 - currently orphaned method make sure to set vsiteID in calling procedure

//Procedure: BOM_ExtendCost
C_LONGINT:C283($i; $k; $w; $adjID)
C_POINTER:C301($2)
C_REAL:C285($3)
$k:=Size of array:C274(aRptPartNum)
C_REAL:C285($levelSum; $theTotal; $0; $levelQty; $unitSum)
$adjID:=$1
TRACE:C157
Case of 
	: ($k=0)
		$theTotal:=0
	: ($k=1)
		$theTotal:=aQtyact{1}*aCosts{1}*$3
		If ($1#0)
			$i:=1
			Invt_dRecCreate("BM"; $adjID; 0; $2->; $transID; "BOM_ml_1child"; 1; 0; aRptPartNum{$i}; aQtyact{$i}*$3; 0; aCosts{$i}; $2->; vsiteID; 0)
		End if 
	: ($k>1)
		$i:=$k
		$thisLine:=$k
		$w:=$i-1
		$theLevel:=aBOMLevel{$i}
		ARRAY REAL:C219(aReal1; $theLevel)
		$theTotal:=0
		//  $levelSum:=$levelSum+(aQtyact{1}*aCosts{1})
		While ($i>0)
			If (aBOMLevel{$i}#1)
				While ((aBOMLevel{$i}<=aBOMLevel{$w}) & ($i>0))
					If ($1#0)  //& (False))  //manage the sub item without sub components
						Invt_dRecCreate("BM"; $adjID; 0; $2->; $transID; "BOM_ml_rootchild"; 1; 0; aRptPartNum{$i}; (aQtyAct{$i}*$3); 0; aCosts{$i}; $2->; vsiteID; 0)
					End if 
					$levelSum:=$levelSum+(aQtyact{$i}*aCosts{$i})
					$i:=$i-1
					$w:=$i-1
				End while 
				If ($1#0)  //& (False))  //add the built item and subtract it
					Invt_dRecCreate("BM"; $adjID; 0; $2->; $transID; "BOM_ml_rootchild"; 1; 0; aRptPartNum{$i}; (aQtyAct{$i}*$3); 0; aCosts{$i}; $2->; vsiteID; 0)
					$levelSum:=$levelSum+(aQtyact{$i}*aCosts{$i})
					$i:=$i-1
					$unitSum:=Round:C94($levelSum/aQtyPlan{$i}; <>tcDecimalUC)
					If ($i>0)
						Invt_dRecCreate("BM"; $adjID; 0; $2->; $transID; "BOM_ml_midchild"; 1; 0; aRptPartNum{$i}; (aQtyAct{$i}*$3); 0; $unitSum; $2->; vsiteID; 0)
						Invt_dRecCreate("BM"; $adjID; 0; $2->; $transID; "BOM_ml_midchild"; 1; 0; aRptPartNum{$i}; -(aQtyAct{$i}*$3); 0; $unitSum; $2->; vsiteID; 0)
					End if 
					If ($i=2)
						If (aBOMLevel{1}<aBOMLevel{2})
							$levelSum:=$levelSum+($unitSum*aQtyPlan{1})
							Invt_dRecCreate("BM"; $adjID; 0; $2->; $transID; "BOM_ml_midchild"; 1; 0; aRptPartNum{$1}; (aQtyAct{$1}*$3); 0; $unitSum; $2->; vsiteID; 0)
							Invt_dRecCreate("BM"; $adjID; 0; $2->; $transID; "BOM_ml_midchild"; 1; 0; aRptPartNum{$1}; -(aQtyAct{$1}*$3); 0; $unitSum; $2->; vsiteID; 0)
							$i:=0
						End if 
					End if 
				Else 
					$doLast:=True:C214
					If ($i=2)
						If (aBOMLevel{1}<aBOMLevel{2})
							$levelSum:=$levelSum+($unitSum*aQtyPlan{1})
							Invt_dRecCreate("BM"; $adjID; 0; $2->; $transID; "BOM_ml_midchild"; 1; 0; aRptPartNum{$1}; (aQtyAct{$1}*$3); 0; $unitSum; $2->; vsiteID; 0)
							Invt_dRecCreate("BM"; $adjID; 0; $2->; $transID; "BOM_ml_midchild"; 1; 0; aRptPartNum{$1}; -(aQtyAct{$1}*$3); 0; $unitSum; $2->; vsiteID; 0)
							$i:=0
							$doLast:=True:C214
						End if 
					End if 
					
					$levelSum:=$levelSum+(aQtyact{$i}*aCosts{$i})
					$i:=$i-1
				End if 
			Else 
				$levelSum:=$levelSum+(aQtyact{$i}*aCosts{$i})
				If ($1#0)  //& (False))  //manage the sub item without sub components
					Invt_dRecCreate("BM"; $adjID; 0; $2->; $transID; "BOM_ml_rootchild"; 1; 0; aRptPartNum{$i}; (aQtyAct{$i}*$3); 0; aCosts{$i}; $2->; vsiteID; 0)
				End if 
			End if 
			$i:=$i-1
			$w:=$i-1
			$theTotal:=$theTotal+$levelSum
			$levelSum:=0
		End while 
End case 
$0:=Round:C94($theTotal; <>tcDecimalUC)