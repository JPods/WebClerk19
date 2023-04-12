$evt:=Form event code:C388
Case of 
	: ($evt=On Clicked:K2:4)
		//RESOURCES/Images/Buttons/LightGreySmall/Validate.png
		
		//If (Form.criteria.length>0)
		
		//$inSelection:=Form.ck_CurrentSel
		
		//$queryString:=""
		
		//$queryParams:=New object
		////$queryParams.queryPlan:=False
		////$queryParams.queryPath:=False
		//$queryParams.queryPlan:=True
		//$queryParams.queryPath:=True
		//$queryParams.parameters:=New collection
		
		//$index:=0
		//$parmIndex:=0
		//For each ($criteria; Form.criteria)
		//$index:=$index+1
		//If ($index=1)  //First line
		
		//Else 
		//$queryString:=$queryString+" "+$criteria.logicOperatorChoice+" "
		//End if 
		//$condition:=$criteria.condition
		//$fl_AtBefore:="@"*Num(Position("["; $condition)>0)
		//$fl_AtAfter:="@"*Num(Position("]"; $condition)>0)
		//$linePrefix:=""
		//$lineSuffix:=""
		//$condition:=Replace string($condition; "["; "")
		//$condition:=Substring(Replace string($condition; "]"; ""); 2)
		//$fl_HasParm:=False
		//Case of   // Analyse of special cases (See Util25_Query_PrepareMenus method)
		//: ($criteria.originalType="image")  //it's a picture
		//$fl_HasParm:=True
		//$criteria.path:="eval("
		
		
		//: (Position("0"; $condition)>0)  //Text is empty or not
		//$condition:=Replace string($condition; "0"; " ''")
		
		//: (Position("?"; $condition)>0)  // is defined or not
		//$condition:=Replace string($condition; "?"; " null")
		
		//: (Position("W"; $condition)>0)  // contains keywords
		//If ($condition="#W")  //  Doesn't contain KW -> Not(contains KW)
		//$linePrefix:="not("
		//$lineSuffix:=")"
		//End if 
		//$condition:=Replace string($condition; "W"; " % ")
		//$fl_HasParm:=True
		
		//: ($condition="=D@")  //Today
		//$condition:="="
		//$criteria.value:=Current date
		//$fl_HasParm:=True
		//Case of 
		//: ($condition="=D+")  //Tomorrow
		//$criteria.value:=Current date+1
		//: ($condition="=D-")  //Yesterday
		//$criteria.value:=Current date-1
		//End case 
		
		//: ($criteria.condition="B=")  //Booleans
		//$condition:=" is true"
		//: ($criteria.condition="B#")
		//$condition:=" is false"
		
		//: ($criteria.condition="P=")  //Properties
		//If (($criteria.valueType="object") & ($criteria.path#"@[]"))
		//$criteria.path:=$criteria.path+"[]"
		//End if 
		//$condition:=" is not null"
		//: ($criteria.condition="P#")
		//If (($criteria.valueType="object") & ($criteria.propertyName#"@[]"))
		//$criteria.path:=$criteria.path+"[]"
		//End if 
		//$condition:=" is null"
		
		//: ($criteria.condition="T@")
		//$criteria.value:=$fl_AtBefore+$criteria.value+$fl_AtAfter
		//$fl_HasParm:=True
		
		//Else 
		//$fl_HasParm:=True
		//End case 
		
		//$queryString:=$queryString+$linePrefix+$criteria.path+" "+$condition+" "
		//If ($fl_HasParm)
		//$parmIndex:=$parmIndex+1
		//$queryString:=$queryString+":"+String($parmIndex)
		//$queryParams.parameters.push($criteria.value)
		//End if 
		
		//$queryString:=$queryString+$lineSuffix
		
		//End for each 
		
		//If ($queryParams.queryPlan)
		//$qryPlan:=Get last query plan(Description in text format)
		//End if 
		//If ($queryParams.queryPath)
		//$qryPath:=Get last query path(Description in text format)
		//End if 
		
		//qryCount_i:=Form.ents.length
		//qryDraft_o:=New object(\
									"queryInSelection"; $inSelection; \
									"queryString"; $queryString; \
									"queryParams"; $queryParams; \
									"queryPlan"; $queryPlan; \
									"queryPath"; $queryPath)
		
		//var $t : Text
		//$t:=JSON Stringify(qryDraft_o)
		
		
		
		qryDraft_o:=QRY_ReturnObject
		$inSelection:=qryDraft_o.inSelection
		$queryString:=qryDraft_o.queryString
		$queryParams:=qryDraft_o.queryParams
		
		If ($inSelection)
			Form:C1466.ents:=Form:C1466.displayedSelection.query($queryString; $queryParams)
		Else 
			Form:C1466.ents:=Form:C1466.dataClass.query($queryString; $queryParams)
		End if 
		choices_o.query.last:=qryDraft_o
		
End case 