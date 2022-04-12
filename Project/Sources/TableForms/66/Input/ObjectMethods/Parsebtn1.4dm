
ON ERR CALL:C155("OEC_Web")
C_TEXT:C284($thePath)
error:=0
iLoText4:=Replace string:C233(iLoText4; "\\r"; "")
iLoText4:=Replace string:C233(iLoText4; "\\t"; "")
iLoText4:=Replace string:C233(iLoText4; "\\t"; "")
iLoText5:=JSON Parse:C1218(iLoText4)
[WorkOrder:66]ObRelated:71:=JSON Parse:C1218(iLoText5)
// OB SET([WorkOrder]ObjRelated;iLoText5)
If (error#0)
	ALERT:C41("Error: ."+String:C10(error))
End if 
ON ERR CALL:C155("")