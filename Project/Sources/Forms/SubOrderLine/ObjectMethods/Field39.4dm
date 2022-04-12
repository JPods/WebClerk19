C_TEXT:C284($tempStr)
// zzzqqq PopUpWildCard(->[Order:3]status:59; -><>aStatus; ->[PopUp:23])
If (([Order:3]idNum:2#0) & ([Order:3]status:59#Old:C35([Order:3]status:59)))
	If (([Order:3]status:59="Completed") | ([Order:3]status:59="Canceled"))
		[Order:3]dtProdCompl:57:=DateTime_Enter
		complTime:=Current time:C178
		complDate:=Current date:C33
	Else 
		[Order:3]dtProdCompl:57:=0
		complTime:=?00:00:00?
		complDate:=!00-00-00!
	End if 
End if 
// zzzqqq U_DTStampFldMod(->[Order:3]commentProcess:12; Self:C308)