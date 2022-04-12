//%attributes = {"publishedWeb":true}
KeyModifierCurrent
Case of 
	: (CmdKey=1)
		jDateTimeUserCl("Enter Date/Time Range")
		If (OK=1)
			QUERY:C277([Service:6]; [Service:6]complete:17=False:C215; *)
			QUERY:C277([Service:6];  & [Service:6]dtAction:35>=vlDTStart; *)
			QUERY:C277([Service:6];  & [Service:6]dtAction:35<=vlDTEnd)
		End if 
	: (OptKey=1)
		jDateTimeUserCl("Enter Date/Time Range")
		If (OK=1)
			QUERY:C277([Service:6]; [Service:6]dtAction:35>=vlDTStart; *)
			QUERY:C277([Service:6];  & [Service:6]dtAction:35<=vlDTEnd)
		End if 
	Else 
		QUERY:C277([Service:6]; [Service:6]complete:17=False:C215)
		OK:=1
End case 
If (OK=1)
	If (Records in selection:C76([Service:6])>0)
		ORDER BY:C49([Service:6]; [Service:6]dtAction:35; <)
		booSorted:=True:C214
	End if 
	ProcessTableOpen(->[Service:6])
End if 