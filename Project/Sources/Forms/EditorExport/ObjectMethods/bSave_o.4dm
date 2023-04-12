Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Clicked:K2:4)
		If (Form:C1466.LB_SavedAction.cur#Null:C1517)
			Form:C1466.LB_SavedAction.cur.obGeneral.entsSaved:=Form:C1466.LB_Use.ents
			Form:C1466.LB_SavedAction.cur.save()
		End if 
End case 