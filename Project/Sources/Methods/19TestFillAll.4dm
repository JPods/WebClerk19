//%attributes = {}

// Modified by: Bill James (2022-04-08T05:00:00Z)
// Method: 19TestFillAll
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($ents : Object)
var $tableName : Text
If (aSalesTables>0)
	$tableName:=aSalesTables{aSalesTables}
	//If ($ents.length=0)
	//$ents:=ds[$tableName].all()
	//End if 
	If (LB_Included.ents.length=0)
		LB_Included.ents:=ds:C1482[process_o.tableName].all()
	End if 
End if 