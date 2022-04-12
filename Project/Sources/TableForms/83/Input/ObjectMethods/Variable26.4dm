entryEntity.approvalPur:=DE_PopUpArray(Self:C308)
If ([Requisition:83]approvalPur:14#Old:C35([Requisition:83]approvalPur:14))
	$tempStr:="Purchasing released "+[Requisition:83]approvalPur:14+"."
	// zzzqqq jDateTimeStamp(->[Requisition:83]logText:37; $tempStr)
	vDate2:=Current date:C33
	vTime2:=Current time:C178
	[Requisition:83]dtApprPurch:15:=DateTime_Enter
End if 