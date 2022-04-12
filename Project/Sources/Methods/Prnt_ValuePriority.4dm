//%attributes = {"publishedWeb":true}
//Method: Prnt_ValuePriority
C_TEXT:C284($0; $1; $2; $3; $4)
C_TEXT:C284($docValue; $contactValue; $custValue)
If (Count parameters:C259>0)
	$docValue:=$1
	If (Count parameters:C259>1)
		$contactValue:=$2
		If (Count parameters:C259>2)
			$custValue:=$3
		End if 
	End if 
	Case of 
		: ($docValue#"")
			$0:=$docValue
		: ($contactValue#"")
			$0:=$contactValue
		: ($custValue#"")
			$0:=$custValue
		Else 
			$0:=""
	End case 
Else 
	$0:=""
End if 