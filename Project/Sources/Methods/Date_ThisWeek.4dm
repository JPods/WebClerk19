//%attributes = {"publishedWeb":true}
// Procedure: Date_EndThisWee
C_LONGINT:C283($dayNum; $2; $3; $beginWk; $endWk)
C_DATE:C307($0; $1)
Case of 
	: (Count parameters:C259=0)
		$theDate:=Current date:C33
		$doEOM:=True:C214
	: (Count parameters:C259=1)
		$theDate:=$1
		$doEOM:=True:C214
	Else 
		$theDate:=$1
		$doEOM:=($2=0)
End case 
//If (Count parameters=2)
$beginWk:=1
$endWk:=7
//Else 
//$endWk=$3
//End if 
If ($doEOM)
	$dayNum:=Day number:C114($theDate)
	$0:=$theDate+$endWk-$dayNum
Else 
	$dayNum:=Day number:C114($theDate)
	$0:=$theDate+$endWk-$dayNum
End if 