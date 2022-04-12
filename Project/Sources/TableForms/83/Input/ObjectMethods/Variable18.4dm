entryEntity.nameid:=DE_PopUpArray(Self:C308)
If ([Requisition:83]nameid:9#Old:C35([Requisition:83]nameid:9))
	$tempStr:="Requisition Assigned to "+[Requisition:83]nameid:9+"."
	// zzzqqq jDateTimeStamp(->[Requisition:83]logText:37; $tempStr)
End if 