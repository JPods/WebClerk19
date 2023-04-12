//%attributes = {}

// Modified by: Bill James (2022-07-15T05:00:00Z)
// Method: Request_UniqueName
// Description 
// Parameters
// ScriptSet
// ----------------------------------------------------
#DECLARE($nameView : Object)
$tm_o:=ds:C1482.TallyMaster.query("purpose = :1 and tableName = :2 and name = :3"; "Databrowser"; Form:C1466.dataClassName).first()
$nameView:=Request:C163("Name of this view"+((", "+$nameView+" is taken.")*($nameView#""))+"?"; $nameView)
