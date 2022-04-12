myOK:=0
// LOCK DOWN THE QUERY CODE WINDOW TO ADMINS, BECAUSE THIS WINDOW ALLOWS EXECUTION OF ANY CODE ENTERED.
Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (UserInPassWordGroup("UnlockRecord"))
			OBJECT SET ENTERABLE:C238(*; "Variable24"; True:C214)
		Else 
			OBJECT SET ENTERABLE:C238(*; "Variable24"; False:C215)
		End if 
End case 