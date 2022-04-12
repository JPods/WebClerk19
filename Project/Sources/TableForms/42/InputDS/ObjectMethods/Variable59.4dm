$doChange:=UserInPassWordGroup("ChangesalesNameID")
If (($doChange) | (Is new record:C668([Customer:2])))
	KeyModifierCurrent
	If (optKey=0)
		entryEntity.salesNameID:=DE_PopUpArray(Self:C308)
		//dummy array so that aPLineAction won't get messed up by CM_AllLineCalc
		ARRAY LONGINT:C221(aTempInt; Size of array:C274(aPLineAction))
		CM_ChangeWho(->[Proposal:42]salesNameID:9; -><>aComNameID; ->[Employee:19]; ->vComSales; -><>aEmpRate; <>tcSaleMar; ->aPExtPrice; ->aPExtCost; ->aPSalesRate; ->aPSaleComm; ->[Proposal:42]salesCommission:10; ->aPQtyOrder; ->aTempInt)
		ARRAY LONGINT:C221(aTempInt; 0)
		Copy_NewEntry(->[Customer:2]; ->[Proposal:42]salesNameID:9; ->[Customer:2]salesNameID:59)
	Else 
		jPopUpArray(Self:C308; ->vText1)
		C_LONGINT:C283($i; $k)
		CONFIRM:C162("Set Produced By in selected lines?")
		If (OK=1)
			$k:=Size of array:C274(aRayLines)
			For ($i; 1; $k)
				aPProdBy{aRayLines{$i}}:=vText1
			End for 
		End if 
	End if 
	// zzzqqq U_DTStampFldMod(->[Proposal:42]commentProcess:64; ->[Proposal:42]salesNameID:9)
End if 