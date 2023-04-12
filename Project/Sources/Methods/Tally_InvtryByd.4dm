//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): jimmedlen
// Date and time: 03/21/13, 15:02:22
// ----------------------------------------------------
// Method: Tally_InvtryByd
// Description
// File: Tally_InvtryByd.txt
// Parameters
// ----------------------------------------------------
//### jwm ### 20130321_1651 set vsiteID
//### jwm ### 20130321_1651 set vsiteID

C_TEXT:C284($1)  //"s" if for a sales order.
C_LONGINT:C283($2)  //level of removal, -1111 or  -1112
//
C_LONGINT:C283($i; $k; $e; $f; $totalCnt; $2)
C_TEXT:C284($partNum; $docType; $docID)
C_REAL:C285($qtyTotal; $offBy; $belowZero; $fullCost)

C_BOOLEAN:C305($3; $bAdjustForQtyOnHand)
If (Count parameters:C259>2)
	$bAdjustForQtyOnHand:=$3
Else 
	$bAdjustForQtyOnHand:=False:C215
End if 

ORDER BY:C49([DInventory:36]itemNum:1)
If ($1="i")
	$ptField:=(->[DInventory:36]qtyOnHand:2)
	vsiteID:=[DInventory:36]siteID:20  //### jwm ### 20130321_1651 set vsiteID
Else   //  ([dInventory]typeID1="s")
	$ptField:=(->[DInventory:36]qtyOnSO:3)
	vsiteID:=[Order:3]siteID:106  //### jwm ### 20130321_1651 set vsiteID
End if 

$i:=0  //[dInventory]QtyOnHand
$k:=Records in selection:C76([DInventory:36])
FIRST RECORD:C50([DInventory:36])
While ($i<$k)
	$totalCnt:=0
	$partNum:=[DInventory:36]itemNum:1
	//QUERY([Item];[Item]ItemNum=$partNum)
	//$belowZero:=[Item]QtyOnHand*Num([Item]QtyOnHand<0)
	$vrOffBy:=0
	Repeat 
		$i:=$i+1
		$totalCnt:=$totalCnt+$ptField->
		NEXT RECORD:C51([DInventory:36])
	Until ([DInventory:36]itemNum:1#$partNum)
	If ($1="s")  //so On Order consumes
		$totalCnt:=-$totalCnt
	End if 
	QUERY:C277([BOM:21]; [BOM:21]itemNum:1=$partNum)
	If (Records in selection:C76([BOM:21])>0)
		$adjID:=DateTime_DTTo
		vPartNum:=$partNum
		vR1:=BOM_Consume($2; ->vPartNum; $totalCnt; $adjID; $bAdjustForQtyOnHand)
		If ($bAdjustForQtyOnHand)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=$partNum)
			vrBOMBuild_LeftOnHand:=[Item:4]qtyOnHand:14
			BOM_BuildCalcQty(-$totalCnt; ->vrBOMBuild_LeftOnHand; ->vrBOMBuild_AdjOnHand)
			Invt_dRecCreate("BM"; $adjID; 0; "BOM"; 0; "Build by BOM"; 4; 0; $partNum; vrBOMBuild_AdjOnHand; 0; vR1; ""; vsiteID; 0)
		Else 
			Invt_dRecCreate("BM"; $adjID; 0; "BOM"; 0; "Build by BOM"; 4; 0; $partNum; -$totalCnt; 0; vR1; ""; vsiteID; 0)
		End if 
	End if 
End while 

REDUCE SELECTION:C351([DInventory:36]; 0)
If (Size of array:C274(dItemNumKey)>0)
	READ WRITE:C146([DInventory:36])
	ARRAY TO SELECTION:C261(dItemNumKey; [DInventory:36]itemNum:1; dQtyOnHand; [DInventory:36]qtyOnHand:2; dQtyOnSO; [DInventory:36]qtyOnSO:3; dQtyOnPO; [DInventory:36]qtyOnPo:4; dQtyOnWO; [DInventory:36]qtyOnWO:5; dQtyOnAdj; [DInventory:36]qtyOnAdj:6; dUnitCost; [DInventory:36]unitCost:7; dJobID; [DInventory:36]idNumProject:8; dDocID; [DInventory:36]idNumDoc:9; dLineNum; [DInventory:36]idNumLine:10; dReceiptID; [DInventory:36]idReceipt:11; dSource; [DInventory:36]customerID:12; dReason; [DInventory:36]reason:13; dType; [DInventory:36]typeID:14; dDTCreated; [DInventory:36]dtCreated:15; dNote; [DInventory:36]note:18; dTakeAction; [DInventory:36]takeAction:19; dSite; [DInventory:36]siteID:20; dUnitPrice; [DInventory:36]unitPrice:21; dChangeBy; [DInventory:36]changedBy:22)
	READ ONLY:C145([DInventory:36])
	IVNT_dRayInit
	
End if 
TallyInventory