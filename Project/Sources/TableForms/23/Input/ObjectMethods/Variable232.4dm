If (([PopUp:23]arrayName:3="<>aItemsType") | ([PopUp:23]arrayName:3="<>aItemsProfile1"))
	If (Size of array:C274(aPopSelect)>0)
		//TRACE
		GUI_TextEditDia(->aText2{aPopSelect{1}}; "Popup Alternatives")
	Else 
		
	End if 
Else 
	ALERT:C41("This feature only applies for Item Profiles.")
End if 