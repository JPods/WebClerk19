//%attributes = {}
#DECLARE($rec_o : Object; $change_c : Collection)
If ($rec_o.obGeneral=Null:C1517)
	$rec_o.obGeneral:=Init_obGeneral
End if 
If ($rec_o.obGeneral.history=Null:C1517)
	$rec_o.obGeneral.history:=New collection:C1472
End if 
If (Value type:C1509($rec_o.obGeneral.history)#Is collection:K8:32)
	$rec_o.obGeneral.history:=New collection:C1472
End if 
$rec_o.obGeneral.history.push(New object:C1471("revision"; $rec_o.obGeneral.history.length; \
"created"; Current date:C33; \
"changes"; $change_c))
