C_LONGINT:C283($p)
$p:=Position:C15("zzz"; [WorkOrder:66]Description:3)
If ($p=0)
	BEEP:C151
	BEEP:C151
Else 
	HIGHLIGHT TEXT:C210([WorkOrder:66]Description:3; $p; $p+3)
End if 