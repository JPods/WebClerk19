//%attributes = {}


// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/02/18, 00:29:45
// ----------------------------------------------------
// Method: ItemOpenNewProcess
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($1; $itemNum)
$itemNum:=$1
C_TEXT:C284($script)
If (Size of array:C274(aItemLines)>0)
	If (Size of array:C274(aLsItemNum)<=aItemLines{1})
		
		$script:="QUERY([Item];[Item]ItemNum=\""+$itemNum+"\")"
		// $script:="QUERY([Item];[Item]ItemNum=\""+aLsItemNum{aItemLines{1}}+"\")"
		
		$childProcess:=New process:C317("ProcessTableQuery"; <>tcPrsMemory; String:C10(Count user processes:C343)+"- Items"; Current process:C322; $script; ""; Table:C252(->[Item:4]))
		vLastProcessLaunched:=$childProcess
	End if 
End if 