If (False:C215)
	//01/21/03.prf
	//New object method
	VERSION_9919
	VERSION_9919_ISC
End if 
KeyModifierCurrent
If ((cmdKey=1) & (OptKey=1))
	iSabrd
Else 
	Web_LaunchURL_Email(process_o.entry_o.email)
End if 
