//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 05/24/07, 15:33:06
// ----------------------------------------------------
// Method: FC_FillArrays
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $doPO_WO)  //POs & WOs ;  expand BOM's
$doPO_WO:=$1
C_LONGINT:C283($2; $doBOM)
$doBOM:=$2
C_LONGINT:C283($3; $OrdersSubVsOrdLines)
$OrdersSubVsOrdLines:=$3
C_BOOLEAN:C305($4; $bAdjustForQtyOnHand; ThermoAbort)
C_POINTER:C301($5; $aBOMQtyLookupItemNum)
C_POINTER:C301($6; $aBOMQtyLookupQtyOnHand)
If (Count parameters:C259>5)
	$bAdjustForQtyOnHand:=$4
	//$bAdjustForQtyOnHand:=False
	$aBOMQtyLookupItemNum:=$5
	$aBOMQtyLookupQtyOnHand:=$6
Else 
	$bAdjustForQtyOnHand:=False:C215
	ARRAY TEXT:C222(aBOMQtyLookupItemNum; 0)
	ARRAY REAL:C219(aBOMQtyLookupQtyOnHand; 0)
	$aBOMQtyLookupItemNum:=->aBOMQtyLookupItemNum
	$aBOMQtyLookupQtyOnHand:=->aBOMQtyLookupQtyOnHand
End if 

If (False:C215)
	//Arrays displayed in area list
	//$error:=// -- AL_SetArraysNam (eForeCast;1;8;"aFCItem";"aFCDesc";"aFCActionDt";"aFCBomCnt";"aFCRunQty";"aFCBaseQty";"aFCTallyYTD";"aFCTallyLess1Year")
	//$error:=// -- AL_SetArraysNam (eForeCast;9;8;"aFCTallyLess2Year";"aFCBomLevel";"aFCParent";"aFCTypeTran";"aFCDocID";"aFCWho";"aFCtypeID";"aFCRecNum")
End if 



C_LONGINT:C283($k; $i; $w; $incBom; $maxBom; $n; $testCnt)
C_TEXT:C284($itemNum; $myPart; $levelStr)
C_LONGINT:C283($i; $k; $viProgressID)
C_REAL:C285($vrProgress)
C_TEXT:C284($vtMessage; $vtTitle)
C_BOOLEAN:C305($vbForeGround)
$vbForeground:=True:C214
$viProgressID:=0

READ ONLY:C145([Order:3])
READ ONLY:C145([PO:39])
READ ONLY:C145([POLine:40])
READ ONLY:C145([Item:4])
READ ONLY:C145([BOM:21])
READ ONLY:C145([OrderLine:49])

C_LONGINT:C283($i; $k; $w; $m)
C_BOOLEAN:C305($stopLoop)
ARRAY LONGINT:C221(aSOs; 0)
ARRAY TEXT:C222(a35Str4; 0)
ARRAY REAL:C219(aQtyBackOrd; 0)
ARRAY DATE:C224(aNeedDates; 0)
ARRAY LONGINT:C221(aORecNum; 0)
ARRAY TEXT:C222(a3Str1; 0)
ARRAY TEXT:C222(aText1; 0)

////Ray_ZeroElement (aSOs;a35Str4;aQtyBackOrd;aNeedDates;aORecNum;a3Str1)
$k:=Records in selection:C76([ProposalLine:43])
$viProgressID:=Progress New

