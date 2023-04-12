//%attributes = {}

// Modified by: Bill James (2023-01-22T06:00:00Z)
// Method: IE_GetFileObj
// Description 
// Parameters
// ----------------------------------------------------
#DECLARE($path_t)->$file_o : Object

If ($path_t="")
	$time:=Open document:C264(""; Read mode:K24:5)
	If (OK=1)
		CLOSE DOCUMENT:C267($time)
		$path_t:=document
	End if 
End if 
If ($path_t#"")
	$file_o:=File:C1566($path_t)  //; fk platform path)
End if 
