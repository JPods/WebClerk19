//%attributes = {}

// Modified by: Bill James (2022-06-02T05:00:00Z)
// Method: Query_XRefFromLines
// Description 
// Parameters
// ----------------------------------------------------
If (dragFrom="LB_Lines")
	If (LB_Lines.sel#Null:C1517)
		var $inc : Integer
		var $queryPlan : Object
		var $parameters_t : Text
		$queryPlan:=New object:C1471("queryInSelection"; False:C215; "queryString"; ""; \
			"queryParams"; New object:C1471("queryPlan"; True:C214; "queryPath"; True:C214; \
			"parameters"; New collection:C1472))
		$inc:=0
		For each ($o; LB_Lines.sel)
			$inc:=$inc+1
			$queryPlan.queryString:=$queryPlan.queryString+(Num:C11($inc>1)*(" or "))+"itemNum = :"+String:C10($inc)
			$parameters_t:=$parameters_t+(Num:C11($inc>1)*(";"))+$o.itemNum
			$queryPlan.queryParams.parameters.push($o.itemNum)
		End for each 
	End if 
	LB_ItemXRef.ents:=ds:C1482.ItemXRef.query($queryPlan.queryString; $queryPlan.queryParams)
End if 

