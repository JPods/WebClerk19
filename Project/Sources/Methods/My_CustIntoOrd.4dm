//%attributes = {"publishedWeb":true}
C_LONGINT:C283($k; $i)
FIRST RECORD:C50([Order:3])
$k:=Records in selection:C76([Order:3])
//ThermoInitExit ("Checking Invoice Commissions";$k;True)
$viProgressID:=Progress New

For ($i; 1; $k)
	//Thermo_Update ($i)
	ProgressUpdate($viProgressID; $i; $k; "Checking Invoice Commissions")
	If (<>ThermoAbort)
		$i:=$k
	End if 
	If ([Order:3]customerid:1#"")
		If ([Customer:2]customerID:1#[Order:3]customerid:1)
			QUERY:C277([Customer:2]; [Customer:2]customerID:1=[Order:3]customerid:1)
		End if 
		If (Record number:C243([Customer:2])>-1)
			LoadCustOrder
		Else 
			[Order:3]company:15:="Missing "+[Order:3]company:15
		End if 
		SAVE RECORD:C53([Order:3])
	End if 
	NEXT RECORD:C51([Order:3])
End for 
//Thermo_Close 
Progress QUIT($viProgressID)
UNLOAD RECORD:C212([Order:3])

//HtmlMenuMaker