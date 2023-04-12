If (FORM Event:C1606#Null:C1517)
	Form:C1466.SF_Selection.lastEvent:=FORM Event:C1606
End if 

Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		Case of 
			: (Macintosh command down:C546)
				Form:C1466.obHarvest:=LBX_HarvestTesting("LB_Selection")
				
			: (Macintosh option down:C545)
				
				
		End case 
End case 