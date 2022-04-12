//%attributes = {"publishedWeb":true}
var $rec_ent; $sel_ent : Object
$sel_ent:=ds:C1482.Document.query("path # :1"; "")
For each ($rec_ent; $sel_ent)
	If ($rec_ent.obGeneral=Null:C1517)
		$rec_ent.obGeneral:=New object:C1471("health"; New collection:C1472)
	End if 
	
	If (Test path name:C476($path)>-1)
		
	Else 
		
		
	End if 
	
	$rec_ent.save()
End for each 