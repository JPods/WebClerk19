If (Record number:C243([Item:4])#-3)
	CONFIRM:C162("Update related record Descriptions?")
	If (OK=1)
		C_LONGINT:C283($i; $k)
		QUERY:C277([BOM:21]; [BOM:21]ChildItem:2=[Item:4]itemNum:1)
		$k:=Records in selection:C76([BOM:21])
		ARRAY TEXT:C222(a80Str1; $k)
		For ($i; 1; $k)
			a80Str1{$i}:=[Item:4]description:7
		End for 
		ARRAY TO SELECTION:C261(a80Str1; [BOM:21]Description:6)
		UNLOAD RECORD:C212([BOM:21])
		//
		If (Not:C34([Item:4]tallyByType:19))
			QUERY:C277([Usage:5]; [Usage:5]ItemNum:1=[Item:4]itemNum:1)
			$k:=Records in selection:C76([Usage:5])
			ARRAY TEXT:C222(a80Str1; $k)
			For ($i; 1; $k)
				a80Str1{$i}:=[Item:4]description:7
			End for 
			ARRAY TO SELECTION:C261(a80Str1; [Usage:5]Description:11)
		End if 
		UNLOAD RECORD:C212([Usage:5])
		//
		QUERY:C277([ItemXRef:22]; [ItemXRef:22]ItemNumMaster:1=[Item:4]itemNum:1)
		$k:=Records in selection:C76([ItemXRef:22])
		ARRAY TEXT:C222(a80Str1; $k)
		For ($i; 1; $k)
			a80Str1{$i}:=[Item:4]description:7
		End for 
		ARRAY TO SELECTION:C261(a80Str1; [ItemXRef:22]DescriptionMaster:8)
		UNLOAD RECORD:C212([ItemXRef:22])
		//
		READ WRITE:C146([ItemDiscount:45])
		QUERY:C277([ItemDiscount:45]; [ItemDiscount:45]ItemNum:2=[Item:4]itemNum:1)
		$k:=Records in selection:C76([ItemDiscount:45])
		ARRAY TEXT:C222(a80Str1; $k)
		For ($i; 1; $k)
			a80Str1{$i}:=[Item:4]description:7
		End for 
		ARRAY TO SELECTION:C261(a80Str1; [ItemDiscount:45]Description:8)
		UNLOAD RECORD:C212([ItemDiscount:45])
		READ ONLY:C145([ItemDiscount:45])
		//
		QUERY:C277([ItemSerial:47]; [ItemSerial:47]ItemNum:1=[Item:4]itemNum:1)
		$k:=Records in selection:C76([ItemSerial:47])
		ARRAY TEXT:C222(a80Str1; $k)
		For ($i; 1; $k)
			a80Str1{$i}:=[Item:4]description:7
		End for 
		ARRAY TO SELECTION:C261(a80Str1; [ItemSerial:47]Description:2)
		UNLOAD RECORD:C212([ItemSerial:47])
	End if 
End if 