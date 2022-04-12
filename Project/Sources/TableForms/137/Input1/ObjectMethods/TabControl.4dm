

Case of 
	: ((Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Load:K2:1) | (Form event code:C388=On Data Change:K2:15))
		Case of 
				
				
			: (TabControl=1)
				ddEmail:=1
				FORM GOTO PAGE:C247(TabControl)
				WATextIntoArea(->myWebArea; [QQQMessage:137]Body:12; "view")
				
			: (TabControl=2)
			: (TabControl=3)
			: (TabControl=4)
			: (TabControl=5)
			: (TabControl=6)
				
		End case 
End case 
