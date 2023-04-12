C_LONGINT:C283($formEvent; $curRecNum)
$formEvent:=Form event code:C388
Case of 
	: ($formEvent=On Load:K2:1)
		srItem:=""
	: ($formEvent=On After Keystroke:K2:26)
		vText:=""
		vtChar:=""
		vText:=Keystroke:C390
		vtChar:=String:C10(Character code:C91(Keystroke:C390))
		If (vText#"")
			ConsoleLog(vtChar+"\t"+vText)
		End if 
End case 