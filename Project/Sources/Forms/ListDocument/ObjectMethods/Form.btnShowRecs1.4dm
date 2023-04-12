
var $doMore : Boolean
$doMore:=False:C215
If ((document_o.sel=Null:C1517) & (document_o.cur=Null:C1517) & (LBDocument.data=Null:C1517))
	// do nothing
Else 
	var $new_o : Object
	$new_o:=New object:C1471("ents"; New object:C1471)
	If (document_o.sel.length>0)
		$new_o.data:=document_o.sel
	Else 
		$new_o.data:=document_o.data
	End if 
	DB_ShowCurrentObject("Document"; $new_o)
End if 