//%attributes = {"publishedWeb":true}
var $rec_ent; $sel_ent : Object
$sel_ent:=ds:C1482.Document.query("path # :1"; "")
For each ($rec_ent; $sel_ent)
	If ($rec_ent.obGeneral=Null:C1517)
		$rec_ent.obGeneral:=Init_obGeneral
	End if 
	
	If (Test path name:C476($path)>-1)
		
	Else 
		
		
	End if 
	
	$rec_ent.save()
End for each 