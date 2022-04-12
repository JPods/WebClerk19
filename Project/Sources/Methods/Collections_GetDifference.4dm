//%attributes = {}

// ----------------------------------------------------
// Method: getCollectionDifference
// Description: Compares the elements of collection B against collection A and returns collection (B - A).
// Parameters: $1 - Collection A
// $2 - Collection B
// NOTE: Text comparison is NOT case-sensitive.
// ----------------------------------------------------
#DECLARE($col_target : Collection; $col_source : Collection)->$col_result : Collection

C_VARIANT:C1683($value)
If (Count parameters:C259>=2)
	$col_diff:=New collection:C1472
	
	For each ($value; $col_source)
		
		If ($col_target.indexOf($value)=-1)
			$col_diff.push($value)
		End if 
		
	End for each 
	
	$col_result:=$col_diff
End if 