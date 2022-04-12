//bBOM with related file
C_REAL:C285($Cnt; $Dscnt)  //Qty
C_DATE:C307($Date)
C_REAL:C285($discCost)
C_LONGINT:C283($soa)
If ((aPOLineAction>0) & (aPOItemNum{aPOLineAction}#""))
	CONFIRM:C162("Do you wish to expand all Level 1 Bill of Materials.")
	If (OK=1)
		QUERY:C277([BOM:21]; [BOM:21]ItemNum:1=aPOItemNum{aPOLineAction})
		$k:=Records in selection:C76([BOM:21])
		If ($k>0)
			$Cnt:=aPOQtyBL{aPOLineAction}
			$Dscnt:=aPODiscnt{aPOLineAction}
			aPOQtyOrder{aPOLineAction}:=aPOQtyRcvd{aPOLineAction}
			aPOQtyBL{aPOLineAction}:=0
			PoLnExtend(aPOLineAction)
			vLineMod:=True:C214  //during phase line update
			C_LONGINT:C283($ParentIndex)
			$ParentIndex:=aPOLineAction
			FIRST RECORD:C50([BOM:21])
			$soa:=Size of array:C274(aPOLineAction)
			READ ONLY:C145([Item:4])
			TRACE:C157
			For ($i; 1; $k)
				QUERY:C277([Item:4]; [Item:4]itemNum:1=[BOM:21]ChildItem:2)
				$soa:=$soa+1
				pDescript:=[Item:4]description:7
				pUnitCost:=[Item:4]costAverage:13
				viPOLnCnt:=viPOLnCnt+1
				POLnAdd($soa; 1; False:C215)
				//
				aPOQtyOrder{$soa}:=$Cnt*[BOM:21]QtyInAssembly:3
				aPOQtyRcvd{$soa}:=0
				aPODiscnt{$soa}:=$Dscnt
				//should be value from [Item]
				//aPOTaxable{$soa}:=aPOTaxable{$ParentIndex}//="")&(aPOTaxable{$soa}=""))
				aPODateExp{$soa}:=aPODateExp{$ParentIndex}
				aPOOrdRef{$soa}:=aPOOrdRef{$ParentIndex}
				PoLnExtend($soa)
				NEXT RECORD:C51([BOM:21])
			End for 
			UNLOAD RECORD:C212([Item:4])
			READ WRITE:C146([Item:4])
			List_FillOpts(0)
			doSearch:=1000
			bMultiSr:=0
		End if 
	End if 
End if 
