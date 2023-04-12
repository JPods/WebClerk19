//%attributes = {}

// Modified by: Bill James (2022-06-27T05:00:00Z)
// Method: LBX_SelectionIfEmpty
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($lbName : Text; $dataClassName : Text)
var $ptLB : Pointer
var $doSelection : Boolean
$ptLB:=Get pointer:C304($lbName)
$doSelection:=False:C215
If ($ptLB->=Null:C1517)
	$doSelection:=True:C214
Else 
	If ($ptLB->ents.length=Null:C1517)
		$doSelection:=True:C214
	Else 
		If ($ptLB->ents.length=0)
			$doSelection:=True:C214
		End if 
	End if 
End if 
If ($doSelection)
	$ptLB->:=cs:C1710.listboxK.new($lbName; $dataClassName)
	$ptLB->setSource(ds:C1482[$dataClassName].all())
End if 
