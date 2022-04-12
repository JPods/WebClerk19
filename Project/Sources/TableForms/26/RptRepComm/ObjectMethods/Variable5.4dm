//vRepCo
If (In header:C112)
	If (vi1=0)
		QUERY:C277([Rep:8]; [Rep:8]repID:1=[Invoice:26]repID:22)
		vRepCo:=[Rep:8]company:2
		vRepAccCode:=[Rep:8]repID:1
	Else 
		vRepCo:=[Invoice:26]salesNameID:23
		vRepAccCode:=""
	End if 
End if 