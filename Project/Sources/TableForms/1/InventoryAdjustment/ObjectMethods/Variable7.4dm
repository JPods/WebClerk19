// ----------------------------------------------------
// User name (OS): jimmedlen
// Date and time: 03/19/13, 14:05:01
// ----------------------------------------------------
// Method: Object Method: [Default]Invt_dRecCreate.b5
// Description
// Form: 
// File: Object Method: [Default]Invt_dRecCreate.b5.txt
// Parameters
// ----------------------------------------------------
// ### jwm ### 20130319_1401 changed <>tcsiteID to vsiteID
// ### jwm ### 20150722_2320 added new TallyMaster Script
// ### jwm ### 20160107_1443 Updated dInventory record for Multi-BOM *** DEBUG THIS ***
// ### jwm ### 20160616_0958 changed shortcut key to F7

//
//KeyModifierCurrent 
//QUERY([Item];[Item]ItemNum=aLsItemNum{aItemLines{1}})
//If (OptKey=1)
QUERY:C277([BOM:21]; [BOM:21]itemNum:1=aLsItemNum{aItemLines{1}})
$k:=Records in selection:C76([BOM:21])
C_REAL:C285($qtyChange)
$qtyChange:=-aLSQtySO{aItemLines{1}}
Case of 
	: ($k=0)
		ALERT:C41("Item Number "+aLsItemNum{aItemLines{1}}+" does not have a BOM defined.")
	: (aLSQtySO{aItemLines{1}}=0)
		ALERT:C41("No Quantity change for selected line.")
	Else 
		If (aLSQtySO{aItemLines{1}}>0)
			//CONFIRM("Build "+aLsItemNum{aItemLines{1}}+" from BOM Items: "+String(aLSQtySO{aItemLines{1}})+".")
			CONFIRM:C162("Build "+String:C10(aLSQtySO{aItemLines{1}})+" of "+aLsItemNum{aItemLines{1}}+" by Multi Level BOM.")
		Else 
			CONFIRM:C162("Return BOM components to stock from "+aLsItemNum{aItemLines{1}}+":  "+String:C10($qtyChange)+".")
		End if 
		If (OK=1)
			$theLocation:=-1112
			$BomID:=-DateTime_Enter
			C_LONGINT:C283($BomID)
			C_REAL:C285($unitCost)
			
			C_BOOLEAN:C305($bAdjustTopQty)
			$bAdjustTopQty:=False:C215
			
			C_BOOLEAN:C305($bAccountForQtyOnHand)
			CONFIRM:C162("Do you want to account for Quantity on Hand?")
			$bAccountForQtyOnHand:=(OK=1)
			
			IVNT_dRayInit
			
			$unitCost:=BOM_Consume($theLocation; ->aLsItemNum{aItemLines{1}}; $qtyChange; $BomID; $bAccountForQtyOnHand; $bAdjustTopQty)
			//aiExtCost{$1}:=Round(aiQtyShip{$1}*aiUnitCost{$1};<>tcDecimalTt)    
			Bom_FillArray(0)
			
			//Invt_dRecCreate ("AJ";$BomID;$BomID;"Adjustment";$BomID;v3;$dAction;0;aLsItemNum{aItemLines{1}};-$qtyChange;0;$unitCost;"";vsiteID;0)
			// ### jwm ### 20160106_1632
			//Invt_dRecCreate ("BM";$adjID;0     ;$Source->                ;$jobID  ;"ivc 1child"     ;1 ;0;aRptPartNum{$i}          ;aQtyPlan{$i}*$TopQty;0;aCosts{$i};$Source->               ;vsiteID;0)
			//Invt_dRecCreate ("BM";$adjID;0;$1                       ;$transID;"Build by BOM"   ;4;0;$1                       ;$3         ;0;$fullCost;""                       ;vsiteID;0)  //### jwm ### 20130319_1350
			// ### jwm ### 20160107_1443 Updated dInventory record for Multi-BOM
			Invt_dRecCreate("BM"; $BomID; 0; aLsItemNum{aItemLines{1}}; $BomID; "BOM_ml_parent_build"; 4; 0; aLsItemNum{aItemLines{1}}; -$qtyChange; 0; $unitCost; aLsItemNum{aItemLines{1}}; vsiteID; 0)
			
			INVT_dInvtApply
			
			IVNT_dRayInit
			TallyInventory
			aLsQtyOH{aItemLines{1}}:=aLsQtyOH{aItemLines{1}}+aLSQtySO{aItemLines{1}}  //NO CHANGE  +- match
			aLSQtySO{aItemLines{1}}:=0
			//  --  CHOPPED  AL_UpdateArrays(eItemList; -2)
			
			// ### jwm ### 20150722_2320 added new TallyMaster Script
			Execute_TallyMaster("Multi BOM"; "AdjustInventory"; 1)
			
		End if 
		
End case 
UNLOAD RECORD:C212([BOM:21])
UNLOAD RECORD:C212([Item:4])

HIGHLIGHT TEXT:C210(srItem; 1; Length:C16(srItem)+1)  // ### jwm ### 20160622_0857