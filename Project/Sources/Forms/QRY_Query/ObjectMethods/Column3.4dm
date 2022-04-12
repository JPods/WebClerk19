$evt:=Form event code:C388

Case of 
	: ($evt=On Clicked:K2:4)
		If (Form:C1466.criteria_Cur#Null:C1517)
			If (Form:C1466.criteria_Cur.valueType="color")
				FILTER EVENT:C321
			End if 
		End if 
End case 