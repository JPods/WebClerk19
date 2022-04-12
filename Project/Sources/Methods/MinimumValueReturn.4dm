//%attributes = {}
// ----------------------------------------------------
// User name (OS): williamjames
// Date and time: 10/16/08, 00:00:48
// ----------------------------------------------------
// Method: MinimumValueReturn
// Description
// 
//
C_REAL:C285($1; $2; $4; $maxValueRejected; $0)
C_LONGINT:C283($3)
// ----------------------------------------------------
C_REAL:C285($4; $minLimit)
$doMin:=0
$minLimit:=-3000000000
If (Count parameters:C259>2)
	$doMin:=$3
	If (Count parameters:C259>3)
		$maxValueRejected:=$4
	End if 
End if 
If ($doMin=1)
	Case of 
		: (($1>$maxValueRejected) & ($2>$maxValueRejected))
			If ($1<=$2)
				$0:=$1
			Else 
				$0:=$2
			End if 
		: ($1<=$maxValueRejected)  //$1 is less than the maxReject
			If ($2<$maxValueRejected)  //test if $2 is less
				$0:=$maxValueRejected  //return the maxMinimumValue
			Else 
				$0:=$2
			End if 
		Else   //$2 is less than the maxReject
			$0:=$1
	End case 
Else 
	If ($1<=$2)
		$0:=$1
	Else 
		$0:=$2
	End if 
End if 
