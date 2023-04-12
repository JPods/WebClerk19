//%attributes = {}

// Modified by: Bill James (2022-06-24T05:00:00Z)
// Method: Init_obSetup
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($dataClassName : Text)->$result : Object
var $rec_o : Object
$rec_o:=ds:C1482.DefaultSetup.query("tableName = :1 AND variableName = :2 AND machine = :3 "; $dataClassName; "setupRecord"; Current machine:C483)
If ($rec_o.length=0)
	$rec_o:=ds:C1482.DefaultSetup.query("tableName = :1 AND variableName = :2 AND machineOwner = :3 "; $dataClassName; "setupRecord"; Current user:C182)
	If ($rec_o.length=0)
		$rec_o:=ds:C1482.DefaultSetup.query("tableName = :1 AND variableName = :2 AND machineOwner = :3 "; $dataClassName; "setupRecord"; "default")
		If ($rec_o.length=0)
			$rec_o:=ds:C1482.DefaultSetup.new()
			$rec_o.tableName:=$dataClassName
			$rec_o.variableName:="setupRecord"
			$rec_o.machineOwner:="default"
			$rec_o.obSetup:=New object:C1471
			$rec_o.save()
			var $file_o; $folder_o : Object
			$folder_o:=Folder:C1567(fk user preferences folder:K87:10)
			If ($folder_o.exists=False:C215)
				$created:=Folder:C1567(fk user preferences folder:K87:10).create()
			End if 
		End if 
	End if 
End if 
$result:=$rec_o.obSetup
//$result:=New object(

