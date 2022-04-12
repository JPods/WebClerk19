//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 10/13/20, 23:28:42
// ----------------------------------------------------
// Method: CatCostDifference
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_REAL:C285($1; $vrOld; $2; $vrNew)
C_POINTER:C301($3; $ptChange; $4; $ptPerCent)
$vrOld:=$1
$vrNew:=$2
$ptChange:=$3
$ptPerCent:=$4

$ptChange->:=Round:C94($vrOld-$vrNew; 2)
If ($vrOld=0)
	$ptPerCent->:=100
Else 
	$ptPerCent->:=Round:C94($ptChange->/$vrOld*100; 1)
End if 