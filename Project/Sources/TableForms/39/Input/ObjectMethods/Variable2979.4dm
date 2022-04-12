CONFIRM:C162("Change LnItem Info to match Inships???")
If (OK=1)
	CONFIRM:C162("You are sure you want to update POlines to Inships?!?")
	If (OK=1)
		C_LONGINT:C283($i; $k; $cntStk; $incStk)
		C_REAL:C285($unitCost; $disCost; $disc; $nonProd; $duty; $qtyStk; $totalCost)
		$k:=Size of array:C274(aPOLineNum)
		For ($i; 1; $k)
			QUERY:C277([InventoryStack:29]; [InventoryStack:29]DocID:5=[PO:39]poNum:5; *)
			QUERY:C277([InventoryStack:29];  & [InventoryStack:29]LineNum:12=aPOLineNum{$i})
			$cntStk:=Records in selection:C76([InventoryStack:29])
			FIRST RECORD:C50([InventoryStack:29])
			Case of 
				: ($cntStk=0)  //drop out      
				: ($cntStk=1)
					aPoNPCosts{$i}:=[InventoryStack:29]NonProcCosts:22
					aPoDuties{$i}:=[InventoryStack:29]Duties:21
					aPoDscntUP{$i}:=[InventoryStack:29]UnitCost:11
					If (aPODiscnt{$i}=0)
						aPOUnitCost{$i}:=[InventoryStack:29]UnitCost:11
					Else 
						If (aPOUnitCost{$i}#0)
							aPODiscnt{$i}:=(aPOUnitCost{$i}-aPoDscntUP{$i})/aPOUnitCost{$i}*100
						Else 
							aPOUnitCost{$i}:=aPoDscntUP{$i}
							aPODiscnt{$i}:=0
						End if 
					End if 
				Else 
					$nonProd:=0
					$duty:=0
					$qtyStk:=0
					$totalCost:=0
					For ($incStk; 1; $cntStk)
						$nonProd:=$nonProd+[InventoryStack:29]NonProcCosts:22
						$duty:=$duty+[InventoryStack:29]Duties:21
						$qtyStk:=$qtyStk+[InventoryStack:29]QtyOnHand:9
						$totalCost:=$totalCost+[InventoryStack:29]ExtendedCost:17
						NEXT RECORD:C51([InventoryStack:29])
					End for 
					aPoNPCosts{$i}:=$nonProd
					aPoDuties{$i}:=$duty
					If ((Abs:C99((aPoDscntUP{$i}*$qtyStk)-$totalCost)>1) & ($qtyStk#0))
						aPoDscntUP{$i}:=Round:C94($totalCost/$qtyStk; <>tcDecimalUC)
						If (aPOUnitCost{$i}#0)
							aPODiscnt{$i}:=(aPOUnitCost{$i}-aPoDscntUP{$i})/aPOUnitCost{$i}*100
						Else 
							aPOUnitCost{$i}:=aPoDscntUP{$i}
							aPODiscnt{$i}:=0
						End if 
					End if 
			End case 
		End for 
	End if 
End if 