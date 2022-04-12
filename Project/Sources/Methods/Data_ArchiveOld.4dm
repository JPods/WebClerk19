//%attributes = {"publishedWeb":true}

// Modified by: Bill James (2022-01-28T06:00:00Z)
// Method: Data_ArchiveOld
// Description 
// Parameters
// ----------------------------------------------------
var $1; $o : Object

If (Count parameters:C259=1)
	$o:=$1
Else 
	$o:=process_o.old
End if 

var $new_o : Object
If (process_o.old#Null:C1517)
	If (Storage:C1525.archiveDo[$o.tableName])
		$new_o:=ds:C1482.Archive.new()
		$new_o.dtDocument:=DateTime_Enter
		$new_o.idDoc:=$o.id
		$new_o.TableName:=$o.tableName
		$new_o.old:=$o
		$new_o.save()
	End if 
End if 
