entryEntity.approvalCood:=DE_PopUpArray(Self:C308)
If ([Requisition:83]approvalCood:16#Old:C35([Requisition:83]approvalCood:16))
	$tempStr:="Other1 released "+[Requisition:83]approvalCood:16+"."
	// zzzqqq jDateTimeStamp(->[Requisition:83]logText:37; $tempStr)
	vDate3:=Current date:C33
	vTime3:=Current time:C178
	[Requisition:83]dtApprCood:17:=DateTime_Enter
End if 