jPopUpArray(Self:C308; ->ptaxID)
If (ptaxID="ItemRecord")
	QUERY:C277([Item:4]; [Item:4]itemNum:1=pPartNum)
	If ([Item:4]taxid:17#"")
		ptaxID:=[Item:4]taxid:17
	Else 
		ptaxID:="Tax"
	End if 
	REDUCE SELECTION:C351([Item:4]; 0)
End if 
