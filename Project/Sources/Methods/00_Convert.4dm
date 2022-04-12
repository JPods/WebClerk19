//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 09/21/21, 12:18:51
// ----------------------------------------------------
// Method: 00_Convert
// Description
// 
// Parameters
// ----------------------------------------------------

var obRec; obSel : Object
obSel:=ds:C1482.RemoteUser.all()
For each (obRec; obSel)
	obRec.tableNum:=STR_GetTableNumber(obRec.tableName)
	obRec.save()
End for each 