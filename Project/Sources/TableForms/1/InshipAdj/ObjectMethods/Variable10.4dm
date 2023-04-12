doSearch:=12
C_LONGINT:C283($i; $k; $w)
TRACE:C157
KeyModifierCurrent
$k:=Size of array:C274(aStkSelect)
CONFIRM:C162("Apply Changes to "+String:C10($k)+" selected lines.")
If (OK=1)
	READ WRITE:C146([InventoryStack:29])
	//READ WRITE([POLine])
	READ WRITE:C146([DInventory:36])
	ARRAY LONGINT:C221($aDoPos; 0)
	READ WRITE:C146([POLine:40])
	C_REAL:C285($dUtCost; $dDuty; $dNotProd; $dVAT)
	For ($i; 1; $k)
		GOTO RECORD:C242([InventoryStack:29]; aStkRec{aStkSelect{$i}})
		$dUtCost:=aStkNwCost{aStkSelect{$i}}-aStkOrCost{aStkSelect{$i}}
		$dDuty:=aStkDuty{aStkSelect{$i}}-[InventoryStack:29]duties:21
		$dNotProd:=aStkNonPd{aStkSelect{$i}}-[InventoryStack:29]nonProcCosts:22
		$dVAT:=aStkVAT{aStkSelect{$i}}-[InventoryStack:29]taxVA:23
		//
		If (OptKey=1)
			QUERY:C277([POLine:40]; [POLine:40]idNumPO:1=[InventoryStack:29]docid:5; *)
			QUERY:C277([POLine:40];  & [POLine:40]lineNum:14=[InventoryStack:29]lineNum:12)
			If (Records in selection:C76([POLine:40])=1)
				[POLine:40]nonProdCosts:28:=aStkNonPd{aStkSelect{$i}}
				[POLine:40]duties:30:=aStkDuty{aStkSelect{$i}}
				[POLine:40]vaTax:10:=aStkVAT{aStkSelect{$i}}
				If ($dUtCost#0)
					[POLine:40]unitCost:7:=aStkNwCost{aStkSelect{$i}}
					[POLine:40]discount:8:=0
					[POLine:40]extendedCost:9:=([POLine:40]unitCost:7*[POLine:40]qty:3)
				End if 
				SAVE RECORD:C53([POLine:40])
				$w:=Find in array:C230($aDoPos; [POLine:40]idNumPO:1)
				If ($w<1)
					INSERT IN ARRAY:C227($aDoPos; 1; 1)
					$aDoPos{1}:=[POLine:40]idNumPO:1
				End if 
				UNLOAD RECORD:C212([POLine:40])
			Else 
				TRACE:C157
			End if 
		End if 
		//
		If ([InventoryStack:29]qtyOnHand:9#0)
			$dSumCost:=Round:C94(($dUtCost+$dDuty+$dNotProd)/[InventoryStack:29]qtyOnHand:9; <>tcDecimalTt)
		Else 
			$dSumCost:=$dUtCost+$dDuty+$dNotProd
		End if 
		If (($dUtCost#0) | ($dDuty#0) | ($dNotProd#0) | ($dSumCost#0))
			[InventoryStack:29]idWayBill:24:=v1
			[InventoryStack:29]duties:21:=aStkDuty{aStkSelect{$i}}
			[InventoryStack:29]nonProcCosts:22:=aStkNonPd{aStkSelect{$i}}
			[InventoryStack:29]unitCost:11:=aStkNwCost{aStkSelect{$i}}
			[InventoryStack:29]extendedCost:17:=[InventoryStack:29]unitCost:11*[InventoryStack:29]qtyOnHand:9
			[InventoryStack:29]currentValue:15:=[InventoryStack:29]unitCost:11*[InventoryStack:29]qtyAvailable:14
			aStkOrCost{aStkSelect{$i}}:=aStkNwCost{aStkSelect{$i}}
			SAVE RECORD:C53([InventoryStack:29])
			CREATE RECORD:C68([DInventory:36])
			
			[DInventory:36]itemNum:1:=[InventoryStack:29]itemNum:2
			[DInventory:36]qtyOnHand:2:=0
			[DInventory:36]qtyOnSO:3:=0
			[DInventory:36]qtyOnPo:4:=0
			[DInventory:36]qtyOnWO:5:=0
			[DInventory:36]qtyOnAdj:6:=[InventoryStack:29]qtyOnHand:9
			[DInventory:36]idNumProject:8:=[InventoryStack:29]idNumProject:4
			[DInventory:36]idNumDoc:9:=[InventoryStack:29]idNum:1
			[DInventory:36]idNumLine:10:=0
			[DInventory:36]idReceipt:11:=[InventoryStack:29]idReceipt:16
			[DInventory:36]customerID:12:=[InventoryStack:29]vendorID:10
			[DInventory:36]reason:13:=[InventoryStack:29]changeReason:6
			[DInventory:36]typeID:14:="Ch"
			[DInventory:36]dtCreated:15:=DateTime_DTTo
			[DInventory:36]note:18:=""
			[DInventory:36]takeAction:19:=15
			[DInventory:36]siteID:20:=""
			[DInventory:36]unitPrice:21:=0
			[DInventory:36]changedBy:22:=Current user:C182
			[DInventory:36]nonProdCost:25:=$dNotProd
			[DInventory:36]unitCost:7:=$dUtCost
			[DInventory:36]duties:26:=$dDuty
			[DInventory:36]vaTax:27:=$dVAT
			[DInventory:36]tableName:30:=Table name:C256(->[InventoryStack:29])
			SAVE RECORD:C53([DInventory:36])
		End if 
	End for 
	READ ONLY:C145([POLine:40])
	UNLOAD RECORD:C212([InventoryStack:29])
	READ ONLY:C145([InventoryStack:29])
	//READ ONLY([POLine])
	READ ONLY:C145([DInventory:36])
	// TRACE
	If (Size of array:C274($aDoPos)>0)  //will currently always be false
		$k:=Size of array:C274($aDoPos)
		For ($i; 1; $k)
			QUERY:C277([PO:39]; [PO:39]idNum:5=$aDoPos{$i})
			LOAD RECORD:C52([PO:39])
			If (Not:C34(Locked:C147([PO:39])))
				PO_RecalcNotIn
			Else 
				ALERT:C41("PO "+String:C10([PO:39]idNum:5; "0000-0000")+" was locked and not recalulated.")
			End if 
		End for 
	End if 
End if 