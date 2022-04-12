If (Self:C308->>0)
	
	CONFIRM:C162("PriceMatrix cost the selected lines?")
	If (OK=1)
		C_LONGINT:C283($incRay; $cntRay)
		$cntRay:=Size of array:C274(aPPLnSelect)
		
		For ($incRay; 1; $cntRay)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=aPItemNum{aPPLnSelect{$incRay}})
			//build BOM
			vrBOMQty:=aPQtyOrder{aPPLnSelect{$incRay}}
			vrBOMFactor:=3
			BOM_BuildMom
			QUERY:C277([BOM:21]; [BOM:21]itemNum:1=[Item:4]itemNum:1)
			Bom_FillArray(Records in selection:C76([BOM:21]))
			If (Records in selection:C76([BOM:21])>0)
				[Item:4]bomHasChild:48:=True:C214
			End if 
			BOM_BuildExtend([Item:4]itemNum:1)
			//
			//Cost BOM
			Bom_CostItems
			C_REAL:C285($totalCost)
			BOM_ExtendCost(0)
			OBJECT SET FORMAT:C236(vrBOMCostLast; <>tcFormatUC)
			OBJECT SET FORMAT:C236(vrBOMCostStandard; <>tcFormatUC)
			//
			If (vrTooling>0)
				vrBOMCostQty:=vrBOMCostQty+Round:C94(vrTooling/vrBOMQty; 2)
			End if 
			aPDiscnt{aPPLnSelect{$incRay}}:=0
			aPUnitCost{aPPLnSelect{$incRay}}:=vrBOMCostQty
			aPUnitPrice{aPPLnSelect{$incRay}}:=vrBOMPriceQty
			aPDscntUP{aPPLnSelect{$incRay}}:=vrBOMPriceQty
			aPLnComment{aPPLnSelect{$incRay}}:="Used_"+aPriceForecastOptions{aPriceForecastOptions}+"; Tooling"+String:C10(Round:C94(vrTooling; 2))
			aPLineAction:=aPPLnSelect{$incRay}
			PpLnExtend(aPLineAction)
		End for 
		
		//  --  CHOPPED  AL_UpdateArrays(eItemPp; -2)
	End if 
	
	Self:C308->:=1
End if 