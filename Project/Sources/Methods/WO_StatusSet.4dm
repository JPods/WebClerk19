//%attributes = {"publishedWeb":true}
//WO_StatusSet("String")
C_TEXT:C284($1; $newStatus)
C_LONGINT:C283($k; $i)
If (Count parameters:C259=0)
	$newStatus:=""
Else 
	$newStatus:=$1
End if 
If ($newStatus#"")
	CONFIRM:C162("Apply Status of: "+$newStatus)
	If (OK=1)
		$k:=Records in selection:C76([WorkOrder:66])
		ARRAY TEXT:C222($aStatus; $k)
		For ($i; 1; $k)
			$aStatus{$i}:=$newStatus
		End for 
		READ WRITE:C146([WorkOrder:66])
		LOAD RECORD:C52([WorkOrder:66])
		ARRAY TO SELECTION:C261($aStatus; [WorkOrder:66]Action:33)
		READ ONLY:C145([WorkOrder:66])
	End if 
End if 