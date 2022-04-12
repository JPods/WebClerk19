Case of 
	: (aLoText2=0)
		If ([UserReport:46]PrinterProgress:35>0)
			aLoText2:=1
		Else 
			aLoText2:=0
		End if 
	: (aLoText2=1)
		[UserReport:46]PrinterProgress:35:=1
	Else 
		[UserReport:46]PrinterProgress:35:=0
End case 