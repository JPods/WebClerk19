//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 02/27/21, 20:57:35
// ----------------------------------------------------
// Method: IndexOf_employee
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($obEmployee)
C_LONGINT:C283($cntOb; $viEmployee; $0)
C_COLLECTION:C1488($1; $cOutput)
C_TEXT:C284($2; $vtName)
$cOutput:=$1
$vtName:=$2
//$1.result:=$1.value.name=$2
$cntOb:=-1
$viEmployee:=-1
For each ($obEmployee; $cOutput) While ($viEmployee=-1)
	$cntOb:=$cntOb+1
	If ($obEmployee.employee=$vtName)
		$viEmployee:=$cntOb
	End if 
End for each 
$0:=$viEmployee