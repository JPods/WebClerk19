//%attributes = {"publishedWeb":true}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 2017-09-19T00:00:00, 20:01:08
// ----------------------------------------------------
// Method: ConvertData
// Description
// Modified: 09/19/17
// Structure: CE11zx_01
// 
//
// Parameters
// ----------------------------------------------------





FIRST RECORD:C50([Customer:2])
$k:=Records in selection:C76([Customer:2])
//ThermoInitExit ("Converting Customers Last Name";$k;True)
For ($i; 1; $k)
	If ([Customer:2]nameLast:23#"")
		Parse_UnWanted(process_o.entry_o.nameLast)
		SAVE RECORD:C53([Customer:2])
	End if 
	NEXT RECORD:C51([Customer:2])
End for 
UNLOAD RECORD:C212([Customer:2])




FIRST RECORD:C50([Contact:13])
$k:=Records in selection:C76([Contact:13])
//ThermoInitExit ("Converting Customers Last Name";$k;True)
For ($i; 1; $k)
	If ([Contact:13]nameLast:4#"")
		Parse_UnWanted(process_o.entry_o.NameLast)
		SAVE RECORD:C53([Contact:13])
	End if 
	NEXT RECORD:C51([Contact:13])
End for 
UNLOAD RECORD:C212([Contact:13])