//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): root
// Date and time: 05/24/07, 09:31:45
// ----------------------------------------------------
// Method: BOM_BuildExtend
// Description
// 
//
// Parameters
// ----------------------------------------------------


C_TEXT:C284($1; $parentItemNum)
$parentItemNum:=$1
C_BOOLEAN:C305($2; $bAdjustForQtyOnHand)
C_POINTER:C301($3; $rParentQty)
C_BOOLEAN:C305($4; $bAdjustTopQty)
C_POINTER:C301($5; $aBOMQtyLookupItemNum)
C_POINTER:C301($6; $aBOMQtyLookupQtyOnHand)
If (Count parameters:C259>=2)
	$bAdjustForQtyOnHand:=$2
	$rParentQty:=$3
	
	If (Count parameters:C259>=4)
		$bAdjustTopQty:=$4
	Else 
		$bAdjustTopQty:=True:C214
	End if 
	
	If (Count parameters:C259>=5)
		$aBOMQtyLookupItemNum:=$5
		$aBOMQtyLookupQtyOnHand:=$6
	Else 
		ARRAY TEXT:C222(aBOMQtyLookupItemNum; 0)
		ARRAY REAL:C219(aBOMQtyLookupQtyOnHand; 0)
		$aBOMQtyLookupItemNum:=->aBOMQtyLookupItemNum
		$aBOMQtyLookupQtyOnHand:=->aBOMQtyLookupQtyOnHand
	End if 
Else 
	$bAdjustForQtyOnHand:=False:C215
End if 
//
C_REAL:C285(vrBOMBuildParentQty)  //this is the parent quantity used by parent calls to this method
C_LONGINT:C283($i; $k; $Begin; $End; $Level; $w; $fia)
C_REAL:C285($QtyRequested)
C_REAL:C285(vrBOMBuild_LeftOnHand; vrBOMBuild_AdjOnHand; $rParentBuildQty)
If ($bAdjustForQtyOnHand)
	$fia:=Find in array:C230($aBOMQtyLookupItemNum->; $parentItemNum)
	If ($fia<0)
		INSERT IN ARRAY:C227($aBOMQtyLookupItemNum->; 1)
		$aBOMQtyLookupItemNum->{1}:=$parentItemNum
		QUERY:C277([Item:4]; [Item:4]itemNum:1=$parentItemNum)
		INSERT IN ARRAY:C227($aBOMQtyLookupQtyOnHand->; 1)
		$aBOMQtyLookupQtyOnHand->{1}:=[Item:4]qtyOnHand:14
		$fia:=1
	End if 
	
	If ($bAdjustTopQty)
		vrBOMBuild_LeftOnHand:=$aBOMQtyLookupQtyOnHand->{$fia}
		BOM_BuildCalcQty($rParentQty->; ->vrBOMBuild_LeftOnHand; ->vrBOMBuild_AdjOnHand)
		$aBOMQtyLookupQtyOnHand->{$fia}:=vrBOMBuild_LeftOnHand
		$rParentBuildQty:=vrBOMBuild_AdjOnHand
		$rParentQty->:=$rParentBuildQty
	Else 
		$rParentBuildQty:=$rParentQty->
	End if 
Else 
	$rParentBuildQty:=1
End if 

Bom_FillArray(0)

