

C_OBJECT:C1216(iLoObject1)

If (iLoText1="")
	ALERT:C41("You need a script to execute.")
Else 
	ExecuteText(0; iLoText1)
End if 
