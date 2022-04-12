$unitMeasBy:=1
If (v2#"")  // Modified by: williamjames (111216 checked for ≤ length protection)
	If (v2[[1]]="*")
		//Jan 11, 1997
		C_REAL:C285($unitMeasBy)
		$unitMeasBy:=Item_PricePer(->v2)
	End if 
End if 
[BOM:21]PlanExtCost:9:=[BOM:21]PlanCost:8*[BOM:21]QtyInAssembly:3/$unitMeasBy