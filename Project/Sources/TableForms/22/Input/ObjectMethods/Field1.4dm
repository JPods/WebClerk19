QUERY:C277([Item:4]; [Item:4]itemNum:1=[ItemXRef:22]ItemNumMaster:1)
If (Records in selection:C76([Item:4])=1)
	[ItemXRef:22]ItemNumMaster:1:=[Item:4]itemNum:1
	If ([ItemXRef:22]DescriptionMaster:8="")
		[ItemXRef:22]DescriptionMaster:8:=[Item:4]description:7
	End if 
Else 
	If (Records in selection:C76([Item:4])=0)
		ALERT:C41("There are no current items by that name.")
	Else 
		ALERT:C41("There are multiple records beginning with this code.")
	End if 
End if 