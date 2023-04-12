//%attributes = {}

// ----------------------------------------------------
// User name (OS): Bill James
// Date and time: 11/05/21, 00:37:55
// ----------------------------------------------------
// Method: 00FixRemoteUserTableName
// Description
// 
// Parameters
// ----------------------------------------------------
var $rec_ent; $sel_ent : Object
$sel_ent:=ds:C1482.RemoteUser.all()
For each ($rec_ent; $sel_ent)
	If (ds:C1482[$rec_ent.tableName]=Null:C1517)
		If (($rec_ent.tableNum>0) & ($rec_ent.tableNum<=Get last table number:C254))
			$rec_ent.tableName:=Table name:C256($rec_ent.tableNum)
		Else 
			$rec_ent.securityLevel:=-111
		End if 
		$rec_ent.save()
	End if 
End for each 