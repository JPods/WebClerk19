//%attributes = {"publishedWeb":true}
//Method: MaxValueReturn
C_LONGINT:C283($1; $2; $0; $3; $doMin)
C_REAL:C285($4; $minLimit)
$doMin:=0
$minLimit:=-3000000000
If (Count parameters:C259>2)
	$doMin:=$3
	If (Count parameters:C259>3)
		$minLimit:=$4
	End if 
End if 
Case of 
	: (($1<1) & ($2<1) & ($doMin>0))
		$0:=$doMin
		//: ($1=$2)
		//$0:=$1
	: ($1<$2)
		$0:=$2
	Else 
		$0:=$1
End case 
