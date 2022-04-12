CONFIRM:C162("Update Item Profiles?")
If (OK=1)
	READ WRITE:C146([InvoiceLine:54])
	$k:=Records in selection:C76([InvoiceLine:54])
	ORDER BY:C49([InvoiceLine:54]; [InvoiceLine:54]itemNum:4)
	FIRST RECORD:C50([InvoiceLine:54])
	READ ONLY:C145([Item:4])
	//ThermoInitExit ("Expanding Item Information";$k;False)
	$viProgressID:=Progress New
	For ($i; 1; $k)
		//Thermo_Update ($i)
		ProgressUpdate($viProgressID; $i; $k; "Expanding Item Information")
		If (<>ThermoAbort)
			$i:=$k
		End if 
		If ([Item:4]itemNum:1#[InvoiceLine:54]itemNum:4)
			QUERY:C277([Item:4]; [Item:4]itemNum:1=[InvoiceLine:54]itemNum:4)
		End if 
		[InvoiceLine:54]typeItem:24:=[Item:4]typeid:26
		[InvoiceLine:54]profile1:30:=[Item:4]profile1:35
		[InvoiceLine:54]profile2:31:=[Item:4]profile2:36
		[InvoiceLine:54]profile3:32:=[Item:4]profile3:37
		[InvoiceLine:54]profile4:33:=[Item:4]profile4:38
		[InvoiceLine:54]vendorID:38:=[Item:4]vendorID:45
		SAVE RECORD:C53([InvoiceLine:54])
		NEXT RECORD:C51([InvoiceLine:54])
	End for 
	//Thermo_Close
	Progress QUIT($viProgressID)
	UNLOAD RECORD:C212([Item:4])
	READ WRITE:C146([Item:4])
	READ ONLY:C145([InvoiceLine:54])
End if 