If ($rParentBuildQty#0)
	$k:=0
	$Level:=0
	$Begin:=0
	$End:=0
	$w:=0
	aBOMLevel{0}:=0
	QUERY:C277([BOM:21]; [BOM:21]ItemNum:1=$parentItemNum)
	While (Records in selection:C76([BOM:21])>0)  //was While changed 070523
		$k:=Records in selection:C76([BOM:21])
		$Begin:=$w+1
		$End:=$Begin+$k-1
		
		//Bom_FillArray (-9;$Begin;$k)
		//If (False)
		INSERT IN ARRAY:C227(aRptPartNum; $Begin; $k)
		INSERT IN ARRAY:C227(aRptPartDsc; $Begin; $k)
		INSERT IN ARRAY:C227(aBOMLevel; $Begin; $k)  //Depth in BOM
		INSERT IN ARRAY:C227(aQtyPlan; $Begin; $k)  //Needed at this BOM Point
		INSERT IN ARRAY:C227(aQtyAct; $Begin; $k)  //Needed for total at this level
		INSERT IN ARRAY:C227(aQtyReducedByOnHand; $Begin; $k)
		INSERT IN ARRAY:C227(aQtyAdjOnHand; $Begin; $k)
		INSERT IN ARRAY:C227(aChecks; $Begin; $k)
		INSERT IN ARRAY:C227(aCosts; $Begin; $k)
		INSERT IN ARRAY:C227(aCostsLast; $Begin; $k)
		INSERT IN ARRAY:C227(aBomCmt; $Begin; $k)
		INSERT IN ARRAY:C227(aBomRecs; $Begin; $k)
		
		INSERT IN ARRAY:C227(aBomBuildNote; $Begin; $k)
		INSERT IN ARRAY:C227(aBomDescription; $Begin; $k)
		INSERT IN ARRAY:C227(aBOMCostsExpanded; $Begin; $k)
		INSERT IN ARRAY:C227(aBomPriceExpanded; $Begin; $k)
		//End if 
		
		//  $RecsAtLevel:=$k
		$Level:=aBOMLevel{$w}+1
		FIRST RECORD:C50([BOM:21])
		For ($i; $Begin; $End)
			aRptPartNum{$i}:=[BOM:21]ChildItem:2
			aRptPartDsc{$i}:=[BOM:21]Description:6
			aQtyPlan{$i}:=[BOM:21]QtyInAssembly:3
			aCosts{$i}:=0
			aCostsLast{$i}:=0
			aBOMLevel{$i}:=$Level
			aChecks{$i}:=""
			aBomCmt{$i}:=[BOM:21]Comment:5
			aBomRecs{$i}:=Record number:C243([BOM:21])
			
			aBomBuildNote{$i}:=""
			aBomDescription{$i}:=""
			aBOMCostsExpanded{$i}:=0
			aBomPriceExpanded{$i}:=0
			
			
			If ($w>0)
				aQtyAct{$i}:=[BOM:21]QtyInAssembly:3*aQtyAct{$w}
			Else 
				aQtyAct{$i}:=[BOM:21]QtyInAssembly:3
			End if 
			
			If ($bAdjustForQtyOnHand)
				If ($w>0)
					$QtyRequested:=[BOM:21]QtyInAssembly:3*aQtyReducedByOnHand{$w}
				Else 
					$QtyRequested:=[BOM:21]QtyInAssembly:3*$rParentBuildQty
				End if 
				$fia:=Find in array:C230($aBOMQtyLookupItemNum->; [BOM:21]ChildItem:2)
				If ($fia<0)
					INSERT IN ARRAY:C227($aBOMQtyLookupItemNum->; 1)
					$aBOMQtyLookupItemNum->{1}:=[BOM:21]ChildItem:2
					QUERY:C277([Item:4]; [Item:4]itemNum:1=[BOM:21]ChildItem:2)
					INSERT IN ARRAY:C227($aBOMQtyLookupQtyOnHand->; 1)
					$aBOMQtyLookupQtyOnHand->{1}:=[Item:4]qtyOnHand:14
					$fia:=1
				End if 
				vrBOMBuild_LeftOnHand:=$aBOMQtyLookupQtyOnHand->{$fia}
				BOM_BuildCalcQty($QtyRequested; ->vrBOMBuild_LeftOnHand; ->vrBOMBuild_AdjOnHand)
				$aBOMQtyLookupQtyOnHand->{$fia}:=vrBOMBuild_LeftOnHand
				aQtyReducedByOnHand{$i}:=vrBOMBuild_AdjOnHand
				aQtyAdjOnHand{$i}:=$QtyRequested
				// Modified by: Bill James (2017-06-09T00:00:00)  Alignment
				If (aQtyAdjOnHand{$i}=0)
					aChecks{$w}:="X"
				End if 
			Else 
				aQtyAdjOnHand{$i}:=aQtyAct{$i}
			End if 
			
			NEXT RECORD:C51([BOM:21])
		End for 
		REDUCE SELECTION:C351([BOM:21]; 0)  //had to add to prevent an array error message keep the While
		Repeat 
			$w:=Find in array:C230(aChecks; "")
			If ($w>0)  //#-1)
				QUERY:C277([BOM:21]; [BOM:21]ItemNum:1=aRptPartNum{$w})
				aChecks{$w}:="X"
			End if 
		Until ((Records in selection:C76([BOM:21])>0) | ($w=-1))
	End while 
	
	If ($bAdjustForQtyOnHand)
		$k:=Size of array:C274(aRptPartNum)
		
		For ($i; $k; 1; -1)  // steping backwards so indexing is correct
			If (aQtyAdjOnHand{$i}=0)
				DELETE FROM ARRAY:C228(aRptPartNum; $i)
				DELETE FROM ARRAY:C228(aRptPartDsc; $i)
				DELETE FROM ARRAY:C228(aBOMLevel; $i)  //Depth in BOM
				DELETE FROM ARRAY:C228(aQtyPlan; $i)  //Needed at this BOM Point
				DELETE FROM ARRAY:C228(aQtyAct; $i)  //Needed for total at this level
				DELETE FROM ARRAY:C228(aQtyReducedByOnHand; $i)
				DELETE FROM ARRAY:C228(aQtyAdjOnHand; $i)
				DELETE FROM ARRAY:C228(aChecks; $i)
				DELETE FROM ARRAY:C228(aCosts; $i)
				DELETE FROM ARRAY:C228(aCostsLast; $i)
				DELETE FROM ARRAY:C228(aBomCmt; $i)
				DELETE FROM ARRAY:C228(aBomRecs; $i)
				//
				DELETE FROM ARRAY:C228(aBomBuildNote; $i)
				DELETE FROM ARRAY:C228(aBomDescription; $i)
				DELETE FROM ARRAY:C228(aBOMCostsExpanded; $i)
				DELETE FROM ARRAY:C228(aBomPriceExpanded; $i)
			End if 
		End for 
	End if 
	
	$k:=Size of array:C274(aRptPartNum)
	ARRAY LONGINT:C221(aBOMPlace; $k)
	For ($i; 1; $k)
		aBOMPlace{$i}:=$i
	End for 
End if 
UNLOAD RECORD:C212([BOM:21])