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





FIRST RECORD:C50([QQQCustomer:2])
$k:=Records in selection:C76([QQQCustomer:2])
//ThermoInitExit ("Converting Customers Last Name";$k;True)
For ($i; 1; $k)
	If ([QQQCustomer:2]nameLast:23#"")
		Parse_UnWanted(entryEntity.nameLast)
		SAVE RECORD:C53([QQQCustomer:2])
	End if 
	NEXT RECORD:C51([QQQCustomer:2])
End for 
UNLOAD RECORD:C212([QQQCustomer:2])




FIRST RECORD:C50([QQQContact:13])
$k:=Records in selection:C76([QQQContact:13])
//ThermoInitExit ("Converting Customers Last Name";$k;True)
For ($i; 1; $k)
	If ([QQQContact:13]NameLast:4#"")
		Parse_UnWanted(entryEntity.NameLast)
		SAVE RECORD:C53([QQQContact:13])
	End if 
	NEXT RECORD:C51([QQQContact:13])
End for 
UNLOAD RECORD:C212([QQQContact:13])