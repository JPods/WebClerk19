//%attributes = {}

// Modified by: Bill James (2022-04-28T05:00:00Z)
// Method: QRY_ReturnObject
// Description 
// Parameters
// ----------------------------------------------------
var $0 : Object
// Only can be run in QRY_Query at this time
// Modified by: Bill James (2022-04-28T05:00:00Z)

If (Form:C1466.criteria.length>0)
	
	$inSelection:=Form:C1466.ck_CurrentSel
	
	$queryString:=""
	
	$queryParams:=New object:C1471
	//$queryParams.queryPlan:=False
	//$queryParams.queryPath:=False
	$queryParams.queryPlan:=True:C214
	$queryParams.queryPath:=True:C214
	$queryParams.parameters:=New collection:C1472
	
	$index:=0
	$parmIndex:=0
	For each ($criteria; Form:C1466.criteria)
		$index:=$index+1
		If ($index=1)  //First line
			
		Else 
			$queryString:=$queryString+" "+$criteria.logicOperatorChoice+" "
		End if 
		$condition:=$criteria.condition
		$fl_AtBefore:="@"*Num:C11(Position:C15("["; $condition)>0)
		$fl_AtAfter:="@"*Num:C11(Position:C15("]"; $condition)>0)
		$linePrefix:=""
		$lineSuffix:=""
		$condition:=Replace string:C233($condition; "["; "")
		$condition:=Substring:C12(Replace string:C233($condition; "]"; ""); 2)
		$fl_HasParm:=False:C215
		Case of   // Analyse of special cases (See Util25_Query_PrepareMenus method)
			: ($criteria.originalType="image")  //it's a picture
				$fl_HasParm:=True:C214
				$criteria.path:="eval("
				
				
			: (Position:C15("0"; $condition)>0)  //Text is empty or not
				$condition:=Replace string:C233($condition; "0"; " ''")
				
			: (Position:C15("?"; $condition)>0)  // is defined or not
				$condition:=Replace string:C233($condition; "?"; " null")
				
			: (Position:C15("W"; $condition)>0)  // contains keywords
				If ($condition="#W")  //  Doesn't contain KW -> Not(contains KW)
					$linePrefix:="not("
					$lineSuffix:=")"
				End if 
				$condition:=Replace string:C233($condition; "W"; " % ")
				$fl_HasParm:=True:C214
				
			: ($condition="=D@")  //Today
				$condition:="="
				$criteria.value:=Current date:C33
				$fl_HasParm:=True:C214
				Case of 
					: ($condition="=D+")  //Tomorrow
						$criteria.value:=Current date:C33+1
					: ($condition="=D-")  //Yesterday
						$criteria.value:=Current date:C33-1
				End case 
				
			: ($criteria.condition="B=")  //Booleans
				$condition:=" is true"
			: ($criteria.condition="B#")
				$condition:=" is false"
				
			: ($criteria.condition="P=")  //Properties
				If (($criteria.valueType="object") & ($criteria.path#"@[]"))
					$criteria.path:=$criteria.path+"[]"
				End if 
				$condition:=" is not null"
			: ($criteria.condition="P#")
				If (($criteria.valueType="object") & ($criteria.propertyName#"@[]"))
					$criteria.path:=$criteria.path+"[]"
				End if 
				$condition:=" is null"
				
			: ($criteria.condition="T@")
				$criteria.value:=$fl_AtBefore+$criteria.value+$fl_AtAfter
				$fl_HasParm:=True:C214
				
			Else 
				$fl_HasParm:=True:C214
		End case 
		
		$queryString:=$queryString+$linePrefix+$criteria.path+" "+$condition+" "
		If ($fl_HasParm)
			$parmIndex:=$parmIndex+1
			$queryString:=$queryString+":"+String:C10($parmIndex)
			$queryParams.parameters.push($criteria.value)
		End if 
		
		$queryString:=$queryString+$lineSuffix
		
	End for each 
	
	If ($queryParams.queryPlan)
		$qryPlan:=Get last query plan:C1046(Description in text format:K19:5)
	End if 
	If ($queryParams.queryPath)
		$qryPath:=Get last query path:C1045(Description in text format:K19:5)
	End if 
	
	qryCount_i:=Form:C1466.ents.length
	qryDraft_o:=New object:C1471(\
		"queryInSelection"; $inSelection; \
		"queryString"; $queryString; \
		"queryParams"; $queryParams; \
		"queryPlan"; $queryPlan; \
		"queryPath"; $queryPath)
	
	var $t : Text
	$t:=JSON Stringify:C1217(qryDraft_o)
	
	$0:=qryDraft_o
End if 