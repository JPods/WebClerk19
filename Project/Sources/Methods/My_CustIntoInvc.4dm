//%attributes = {"publishedWeb":true}
C_LONGINT:C283($k; $i)
FIRST RECORD:C50([Invoice:26])
$k:=Records in selection:C76([Invoice:26])
//ThermoInitExit ("Entering Addresses";$k;True)
$viProgressID:=Progress New

For ($i; 1; $k)
	//Thermo_Update ($i)
	ProgressUpdate($viProgressID; $i; $k; "Entering Addresses")
	If (<>ThermoAbort)
		$i:=$k
	End if 
	If ([Invoice:26]customerid:3#"")
		If ([Customer:2]customerID:1#[Invoice:26]customerid:3)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Invoice:26]customerid:3)
		End if 
		If (Record number:C243([Customer:2])>-1)
			LoadCustomersInvoices
		Else 
			[Invoice:26]company:7:="Missing "+[Invoice:26]company:7
		End if 
		SAVE RECORD:C53([Invoice:26])
	End if 
	NEXT RECORD:C51([Invoice:26])
End for 
//Thermo_Close 
Progress QUIT($viProgressID)
UNLOAD RECORD:C212([Invoice:26])