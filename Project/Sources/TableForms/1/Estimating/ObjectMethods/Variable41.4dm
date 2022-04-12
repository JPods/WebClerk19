If (False:C215)
	If (iLoaText1{iLoaText1}#"QuantityEstimate")
		ProcessPostRay
	Else 
		$found:=Prs_CheckRunnin("QuantityEstimate")
		If ($found>0)
			If (Frontmost process:C327#<>aPrsNum{$found})
				BRING TO FRONT:C326(<>aPrsNum{$found})
			End if 
		Else 
			<>ptCurTable:=ptCurTable
			<>prcControl:=1
			<>processAlt:=New process:C317("Estimate_Quantity"; <>tcPrsMemory; "QuantityEstimate")
		End if 
		iLoaText1:=1
	End if 
End if 