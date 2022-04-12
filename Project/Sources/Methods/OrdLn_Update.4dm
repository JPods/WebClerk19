//%attributes = {"publishedWeb":true}
//Procedure: OrdLn_Update
READ WRITE:C146([OrderLine:49])
$k:=Records in selection:C76([OrderLine:49])
ORDER BY:C49([OrderLine:49]; [OrderLine:49]itemNum:4)
FIRST RECORD:C50([OrderLine:49])
READ ONLY:C145([Item:4])
//ThermoInitExit ("Expanding Item Information";$k;True)
$viProgressID:=Progress New

For ($i; 1; $k)
	//Thermo_Update ($i)
	ProgressUpdate($viProgressID; $i; $k; "Expanding Item Information")
	If (<>ThermoAbort)
		$i:=$k
	End if 
	If ([Item:4]itemNum:1#[OrderLine:49]itemNum:4)
		QUERY:C277([Item:4]; [Item:4]itemNum:1=[OrderLine:49]itemNum:4)
	End if 
	[OrderLine:49]typeItem:24:=[Item:4]typeid:26
	[OrderLine:49]profile1:32:=[Item:4]profile1:35
	[OrderLine:49]profile2:33:=[Item:4]profile2:36
	[OrderLine:49]profile3:34:=[Item:4]profile3:37
	[OrderLine:49]profile4:35:=[Item:4]profile4:38
	[OrderLine:49]class:53:=[Item:4]class:92
	
	If ([OrderLine:49]itemNum:4="ZZZTEM@")
		PUSH RECORD:C176([Customer:2])
		QUERY:C277([Customer:2]; [Customer:2]mfrLocationid:67=[OrderLine:49]location:22)
		[OrderLine:49]vendorID:42:=[Customer:2]customerID:1
		[OrderLine:49]mfrID:52:=[Customer:2]customerID:1
		POP RECORD:C177([Customer:2])
	Else 
		[OrderLine:49]vendorID:42:=[Item:4]vendorID:45
		[OrderLine:49]mfrID:52:=[Item:4]mfrID:53
	End if 
	
	SAVE RECORD:C53([OrderLine:49])
	NEXT RECORD:C51([OrderLine:49])
End for 
READ WRITE:C146([Item:4])
READ ONLY:C145([OrderLine:49])
//Thermo_Close 
Progress QUIT($viProgressID)
