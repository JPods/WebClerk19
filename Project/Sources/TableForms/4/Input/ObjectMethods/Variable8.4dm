C_TEXT:C284($strValue)
$strValue:=[Item:4]typeid:26
entryEntity.typeid:=DE_PopUpArray(Self:C308)
If ($strValue#[Item:4]typeid:26)
	READ ONLY:C145([GLAccount:53])
	QUERY:C277([GLAccount:53]; [GLAccount:53]fileRefNum:2=4; *)
	QUERY:C277([GLAccount:53];  & [GLAccount:53]typeid:3=[Item:4]typeid:26)
	C_LONGINT:C283($i; $k)
	$k:=Records in selection:C76([GLAccount:53])
	FIRST RECORD:C50([GLAccount:53])
	For ($i; 1; $k)
		Case of 
			: (([GLAccount:53]typeAcct:5="Inco@") | ([GLAccount:53]typeAcct:5="Rev@"))
				[Item:4]salesGlAccount:21:=[GLAccount:53]account:1
			: (([GLAccount:53]typeAcct:5="Cost@") | ([GLAccount:53]typeAcct:5="CoG@") | ([GLAccount:53]typeAcct:5="Exp@"))
				[Item:4]costGLAccount:22:=[GLAccount:53]account:1
			: (([GLAccount:53]typeAcct:5="Current ass@") | ([GLAccount:53]typeAcct:5="Ass@"))
				[Item:4]inventoryGlAccount:23:=[GLAccount:53]account:1
		End case 
		NEXT RECORD:C51([GLAccount:53])
	End for 
	READ WRITE:C146([GLAccount:53])
	REDUCE SELECTION:C351([GLAccount:53]; 0)
	READ ONLY:C145([DefaultAccount:32])
	GOTO RECORD:C242([DefaultAccount:32]; 0)
	If ([Item:4]salesGlAccount:21="")
		[Item:4]salesGlAccount:21:=[DefaultAccount:32]itemSalesAcct:24
	End if 
	If ([Item:4]costGLAccount:22="")
		[Item:4]costGLAccount:22:=[DefaultAccount:32]itemCostofGoods:25
	End if 
	If ([Item:4]inventoryGlAccount:23="")
		[Item:4]inventoryGlAccount:23:=[DefaultAccount:32]itemInventory:26
	End if 
	UNLOAD RECORD:C212([DefaultAccount:32])
	READ WRITE:C146([DefaultAccount:32])
	[Item:4]tallyByType:19:=True:C214
	If (([Item:4]profile1:35="") & (Is new record:C668([Customer:2])))
		[Item:4]profile1:35:=[Item:4]typeid:26
	End if 
	//TRACE
	// Item_SetPopups 
End if 