//ThermoInitExit ("Processing Proposal Line.";$k;True)
FIRST RECORD:C50([ProposalLine:43])
For ($i; 1; $k)
	// ### jwm ### 20180719_1325
	ProgressUpdate($viProgressID; $i; $k; "Processing Proposal Lines:")
	//Thermo_Update ($i;$vNewThermoTitle)
	If (<>ThermoAbort)
		$i:=$k
	End if 
	If ([ProposalLine:43]calculateLine:20)
		If ([Proposal:42]idNum:5#[ProposalLine:43]idNumProposal:1)
			QUERY:C277([Proposal:42]; [Proposal:42]idNum:5=[ProposalLine:43]idNumProposal:1)
		End if 
		$itemCnt:=Round:C94([ProposalLine:43]qty:3*[ProposalLine:43]probability:9*0.01; 0)
		If ($itemCnt#0)
			$w:=Size of array:C274(aORecNum)+1
			Ray_InsertElems($w; 1; ->aSOs; ->a35Str4; ->aQtyBackOrd; ->aNeedDates; ->aORecNum; ->a3Str1; ->aText1)
			a3Str1{$w}:="Pp"
			aSOs{$w}:=[ProposalLine:43]idNumProposal:1
			a35Str4{$w}:=[ProposalLine:43]itemNum:2
			aQtyBackOrd{$w}:=$itemCnt
			aNeedDates{$w}:=[Proposal:42]dateNeeded:4
			aORecNum{$w}:=Record number:C243([Proposal:42])
			aText1{$w}:=[Proposal:42]company:11
			
			If ($bAdjustForQtyOnHand)
				//for each item add it to the lookup array  
				$find:=Find in array:C230($aBOMQtyLookupItemNum->; a35Str4{$w})
				If ($find<0)
					INSERT IN ARRAY:C227($aBOMQtyLookupItemNum->; 1)
					$aBOMQtyLookupItemNum->{1}:=a35Str4{$w}
					QUERY:C277([Item:4]; [Item:4]itemNum:1=a35Str4{$w})
					INSERT IN ARRAY:C227($aBOMQtyLookupQtyOnHand->; 1)
					$aBOMQtyLookupQtyOnHand->{1}:=[Item:4]qtyOnHand:14
					$find:=1
				End if 
			End if 
			
		End if 
		
	End if 
	NEXT RECORD:C51([ProposalLine:43])
End for 
//
//allowAlerts_boo:=True
//Thermo_Close 

//TRACE
$k:=Records in selection:C76([OrderLine:49])

FIRST RECORD:C50([OrderLine:49])
For ($i; 1; $k)
	// ### jwm ### 20180719_1325
	ProgressUpdate($viProgressID; $i; $k; "Processing Proposal Lines:")
	
	If (ThermoAbort)
		$i:=$k
	End if 
	$w:=Size of array:C274(aORecNum)+1
	Ray_InsertElems($w; 1; ->aSOs; ->a35Str4; ->aQtyBackOrd; ->aNeedDates; ->aORecNum; ->a3Str1; ->aText1)
	a3Str1{$w}:="SO"
	aSOs{$w}:=[OrderLine:49]idNumOrder:1
	a35Str4{$w}:=[OrderLine:49]itemNum:4
	aQtyBackOrd{$w}:=[OrderLine:49]qtyBackLogged:8
	aNeedDates{$w}:=[OrderLine:49]dateRequired:23
	
	If ($bAdjustForQtyOnHand)
		//for each item add it to the lookup array  
		$find:=Find in array:C230($aBOMQtyLookupItemNum->; a35Str4{$w})
		If ($find<0)
			INSERT IN ARRAY:C227($aBOMQtyLookupItemNum->; 1)
			$aBOMQtyLookupItemNum->{1}:=a35Str4{$w}
			QUERY:C277([Item:4]; [Item:4]itemNum:1=a35Str4{$w})
			INSERT IN ARRAY:C227($aBOMQtyLookupQtyOnHand->; 1)
			$aBOMQtyLookupQtyOnHand->{1}:=[Item:4]qtyOnHand:14
			$find:=1
		End if 
	End if 
	
	If ([OrderLine:49]idNumOrder:1#[Order:3]idNum:2)
		QUERY:C277([Order:3]; [Order:3]idNum:2=[OrderLine:49]idNumOrder:1)
	End if 
	If ([Order:3]dateNeeded:5=!00-00-00!)
		aNeedDates{$w}:=[Order:3]dateNeeded:5
	Else 
		aNeedDates{$w}:=[OrderLine:49]dateRequired:23
	End if 
	aORecNum{$w}:=Record number:C243([Order:3])
	aText1{$w}:=[Order:3]company:15
	NEXT RECORD:C51([OrderLine:49])
End for 

//TRACE
If ($doBOM=1)  //expand the BOM items
	$i:=1
	$myPart:=""
	$k:=Size of array:C274(a35Str4)
	//ThermoInitExit ("Expanding Bills of Materials.";$k;True)
	C_BOOLEAN:C305($bAdjustTopQty)
	$bAdjustTopQty:=True:C214
	
	ConsoleLog("BOM_BuildExtend")
	While ($i<=$k)
		$myPart:=a35Str4{$i}
		ARRAY TEXT:C222(aRptPartNum; 0)
		
		C_LONGINT:C283($fia)
		If ($bAdjustForQtyOnHand)
			$fia:=Find in array:C230($aBOMQtyLookupItemNum->; a35Str4{$i})
			If ($fia=-1)
				ALERT:C41("Fatal Error: item# not found in $aBOMQtyLookupItemNum in FC_FillArrays")
				$fia:=1
			End if 
		End if 
		
		vrBOMBuildParentQty:=aQtyBackOrd{$i}
		ConsoleLog(String:C10($i)+"\t"+a35Str4{$i})
		
		If (a35Str4{$i}#"")  // ### jwm ### 20180417_2351  verify this
			BOM_BuildExtend(a35Str4{$i}; $bAdjustForQtyOnHand; ->vrBOMBuildParentQty; $bAdjustTopQty; $aBOMQtyLookupItemNum; $aBOMQtyLookupQtyOnHand)
		Else 
			TRACE:C157
		End if 
		
		$maxBom:=Size of array:C274(aRptPartNum)
		//If (Size of array(aRptPartNum)>0)
		//invBOMSortbyPar 
		//End if 
		$stopLoop:=False:C215
		Repeat 
			// ### jwm ### 20180719_1325
			ProgressUpdate($viProgressID; $i; $k; "Processing Proposal Lines:")
			
			//      $myQty:=aQtyBackOrd{$i}
			//      Item number; Quantity; NeedDate; Level; Parent Item; Type Trans;
			//      Doc ID, Record Number
			If ($maxBom=0)
				$levelStr:="Prime No BOM"
				BOM_NeedExpand(a35Str4{$i}; -aQtyBackOrd{$i}; aNeedDates{$i}; $levelStr; a35Str4{$i}; a3Str1{$i}; aSOs{$i}; aORecNum{$i}; ->aText1{$i})
			Else 
				$levelStr:="Prime w/ BOM"
				BOM_NeedExpand(a35Str4{$i}; -aQtyBackOrd{$i}; aNeedDates{$i}; $levelStr; a35Str4{$i}; a3Str1{$i}; aSOs{$i}; aORecNum{$i}; ->aText1{$i})
				
				For ($incBom; 1; $maxBom)
					$levelStr:=""
					$testCnt:=$incBom
					Repeat 
						Case of 
							: ($testCnt=$maxBom)
								$levelStr:="Root Level"
							: (aBOMLevel{$testCnt}<aBOMLevel{($testCnt+1)})
								$levelStr:="Intermediate"
							: (aBOMLevel{$testCnt}>=aBOMLevel{($testCnt+1)})
								$levelStr:="Root Level"
						End case 
						$testCnt:=$testCnt+1
					Until ($levelStr#"")
					//BOM_NeedExpand (aRptPartNum{$incBom};-(aQtyBackOrd{$i}
					//*aQtyAct{$incBom});aNeedDates{$i};$levelStr;a35Str4{$i};a3Str1{$i};aSOs{$i}
					//;aORecNum{$i};->aText1{$i})
					If ($bAdjustForQtyOnHand)
						BOM_NeedExpand(aRptPartNum{$incBom}; -aQtyAdjOnHand{$incBom}; aNeedDates{$i}; $levelStr; a35Str4{$i}; a3Str1{$i}; aSOs{$i}; aORecNum{$i}; ->aText1{$i})
					Else 
						BOM_NeedExpand(aRptPartNum{$incBom}; -(aQtyBackOrd{$i}*aQtyAct{$incBom}); aNeedDates{$i}; $levelStr; a35Str4{$i}; a3Str1{$i}; aSOs{$i}; aORecNum{$i}; ->aText1{$i})
					End if 
				End for 
			End if 
			$i:=$i+1
			Case of 
				: (ThermoAbort)
					$i:=$k+1
					$stopLoop:=True:C214  //$i:=$k
				: ($i>$k)
					$stopLoop:=True:C214
				: ($myPart#a35Str4{$i})
					$stopLoop:=True:C214
			End case 
		Until ($stopLoop)
	End while 
	//allowAlerts_boo:=True
	//Thermo_Close 
End if 
//  
If ($1=1)
	ORDER BY:C49([POLine:40]; [POLine:40]idNumPO:1)
	$i:=0
	$k:=Records in selection:C76([POLine:40])
	//ThermoInitExit ("Processing PO Lines.";$k;True)
	FIRST RECORD:C50([POLine:40])
	While ($k>$i)
		
		If ([POLine:40]idNumPO:1#[PO:39]idNum:5)
			QUERY:C277([PO:39]; [PO:39]idNum:5=[POLine:40]idNumPO:1)
		End if 
		// ### jwm ### 20180719_1325
		ProgressUpdate($viProgressID; $i; $k; "Processing Proposal Lines:")
		
		If (ThermoAbort)
			$i:=$k
		End if 
		$i:=$i+1
		BOM_NeedExpand([POLine:40]itemNum:2; [POLine:40]qtyBackLogged:5; [POLine:40]dateExpected:15; "Purchase"; [POLine:40]itemNum:2; "PO"; [POLine:40]idNumPO:1; Record number:C243([POLine:40]); ->[PO:39]vendorCompany:39)
		NEXT RECORD:C51([POLine:40])
	End while 
	UNLOAD RECORD:C212([POLine:40])
	//allowAlerts_boo:=True
	//Thermo_Close 
	//
	$i:=0
	$k:=Records in selection:C76([WorkOrder:66])
	If ($k>0)
		FIRST RECORD:C50([WorkOrder:66])
		While ($k>$i)
			
			If (ThermoAbort)
				$i:=$k
			End if 
			$i:=$i+1
			
			// ### jwm ### 20180719_1325
			ProgressUpdate($viProgressID; $i; $k; "Processing Proposal Lines:")
			
			DateTime_DTFrom([WorkOrder:66]dtAction:5; ->vDate1; ->vTime1)
			BOM_NeedExpand([WorkOrder:66]itemNum:12; [WorkOrder:66]qtyOrdered:13-[WorkOrder:66]qty:14; vDate1; "Work"; [WorkOrder:66]itemNum:12; "WO"; [WorkOrder:66]idNum:29; Record number:C243([WorkOrder:66]); ->[WorkOrder:66]customerID:28)
			NEXT RECORD:C51([WorkOrder:66])
		End while 
		UNLOAD RECORD:C212([WorkOrder:66])
	End if 
	
	
End if 
//

Progress QUIT($viProgressID)

Ray_ZeroElement(->aSOs; ->a35Str4; ->aQtyBackOrd; ->aNeedDates; ->aORecNum; ->a3Str1; ->aText1)
doSearch:=8
