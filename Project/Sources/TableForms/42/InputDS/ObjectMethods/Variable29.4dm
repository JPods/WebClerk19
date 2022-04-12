C_LONGINT:C283(bShowItem)
C_TEXT:C284($script)
If (Size of array:C274(aItemLines)>0)
	If (Size of array:C274(aLsItemNum)<=aItemLines{1})
		$script:="QUERY([Item];[Item]ItemNum=\""+aLsItemNum{aItemLines{1}}+"\")"
		//ProcessTableOpen (Table(->[Item]);$script;"";->[Item])
		$childProcess:=New process:C317("ProcessTableQuery"; <>tcPrsMemory; String:C10(Count user processes:C343)+"- Items"; Current process:C322; $script; ""; Table:C252(->[Item:4]))
		vLastProcessLaunched:=$childProcess
	End if 
End if 